#include "malloc.h"
#include "process.h"

#define BLOCK_SIZE 8 * PAGESIZE
#define BLOCK_ALIGN(size) (((size)+(BLOCK_SIZE-1)) & ~(BLOCK_SIZE-1))
#define ALIGNMENT 8
#define ALIGN(size) (((size) + (ALIGNMENT-1)) & ~(ALIGNMENT-1))
#define SIZE_MAX (uint64_t) -1

typedef struct
{
    uint64_t size;
    unsigned int allocated;
} header_list; 

// Used lecture and slide materials for conceptual grounding of project
// Followed Gilligan's Island Rule 
// Using block based iteration as opposed to payload for easier access to header info

#define HEADER_SZ sizeof(header_list)

void * grab_payload(header_list * header_pt)
{
    void * payload = (void *) ((uintptr_t) header_pt + HEADER_SZ);
    return payload;
}

header_list * grab_header(void * mem_payload)
{
    header_list * header = (header_list *) ((uintptr_t) mem_payload - HEADER_SZ);
    return header;
}

header_list* next_block(header_list *header)
{ 
    return (header_list*) ((uintptr_t) header + header->size); 
}

void *first_bp;
int first_run = 1;

int initialize_malloc()
{
    sbrk(sizeof(header_list));
    first_bp = sbrk(0);
    
    grab_header(first_bp)->size = 0;
    grab_header(first_bp)->allocated = 1;

    first_run = 0;
    return 0;
}

int expand_heap(uint64_t block_size)
{
    void *bp = sbrk(block_size);

    if ((uintptr_t) bp == (uintptr_t) -1) return -1;
    grab_header(bp)->size = block_size;
    grab_header(bp)->allocated = 0;

    next_block(grab_header(bp))->size = 0;
    next_block(grab_header(bp))->allocated = 1;
    return 0; // succesfully increased brk and expanded heap
}

int extend(uint64_t new_size)
{
    uint64_t block_size = BLOCK_ALIGN(new_size);
    if (expand_heap(block_size) == -1) return -1;
    return 0; 
}

void split(header_list *header, uint64_t size)
{
    uint64_t extra_size = header->size - size;
 
    if (header->size - size > ALIGN(1 + HEADER_SZ))
    {
        header->size = size;        
        next_block(header)->size = extra_size;
        next_block(header)->allocated = 0;
    }
    header->allocated = 1;
}

void free(void *firstbyte) {
    if (firstbyte == NULL) return;

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
    {
        if (curr->allocated == 1)
        {
            if (grab_payload(curr) == firstbyte)
            {
                curr->allocated = 0;
                return;
            }
        }
    }
}

header_list * find_free_block(uint64_t new_sz)
{
    header_list * curr = grab_header(first_bp);
    for ( curr ; curr->size != 0; curr = next_block(curr))
    {
        if (curr->allocated == 0)
        {
            if (curr->size >= new_sz)
            { // if you find a free block, split it up into alloc and dealloc parts, 
              // and return the header
                return curr;
            }
        }
    }
    // otherwise return a header with size zero
    return curr;
}

void *malloc(uint64_t numbytes)
{
    if (numbytes == 0 || numbytes >= SIZE_MAX)
    { 
        return NULL; 
    }

    if (first_run) initialize_malloc(); 

    uint64_t new_size = ALIGN(numbytes + HEADER_SZ);

    header_list *header = find_free_block(new_size);

    if (header->size != 0)
    {   // if we found a block and split it, return the payload
        split(header, new_size);
        return grab_payload(header);
    }
    else
    {   // otherwise, extend the heap, split the header of zero, and return that payload
        if (extend(new_size) == -1) return NULL;
        split(header, new_size);
        return grab_payload(header);
    }
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


void * realloc(void * ptr, uint64_t sz) 
{
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
    uint64_t block_sz = grab_header(ptr)->size;  // original size of block at ptr
    
    if (block_sz > sz) return ptr;

    // realloc changes the size of the memory block pointed to by ptr to size bytes.

    header_list * new_block = malloc(sz);

    if (new_block == NULL)
    {
        return NULL;
    }
    else
    {
        // retrieve and copy over the header_b information
        // from the given realloc ptr to the new_block
        memcpy(new_block, ptr, block_sz);

        free(ptr); // free the old pointer

        return new_block;
    }
}

void defrag() 
{
    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
    {
        header_list * adj = next_block(curr);

        if (curr->allocated == 0 && adj->allocated == 0)
        {
            curr->size += adj->size;
        }
    }
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
    int free_space = 0;
    int largest_free_chunk = 0;

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
    {
        if (curr->allocated == 1) num_allocs++; 
    }

    info->num_allocs = num_allocs;

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
    {   // free space that was not made by heap_info
        if (curr->allocated == 0) 
        {
            free_space += curr->size;
            if (largest_free_chunk < (int) curr->size)
            {
                largest_free_chunk = (int) curr->size;
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

    for (header_list * curr = grab_header(first_bp); curr->size != 0; curr = next_block(curr))
    {
        // if this is a current allocation but one that is not allocated by the heap_info func
        if (curr->allocated == 1)
        {
            // don't count the size_array and ptr_array malloc
            void * mem_payload = grab_payload(curr);
            if (size_array == mem_payload || ptr_array == mem_payload) continue;
            ptr_array[i] = mem_payload;
            size_array[i] = curr->size - HEADER_SZ;
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
