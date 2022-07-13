#include "malloc.h"
#include "process.h"

#define MIN_ALLOC_SIZE PAGESIZE
#define ALIGNMENT 8
#define ALIGN(size) (((size) + (ALIGNMENT-1)) & ~(ALIGNMENT-1))
#define SIZE_MAX (uint64_t) -1


// free linked list header struct

typedef struct header_list {

    struct header_list * next;
    uint64_t sz;
    unsigned int is_allocated;
} header_list; // each one of these is a header to a free segment

#define HEADER_SZ ALIGN(sizeof(header_list))

int init_malloc;

header_list *head;

header_list * find_free_block(uint64_t block_sz)
{
    // it could be that as I keep going further and further into I reach into addresses
    // that are in the kernel space and then we have a read protection problem because of that
    // trying to read addresses at curr that are in kernel space

    for (header_list * curr = head; curr != NULL; curr = curr->next)
    {
        // if not allocated by curr and by info, free
        if (curr->is_allocated == 0)
        {
            if (curr->sz >= block_sz)
            {
                return curr;
            }
        }
    }
    return NULL;
}

//structure of malloc implementation is following the lectures 
int mm_init()
{
    sbrk(sizeof(header_list));
    retrieve_payload(head) = sbrk(0);
    
    first_bp_header->size = 0;
    first_bp_header->allocated = 0;
    
    init_run = 1;
    return 0;
}
int mm_init()
{
    sbrk(sizeof(block_header));
    first_bp = sbrk(0);
    
    block_header* first_bp_header = get_header(first_bp);
    first_bp_header->size = 0;
    first_bp_header->allocated = 0;
    
    init_run = 1;
    return 0;
}


void * retrieve_payload(void * header_pt)
{
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
    return payload;
}

header_list * retrieve_header(void * mem_payload)
{
    void * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
    return header;
}

// add the block either to the head of the free list or to the end
void add_block_to_list(header_list * new)
{
    new->next = NULL;
    new->is_allocated = 0; // set the allocated flag to 0: this is the free list

    // if the head is NULL, set the new block to be the head of the list
    if (head == NULL)
    {
        new->next = head;
        head = new;
    }
    else if ((uintptr_t) new < (uintptr_t) head)
    {   // the new free block is earlier in the heap than the head, add to front of free list
        new->next = head;
        head = new;
    }
    else
    { // append the new free block to the end of the list
        for (header_list * last = head; last != NULL; last = last->next)
        {
            // curr is the last block in the list
            if (last->next == NULL)
            {   // new becomes the last block in the list
                last->next = new;
                return;
            }
        }
    }
}

// split block to get the memory we need and release the surplus
void divide_block(header_list * free_block, uint64_t malloc_sz)
{
    // What happens if a block, when split, creates a free-list node that is too small to be properly typecast? 
    // In that case, it is okay to just use the entire free block for the allocation.

    // if the free block is too small to fit another header along with the malloc, don't split
    if (free_block->sz < HEADER_SZ + malloc_sz) return;

    // We split the existing free block into two parts:
    // 1) One that is used for the malloc
    // 2) One that is free space that will be appended back to the free list

    // this is 2) the memory after malloc in the original free_block
    header_list * new_block = (header_list *) ((uintptr_t) malloc_sz + (uintptr_t) free_block);
    
    // set the size of the new block to what's leftover after the malloc
    new_block->sz = free_block->sz - malloc_sz;

    // set the size of the old block to just the malloc
    free_block->sz = malloc_sz;

    add_block_to_list(new_block);
}
// initalizing a new block of free memory
void init_new_block(header_list * new_block, uint64_t sz)
{
    if (sz < MIN_ALLOC_SIZE) new_block->sz = MIN_ALLOC_SIZE;
    else new_block->sz = sz;

    new_block->next = NULL;
    new_block->is_allocated = 0;
}
header_list * expand_heap(uint64_t block_sz)
{ // takes in an aligned block size
    // expand heap for both the header_list header and the block of memory
    uint64_t brk_inc;
    if (block_sz < MIN_ALLOC_SIZE) brk_inc = MIN_ALLOC_SIZE;
    else brk_inc = block_sz;
    
    uintptr_t brk_header = (uintptr_t) sbrk(brk_inc);
    if (brk_header == (uintptr_t) -1) return NULL;

    return (header_list *) brk_header;

}

