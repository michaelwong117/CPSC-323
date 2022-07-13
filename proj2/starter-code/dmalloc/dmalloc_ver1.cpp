#define M61_DISABLE 1
#include "dmalloc.hh"
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cinttypes>
#include <cassert>
#include <unordered_map>
#include <iostream>
#include <math.h>

// You may write code here.
// (Helper functions, types, structs, macros, globals, etc.)

// dmalloc header metadata after payload
typedef struct dmalloc_header { 

    dmalloc_header * next;
    long line;
    size_t sz;
    void * ptr;
    size_t diff;
    unsigned int present;
    const char * file;

} header;

typedef struct file_line {
    long line;
    const char * file;

} file_line;

typedef struct alloc_sz {
    long long inset_sz;
    long long actual_size;
} alloc_sz;



std::unordered_map<void *, size_t> map_SZ;
std::unordered_map<void *, long> hasbeen_alloced; // stores line number
std::unordered_map<file_line *, alloc_sz *> map_file_line;

header * list;

size_t canary_sz = 32;

// all pointers that have ever been malloced, tell double free from not in heap

struct dmalloc_statistics g_stats = {0, 0, 0, 0, 0, 0, 0, 0}; // min max might be different 

/**
 struct dmalloc_statistics {
    unsigned long long nactive;         // # active allocations
    unsigned long long active_size;     // # bytes in active allocations
    unsigned long long ntotal;          // # total allocations
    unsigned long long total_size;      // # bytes in total allocations
    unsigned long long nfail;           // # failed allocation attempts
    unsigned long long fail_size;       // # bytes in failed alloc attempts
    uintptr_t heap_min;                 // smallest allocated addr
    uintptr_t heap_max;                 // largest allocated addr
};
**/

/// dmalloc_malloc(sz, file, line)
///    Return a pointer to `sz` bytes of newly-allocated dynamic memory.
///    The memory is not initialized. If `sz == 0`, then dmalloc_malloc must
///    return a unique, newly-allocated pointer value. The allocation
///    request was at location `file`:`line`.

// printf("%p\n%p\n", (void *)ptr1, (void *)ptr2);

void add_active(void * p, size_t sz, long line)
{
    g_stats.nactive++;
    g_stats.active_size += (long long) sz;
    g_stats.ntotal++;
    g_stats.total_size += (long long) sz;

    if (!g_stats.heap_min || g_stats.heap_min > (uintptr_t) p) 
    {
        g_stats.heap_min = (uintptr_t) p;
    }
    if (!g_stats.heap_max || g_stats.heap_max < (uintptr_t) p + sz) 
    {
        g_stats.heap_max = (uintptr_t) p + sz;
    }

    map_SZ.insert(std::pair(p, sz));
    hasbeen_alloced.insert(std::pair(p, line));
}


// void print_map(std::unordered_map<file_line *, alloc_sz *> m)
// {
//     std::unordered_map<file_line *, alloc_sz *>::iterator it;
//     for (it = m.begin(); it != m.end(); it++)
//     {
//         file_line * curr = it->first;
//         long long bytes = map_file_line[curr]->actual_size;
//         double percent = ((double) bytes / (double) g_stats.total_size) * 100;
//         printf("HEAVY HITTER: %s:%ld: %llu bytes (~%.1f%%)\n", curr->file, curr->line, bytes, percent);
//         //HEAVY HITTER: hhtest.cc:48: 817311692 bytes (~25.0%)
//     } 
// }

