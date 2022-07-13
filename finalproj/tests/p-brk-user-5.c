#include "process.h"
#include "lib.h"
#include "malloc.h"


#define ALLOC_SLOWDOWN 100
#define MAX_ALLOC 100
extern uint8_t end[];

uint8_t * heap_top;
uint8_t * heap_bottom;
uint8_t * stack_bottom;

// try incrementing the break by a little more than two page
// what happens when you write up until then?

// behavior should be: 
// as you write,
// allocates two page for up to 8192, then allocates a new page when you write from > heap_bottom + 8192
// deallocates one page when the heap contracts to 8000
// deallocates two more pages when the heap contracts fully

void process_main(void) {
    pid_t p = getpid();
    srand(p);
    heap_bottom  = ROUNDUP((uint8_t*) end, PAGESIZE);
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);

    heap_top = heap_bottom + 10000;
    assert(brk((void *)heap_top) == 0);
    assert(sbrk(0) == heap_top);

    for(ssize_t i = 0; i < (intptr_t)heap_top - (intptr_t)heap_bottom; ++i) 
    {
        // writes from 1 to 10000
        // app_printf(0, "now writing to i = %d\n", i);
        heap_bottom[i] = 'A';
        assert(heap_bottom[i] == 'A');
    }

    // change heap top to heap_bottom + 8000
    assert(brk((void *)heap_top - 2000) == 0);

    // the two pages from the heap_bottom to heap_bottom + 8192 should all still be allocated
    for(uintptr_t va = (uintptr_t) heap_bottom; va < (uintptr_t) heap_bottom + 8192; va += 4096) {
        vamapping map;
        mapping(va, &map);
        assert((map.perm & PTE_P));
    }
    
    // the page at 8192 should be deallocated after the break changed to heap_bottom + 8000;

    uintptr_t va_1 = (uintptr_t) heap_bottom + 8192;
    vamapping map_1;
    mapping(va_1, &map_1);
    assert(!(map_1.perm & PTE_P));


    assert(brk((void *)heap_bottom) == 0);

    // now all pages should be deallocated */
    for(uintptr_t va = (uintptr_t)heap_bottom; va < (uintptr_t)heap_top; va += 4096) {
        vamapping map;
        mapping(va, &map);
	assert(!(map.perm & PTE_P));
    }

    TEST_PASS();
}
