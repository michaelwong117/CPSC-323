#include "malloc.h"
#include "process.h"

#define ALIGNMENT 8
#define ALIGN(size) (((size) + (ALIGNMENT-1)) & ~(ALIGNMENT-1))
#define MIN_ALLOC_SIZE 1

// free linked list header struct

typedef struct header_list {

    struct header_list * next;
    struct header_list * prev;

    uint64_t sz;
    unsigned int allocated;

    void * mem_payload; // void * because it can be any type

} header_list; // each one of these is a header to a free segment

uint64_t count_sz;


#define HEADER_SZ ALIGN(sizeof(header_list))

header_list *head = NULL; // initialize the head of the list to NULL

header_list * find_free_block(uint64_t block_sz)
{
    // it could be that as I keep going further and further into I reach into addresses
    // that are in the kernel space and then we have a read protection problem because of that
    // trying to read addresses at curr that are in kernel space

    for (header_list * curr = head; curr != NULL; curr = curr->next)
    {
        if (curr->allocated == 0)
        {
            if (curr->sz >= block_sz)
            {
                return curr;
            }
        }
    }
    return NULL;
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
// expands heap and returns new old brk before expansion (start of expansion)
// minimum expansion of one page to avoid going to the kernel too often

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

// initalizing a new block of free memory
void init_new_block(header_list * new_block, uint64_t sz)
{
    if (sz < MIN_ALLOC_SIZE) new_block->sz = MIN_ALLOC_SIZE;
    else new_block->sz = sz;

    new_block->mem_payload = retrieve_payload(new_block);

    new_block->next = NULL;
    new_block->prev = NULL;
    new_block->allocated = 0;
}

// add the block either to the head of the free list or to the end
void add_block_to_list(header_list * new)
{
    new->next = NULL;
    new->prev = NULL;
    new->allocated = 0; // set the allocated flag to 0: this is the free list

    // if the head is NULL, set the new block to be the head of the list
    if (head == NULL)
    {
        new->next = head;
        head = new;
    }
    else if ((uintptr_t) new < (uintptr_t) head)
    {   // the new free block is earlier in the heap than the head, add to front of free list
        head->prev = new;
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
                new->prev = last;
                return;
            }
        }
    }
}

// void remove_block_from_list(header_list * to_remove)
// {
//     if (head == to_remove)
//     {
//         to_remove->next = NULL;
//         to_remove->prev = NULL;
//         head = head->next;
//         head->prev = NULL;
//     }
// }

// split up the free block into an allocated block and the leftovers into a new block in the free list
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
    header_list * new_block = (header_list *) (malloc_sz + free_block);
    
    // set the size of the new block to what's leftover after the malloc
    new_block->sz = free_block->sz - malloc_sz;

    // set the size of the old block to just the malloc
    free_block->sz = malloc_sz;

    add_block_to_list(new_block);
}

void free(void *firstbyte) {
    if (firstbyte == NULL) return;

    header_list *curr = head;

    while (curr != NULL)
    {
        if (curr->allocated == 1)
        {
            if (curr->mem_payload == firstbyte)
            {
                curr->allocated = 0; return;
            }
        }
        curr = curr->next;
    }
}

void *malloc(uint64_t numbytes) {

    if (numbytes <= 0)
    {
        return NULL;
    } 

    // size of the block we want to malloc + the header
    uint64_t malloc_block_sz = ALIGN(HEADER_SZ + numbytes);  
    count_sz = malloc_block_sz;
    
    if (count_sz >= 108) for (long long i = 0; i < 2000000000; i++);

    app_printf(0, "\n\nMALLOCING %d BYTES\n", numbytes);  
    app_printf(0, "size of the block we're mallocing: %d\n", malloc_block_sz);  

    // find a free block that the malloc block can fit into
    header_list * free_block = find_free_block(malloc_block_sz);


    // WHEN WE CAN'T FIND A FITTING BLOCK
    // WE WILL CREATE A NEW FREE BLOCK THE SAME SIZE AS THE MALLOC BLOCK
    if (free_block == NULL)
    { 

        // we expand the heap by the size of the malloc payload + header
        header_list * brk_start = expand_heap(malloc_block_sz); 
        if (brk_start == NULL) return NULL;
 
        free_block = brk_start; // the free block starts at the new brk_start

        // we initalize info for the new block, and
        // set the size of the new free block to be equal to the size of our malloc block
        init_new_block(free_block, malloc_block_sz);

        // then, we add the new free block to our free block list
        add_block_to_list(free_block);

        app_printf(0, "initializing free block %p of size %d\n", free_block, free_block->sz);
    }
    else
    {
        app_printf(0, "found free block %p of size %d\n", free_block, free_block->sz);

    }


    // IN OTHER CASES, this will not be true as find_free_block
    // will return a suitable free block that could be much bigger

    assert(free_block != NULL);
    // now, we have our valid free_block
    // the size of the free block and the heap expansion should be at minimum one page
    // the malloc block size can be much smaller

    app_printf(0, "size of malloc block: %d, size of free block: %d\n", malloc_block_sz, free_block->sz);  

    divide_block(free_block, malloc_block_sz);

    free_block->allocated = 1;

    return retrieve_payload(free_block);
}


void * calloc(uint64_t num, uint64_t sz) {
    return 0;
}

void * realloc(void * ptr, uint64_t sz) {
    return 0;
}

void defrag() {
}

int heap_info(heap_info_struct * info) {
    return 0;
}