void* dmalloc_malloc(size_t sz, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings
    // Your code here.

    void * check = base_malloc(sz);
    if (check == NULL)
    {
        g_stats.nfail++;
        g_stats.fail_size += sz;
        return NULL;
    }
    else
    {
        base_free(check);
    }
    
    // printf("total size: %zu\n", canary_sz + sz + canary_sz);
    // printf("without canary size: %zu\n", sz);


    void * underflow_p = base_malloc(canary_sz + sz + canary_sz + sizeof(header));
    void * overflow_p = (void *) ((uintptr_t) (underflow_p) + canary_sz + sz); // start of overflow canary
    void * header_p = (void *) ((uintptr_t) (underflow_p) + canary_sz + sz + canary_sz);
    void * p = (void *) ((uintptr_t) (underflow_p) + canary_sz); // user address malloc

    header * h = (header *) header_p;
    h->ptr = p;
    h->sz = sz;
    h->line = line;
    
    h->next = list;
    list = h;


    // printf("MALLOC underflow: %p, overflow: %p\n", underflow_p, overflow_p);

    *((unsigned int *) overflow_p) = 0xdeadbeef; 
    *((unsigned int *) underflow_p) = 0xdeadbeef;

    // printf("MALLOC underflow: %d, overflow: %d\n", *((unsigned int *) overflow_p), *((unsigned int *) underflow_p));

    // printf("user address malloc in dmalloc: %p\n", p);
  
    add_active(p, sz, line);

    file_line * f = (file_line *) base_malloc(sizeof(file_line));
    f->file = file;
    f->line = line;
    // printf("mallocing size %zu at %s:%ld\n", sz, f->file, f->line);

    bool found_in_map = 0;
    // file_line * found_fl;

    std::unordered_map<file_line *, alloc_sz *>::iterator look;

    for (look = map_file_line.begin(); look != map_file_line.end(); look++)
    {
        file_line * curr = look->first;
        if (curr->line == line && strcmp(curr->file, f->file) == 0)
        {
            found_in_map = 1; 
            break;
        }
    } 

    if (found_in_map)
    {
        // printf("found %s:%ld!, adding %zu bytes to size\n", file, line, sz);
        look->second->actual_size += (long long) sz;
        look->second->inset_sz += (long long) sz;
    }
    else
    {
        // printf("inserting new %s:%ld! with %zu bytes\n", file, line, sz);
        alloc_sz * bytes = (alloc_sz *) base_malloc(sizeof(alloc_sz));
        bytes->actual_size = sz;
        bytes->inset_sz = sz;
        map_file_line.insert(std::pair(f, bytes));
    }
    // print_map(map_file_line);
    if (map_file_line.size() > 5)
    {
        std::unordered_map<file_line *, alloc_sz *>::iterator it;
        long long min = 1e18; file_line * min_file;
        // get minimum value and file
        for (it = map_file_line.begin(); it != map_file_line.end(); it++)
        {
            if (min > it->second->inset_sz)
            {
                min = it->second->inset_sz;
                min_file = it->first;
            }
        } 
        for (it = map_file_line.begin(); it != map_file_line.end(); it++)
        {
            it->second->inset_sz -= min; // subtract the minimum size in bytes
        } 
        map_file_line.erase(min_file);
    }
    // print_map(map_file_line);

    return p;
}


/// dmalloc_free(ptr, file, line)
///    Free the memory space pointed to by `ptr`, which must have been
///    returned by a previous call to dmalloc_malloc. If `ptr == NULL`,
///    does nothing. The free was called at location `file`:`line`.

void dmalloc_free(void* ptr, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings
    // Your code here.
    if (ptr == NULL) return;

    // printf("user address malloc in free: %p\n", ptr);

    g_stats.nactive--; // subtract from number of active allocations

    std::unordered_map<void *, size_t>::iterator active;
    std::unordered_map<void *, long>::iterator was_alloced;
    active = map_SZ.find(ptr);
    was_alloced = hasbeen_alloced.find(ptr);

    if (active != map_SZ.end()) // if we found the ptr was malloc'd, 
    {
        void * underflow_p = (void *) ((uintptr_t) ptr - canary_sz);
        void * overflow_p = (void *) ((uintptr_t) ptr + map_SZ[ptr]);

        // printf("FREE underflow: %p, overflow: %p\n", underflow_p, overflow_p);
        // printf("FREE underflow: %d, overflow: %d\n", *((unsigned int *) overflow_p), *((unsigned int *) underflow_p));

        if (*((unsigned int *) overflow_p) != 0xdeadbeef 
                || *((unsigned int *) underflow_p) != 0xdeadbeef)
        {
            fprintf(stderr, "MEMORY BUG: detected wild write during free of pointer %p\n", ptr);
            exit(-1);
        }

        g_stats.active_size -= active->second;
        map_SZ.erase(active);
        base_free(underflow_p);
    }
    else if (was_alloced != hasbeen_alloced.end()) // was malloced at one point
    {
        fprintf(stderr, "MEMORY BUG :%s:%ld: invalid free of pointer %p, double free\n", file, line, ptr);
        exit(-1);
        
    }
    else if ((uintptr_t) ptr < g_stats.heap_min || (uintptr_t) ptr > g_stats.heap_max)
    {
        fprintf(stderr, "MEMORY BUG :%s:%ld: invalid free of pointer %p, not in heap\n", file, line, ptr);
        exit(-1);
    }
    else
    {
        fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not allocated\n", file, line, ptr);

        header * curr = list;
        // printf("attempting to free pointer %p with size %zu\n", ptr, map_SZ[ptr]);
        // printf("uintptr_t form of %p: %ld\n", ptr, (uintptr_t) ptr);
        while (curr != NULL)
        {
            // printf("in list: pointer %p with size %zu\n", curr->ptr, curr->sz);
            // printf("uintptr_t form of %p: %ld\n", curr->ptr, (uintptr_t) curr->ptr);
            if ((uintptr_t) ptr > (uintptr_t) curr->ptr)
            {
                if ((uintptr_t) curr->ptr + curr->sz > (uintptr_t) ptr)
                {
                    size_t diff = (uintptr_t) ptr - (uintptr_t) curr->ptr; // how many bytes inside
                    long ln = curr->line;
                    size_t sz = curr->sz;

                    printf("  test0xx.cc:%ld: %p is %zu bytes inside a %zu byte region allocated here\n", ln, ptr, diff, sz);

                }
            //!   test???.cc:8: ??? is 128 bytes inside a 2001 byte region allocated here                }
            }
            curr = curr->next;
        }
        exit(-1);
    }
    return;
}


