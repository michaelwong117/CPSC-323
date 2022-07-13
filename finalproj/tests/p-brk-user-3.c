#include "process.h"
#include "lib.h"
#include "malloc.h"


#define ALLOC_SLOWDOWN 100
#define MAX_ALLOC 100
extern uint8_t end[];

uint8_t * heap_top;
uint8_t * heap_bottom;
uint8_t * stack_bottom;

// invalid inputs to brk
void process_main(void) {
    pid_t p = getpid();
    srand(p);
    heap_bottom  = ROUNDUP((uint8_t*) end, PAGESIZE);
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);

    heap_top = heap_bottom - 1;
    assert(brk((void *)heap_top) == -1);
    heap_top = (uint8_t*)  0x300000;
    assert(brk((void *)heap_top) == -1);
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE) + 4096;
    assert(brk((void *)heap_top) == 0);
    TEST_PASS();
}
