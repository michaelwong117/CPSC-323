#include "process.h"
#include "lib.h"
#include "malloc.h"


#define ALLOC_SLOWDOWN 100
#define MAX_ALLOC 100
extern uint8_t end[];

uint8_t * heap_top;
uint8_t * heap_bottom;
uint8_t * stack_bottom;

// uneven increment
void process_main(void) {
    pid_t p = getpid();
    srand(p);
    heap_bottom  = ROUNDUP((uint8_t*) end, PAGESIZE);
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);

    heap_top = heap_bottom + 9999;
    assert(brk((void *)heap_top) == 0);
    assert(sbrk(0) == heap_top);

    TEST_PASS();
}