/// dmalloc_calloc(nmemb, sz, file, line)
///    Return a pointer to newly-allocated dynamic memory big enough to
///    hold an array of `nmemb` elements of `sz` bytes each. If `sz == 0`,
///    then must return a unique, newly-allocated pointer value. Returned
///    memory should be initialized to zero. The allocation request was at
///    location `file`:`line`.

void* dmalloc_calloc(size_t nmemb, size_t sz, const char* file, long line) {
    // Your code here (to fix test014).
    if (nmemb >= SIZE_MAX / sz) // equivalent: nmemb * sz >= SIZE_MAX
    {
        g_stats.nfail++;
        g_stats.fail_size += (long long) nmemb * (long long) sz;
        return nullptr;
    }
    // printf("nmemb: %zu sz: %zu\n", nmemb, sz);
    // printf("total memory %zu versus SIZE_MAX: %zu\n", nmemb * sz, SIZE_MAX);
    // printf("%zu\n", SIZE_MAX);

    void* ptr = dmalloc_malloc(nmemb * sz, file, line);
    if (ptr) {
        memset(ptr, 0, nmemb * sz);
    }
    return ptr;
}


/// dmalloc_get_statistics(stats)
///    Store the current memory statistics in `*stats`.

void dmalloc_get_statistics(dmalloc_statistics* stats) {
    // Stub: set all statistics to enormous numbers
    memset(stats, 255, sizeof(dmalloc_statistics));
    // Your code here.
    *stats = g_stats;
}


/// dmalloc_print_statistics()
///    Print the current memory statistics.

void dmalloc_print_statistics() {
    dmalloc_statistics stats;
    dmalloc_get_statistics(&stats);

    printf("alloc count: active %10llu   total %10llu   fail %10llu\n",
           stats.nactive, stats.ntotal, stats.nfail);
    printf("alloc size:  active %10llu   total %10llu   fail %10llu\n",
           stats.active_size, stats.total_size, stats.fail_size);
    
}


/// dmalloc_print_leak_report()
///    Print a report of all currently-active allocated blocks of dynamic
///    memory.

void dmalloc_print_leak_report() {
    // Your code here.

    std::unordered_map<void *, size_t>::iterator it;

    for (it = map_SZ.begin(); it != map_SZ.end(); it++)
    {
        void * ptr = it->first;
        size_t sz = it->second;
        long line = hasbeen_alloced[it->first];

        printf("LEAK CHECK: test0xx.cc:%ld: allocated object %p with size %zu\n", line, ptr, sz);
                        //  LEAK CHECK: test???.cc:16: allocated object ??ptr?? with size ??size??
                        //  LEAK CHECK: test029.cc:16: allocated object 0xe21d00 with size 8
    }
}

// int comp (const void * a, const void * b)
// {


//   order *orderA = (order *)a;
//   order *orderB = (order *)b;

//   return ( orderB->price - orderA->price );
// }

int comp(const void * p1, const void * p2)
{
    std::pair<long long, file_line *> * pair1 = (std::pair<long long, file_line *> *) p1;
    std::pair<long long, file_line *> * pair2 = (std::pair<long long, file_line *> *) p2;
    // const std::pair<long long, file_line *> pair1 = 
    // const std::pair<long long, file_line *> &p1, const std::pair<long long, file_line *> &p2
    return pair1->first < pair2->first;
}

/// dmalloc_print_heavy_hitter_report()
///    Print a report of heavily -used allocation locations.

void dmalloc_print_heavy_hitter_report() {
    // Your heavy-hitters code here
    std::pair<long long, file_line *> arr[5];
    size_t i = 0;
    std::unordered_map<file_line *, alloc_sz *>::iterator it;
    for (it = map_file_line.begin(); it != map_file_line.end(); it++)
    {
        file_line * curr = it->first;
        long long bytes = map_file_line[curr]->actual_size;
        arr[i] = std::pair(bytes, curr); i++;
        // double percent = ((double) bytes / (double) g_stats.total_size) * 100;
        // printf("HEAVY HITTER: %s:%ld: %llu bytes (~%.1f%%)\n", curr->file, curr->line, bytes, percent);
    } 
    // printf("total bytes: %llu\n", g_stats.total_size);
    std::qsort(arr, map_file_line.size(), sizeof(std::pair<long long, file_line *>), comp);
    for (i = 0; i < map_file_line.size(); i++)
    {
        file_line * curr = arr[i].second;
        long long bytes = arr[i].first;
        double percent = ((double) bytes / (double) g_stats.total_size) * 100;
        if (round(percent) > 1) printf("HEAVY HITTER: %s:%ld: %llu bytes (~%.1f%%)\n", curr->file, curr->line, bytes, percent);
        //HEAVY HITTER: hhtest.cc:48: 817311692 bytes (~25.0%)
    }
    
    // arr[5].first = bytes;
    // arr[5].second = curr;



}