void free(void *firstbyte) {
    if (firstbyte == NULL) return;

    for (header_list * curr = head; curr != NULL; curr = curr->next)
    {
        if (curr->is_allocated == 1)
        {
            if (retrieve_payload(curr) == firstbyte)
            {
                curr->is_allocated = 0;
                return;
            }
        }
    }
}
void * malloc(uint64_t numbytes)
{
    if (numbytes <= 0 || numbytes >= SIZE_MAX)
    {
        return NULL;
    }
    // size of the block we want to malloc + the header
    uint64_t malloc_block_sz = ALIGN(HEADER_SZ + numbytes);  
    count_sz = malloc_block_sz;

    // app_printf(0, "MALLOCING %ld bytes!\n", malloc_block_sz);

    // find a free block that the malloc block can fit into
    header_list * free_block = find_free_block(malloc_block_sz);

    //  If a block is not found, the heap is expanded and added to the free list in some way.
    if (free_block == NULL)
    {
        header_list * brk_start = (header_list *) expand_heap(malloc_block_sz);

        if (brk_start == NULL)
        {
            // app_printf(0, "RETURNING NULL: too large to brk\n");
            return NULL;
        }

        free_block = brk_start; // the free block starts at the new brk_start

        // we initalize info for the new block, and
        // set the size of the new free block to be equal to the size of our malloc block
        init_new_block(free_block, malloc_block_sz);

        // add this space to our free list
        add_block_to_list(free_block);
    }

    // IN OTHER CASES, this will not be true as find_free_block
    // will return a suitable free block that could be much bigger

    assert(free_block != NULL);
    // now, we have our valid free_block
    // the size of the free block and the heap expansion should be at minimum one page
    // the malloc block size can be much smaller

    divide_block(free_block, malloc_block_sz);

    free_block->is_allocated = 1;

    return retrieve_payload(free_block);
}

void * calloc(uint64_t num, uint64_t sz) 
{
    if (num <= 0 || sz <= 0) return NULL;
    if (num >= SIZE_MAX / sz) return NULL;

    void * ptr = malloc(num * sz);

    if (ptr != NULL)
    {
        memset(ptr, 0, num * sz);
    }

    return ptr;
}


void * realloc(void * ptr, uint64_t sz) {
    // if pointer is null, same as malloc for all sizes
    if (ptr == NULL) return malloc(sz);
    // if size is zero and the ptr isn't NULL, simply free ptr
    if (sz == 0)
    {
        free(ptr); return NULL;
    }
    if (sz >= SIZE_MAX)
    {
        return NULL;
    }
    // the contents will be unchanged in the range from the start of the region up to the
    // minimum of the old and new sizes

    // the start of the region is at ptr
    // if the new size is less than the old size, leave it unchanged
    uint64_t block_sz = retrieve_header(ptr)->sz;  // original size of block at ptr
    
    if (block_sz > sz) return ptr;

    // realloc changes the size of the memory block pointed to by ptr to size bytes.

    header_list * new_block = malloc(sz);

    if (new_block == NULL) return NULL;

    // retrieve and copy over the header_b information
    // from the given realloc ptr to the new_block
    memcpy(new_block, ptr, block_sz);

    free(ptr); // free the old pointer
    
    return new_block;
}

void defrag() {
    // for (header_list * curr = head; curr->next != NULL; curr = curr->next)
    // {
    //     header_list * adj = curr->next;

    //     if (curr->is_allocated == 0 && adj->is_allocated == 0)
    //     {
    //         curr->sz += adj->sz;
    //     }
    // }
}

void merge_array(long *array, int start, int mid, int end, uintptr_t * ptr_array)  
{
     long sorted[end - start + 1];
     uintptr_t sorted_ptr[end - start + 1];
     int a = 0;
     int b = start;
     int c = mid + 1;
     while(b <= mid && c <= end)
     {
            if(array[b] > array[c])
            {
                sorted[a] = array[b];
                sorted_ptr[a] = ptr_array[b];
                a++; b++;
            }
            else
            {
                sorted[a] = array[c];
                sorted_ptr[a] = ptr_array[c];
                a++; c++;
            }
     }

     while(b <= mid) 
     {
         sorted[a] = array[b];
         sorted_ptr[a] = ptr_array[b];
         a++; b++;
     }
     while(c <= end)
     {
        sorted[a] = array[c];
        sorted_ptr[a] = ptr_array[c];
        a++; c++;
     }
     int i;
     for(i = 0; i < a; i++) 
     {
        array[i + start] = sorted[i];
        ptr_array[i + start] = sorted_ptr[i];
     }
}

