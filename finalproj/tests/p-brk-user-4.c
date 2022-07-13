#include "process.h"
#include "lib.h"
#include "malloc.h"


#define ALLOC_SLOWDOWN 100
#define MAX_ALLOC 100
extern uint8_t end[];

uint8_t * heap_top;
uint8_t * heap_bottom;
uint8_t * stack_bottom;

// try incrementing the break by a little more than page
// what happens when you write up until then?

// behavior should be: 
// allocates one page for up to 4096, then allocates a new page when you write from > heap_bottom + 4096
// deallocates one page when the heap contracts to 4096, 
// deallocates one more page when the heap contracts fully

// uncomment the lines in change_brk_loc and look at log.txt for more info

void process_main(void) {
    pid_t p = getpid();
    srand(p);
    heap_bottom  = ROUNDUP((uint8_t*) end, PAGESIZE);
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);

    heap_top = heap_bottom + 5000;
    assert(brk((void *)heap_top) == 0);
    assert(sbrk(0) == heap_top);

    for(ssize_t i = 0; i < (intptr_t)heap_top - (intptr_t)heap_bottom; ++i) 
    {
        // if (i > 4096) app_printf(0, "now writing to i = %d\n", i);
        heap_bottom[i] = 'A';
        assert(heap_bottom[i] == 'A');
    }
    // contracts heap to heap_bottom + 3000
    assert(brk((void *)heap_top - 2000) == 0);

    // page at 4096 should be deallocated when the heap contracts to heap_bottom + 3000
    for(uintptr_t va = (uintptr_t)heap_bottom + 4096; va < (uintptr_t)heap_top; va += 4096) {
        vamapping map;
        mapping(va, &map);
    assert(!(map.perm & PTE_P));
    }

    assert(brk((void *)heap_bottom) == 0);

    // now all pages should be deallocated
    for(uintptr_t va = (uintptr_t)heap_bottom; va < (uintptr_t)heap_top; va += 4096) {
        vamapping map;
        mapping(va, &map);
	assert(!(map.perm & PTE_P));
    }

    TEST_PASS();
}