void merge_sort(long * array, int start, int end, uintptr_t * ptr_array) {
    int mid = (start + end) / 2;
    if(start < end) {
        merge_sort(array, start, mid, ptr_array);
        merge_sort(array, mid + 1, end, ptr_array);
        merge_array(array, start, mid, end, ptr_array);
    }

}

// void * heap_info_malloc(uint64_t sz)
// {
//     void * arr = malloc(sz);
//     if (arr == NULL) return NULL;
//     header_list * arr_header = retrieve_header(arr);
//     arr_header->allocated_by_info = 1;
//     return arr;
// }


// heap_info_struct
// will be used by the heap_info function to store relevant data
// num_allocs: store current number of allocations
// ptr_array: pointer to an array of pointers of each allocation.
//			each pointer should be a currently alloc'd pointer
//			size of array should be equal to num_allocs
//			list should be sorted by size of allocation
// size_array: pointer to an array of size of each allocation
//		size_array[i] should hold the size of allocation for ptr_array[i]
//		should be sorted in descending order
// free_space: size of free space
// largest_free_chunk: size of the largest free chunk

// typedef struct heap_info_struct{
//     int num_allocs;
//     long * size_array;
//     void ** ptr_array;
//     int free_space;
//     int largest_free_chunk;
// } heap_info_struct;

int heap_info(heap_info_struct * info) 
{
    int num_allocs = 0;
    long * size_array = NULL;
    void ** ptr_array = NULL;
    // void ** ret_ptr_array = NULL;
    int free_space = 0;
    int largest_free_chunk = 0;

    for (header_list * curr = head; curr != NULL; curr = curr->next)
    {
        if (curr->is_allocated == 1) num_allocs++; 
    }

    info->num_allocs = num_allocs;

    // app_printf(0, "Finished counting num_allocs, %d\n", num_allocs);

    for (header_list * curr = head; curr != NULL; curr = curr->next)
    {   // free space that was not made by heap_info
        if (curr->is_allocated == 0) 
        {
            free_space += curr->sz;
            if (largest_free_chunk < (int) curr->sz)
            {
                largest_free_chunk = (int) curr->sz;
            }
        }
    }
    info->free_space = free_space;
    info->largest_free_chunk = largest_free_chunk;

    // app_printf(0, "Finished calculating free chunks\n");

    size_array = malloc(sizeof(long) * num_allocs);
    ptr_array = malloc(sizeof(uintptr_t) * num_allocs);
    // ret_ptr_array = malloc(sizeof(uintptr_t) * num_allocs);
    
    if (num_allocs == 0)
    {
        // update info struct
        info->size_array = NULL;
        info->ptr_array = NULL;
        return 0;        
    }
    // otherwise must be an error in malloc
    else if (size_array == NULL || ptr_array == NULL) return -1;
    
    // app_printf(0, "Finished mallocing arrays\n");
    // app_printf(0, "size_array add: %p, start of ptr_array add: %p\n", (uintptr_t) ptr_array, (uintptr_t) size_array);

    uint64_t i = 0;

    for (header_list * curr = head; curr != NULL; curr = curr->next)
    {
        // if this is a current allocation but one that is not allocated by the heap_info func
        if (curr->is_allocated == 1)
        {
            // don't count the size_array and ptr_array malloc
            void * payload = retrieve_payload(curr);
            if (size_array == payload || ptr_array == payload) continue;
            ptr_array[i] = curr;
            size_array[i] = curr->sz;
            i++;
        }
    }
    // // app_printf(0, "BEFORE\n");
    // for (int j = 0; j < 4; j++)
    // {
    //     app_printf(0, "at idx %d is size %d\n", j, size_array[j]);
    //     app_printf(0, "at idx %d is %p\n", j, ptr_array[j]);
    // }

    // app_printf(0, "Finished filling arrays\n");

    merge_sort(size_array, 0, num_allocs-1, (uintptr_t *) ptr_array);

    info->size_array = size_array;
    info->ptr_array = ptr_array; // need to make sure this is sorted in accordance to size

    // app_printf(0, "AFTER\n");x


    // app_printf(0, "Sorted array, now printing\n");
    // app_printf(0, "AFTER\n");


    // for (int j = 0; j < 4; j++)
    // {
    //     app_printf(0, "at idx %d is size %d\n", j, size_array[j]);
    //     app_printf(0, "at idx %d is %p\n", j, ptr_array[j]);
    //     // for (int f = 0; f < 1e9; f++);
    // }


    // app_printf(0, "successful, exiting!\n");

    free(size_array);
    free(ptr_array);

    return 0;
}
