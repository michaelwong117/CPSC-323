#include "process.h"
#include "lib.h"
#include "malloc.h"


#define ALLOC_SLOWDOWN 100
#define MAX_ALLOC 100
extern uint8_t end[];

uint8_t *heap_top;
uint8_t *heap_bottom;
uint8_t *stack_bottom;



void process_main(void) {
    pid_t p = getpid();
    srand(p);
    mem_tog(0);
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
    
    for (int i = 1; i < 2; i++)
    {
        void *ptr = malloc(10000000);
        assert(ptr == NULL);
        free(ptr);
    }
    for (int i = 1; i < 2; i++)
    {
        void *ptr = malloc(4294967295);
        assert(ptr == NULL);
        /* Check that we can write */
        // memset(ptr, 'A', i);
        // free(ptr);
    }
    for (int i = 1; i < 2; i++)
    {
        void *ptr = calloc(4294967295, 8);
        assert(ptr == NULL);
        /* Check that we can write */
        // memset(ptr, 'A', i);
        // free(ptr);
    }
    for (int i = 1; i < 2; i++)
    {
        void *ptr = malloc(18446744073709551615ULL);
        assert(ptr == NULL);
        /* Check that we can write */
        // memset(ptr, 'A', i);
        // free(ptr);
    }
    for (int i = 1; i < 2; i++)
    {
        void *ptr = malloc(12446744073709551615ULL);
        assert(ptr == NULL);
        /* Check that we can write */
        // memset(ptr, 'A', i);
        // free(ptr);
    }

    void *p1 = malloc(1);
    void *p2 = realloc(p1, 18446744073709551615ULL);
    assert(p1 != NULL);
    assert(p2 == NULL);

    // /* Single elements on heap of varying sizes */
    // for(int i = 1; i < 512; ++i) {
    //     void *ptr = malloc(i);
    //     assert(ptr != NULL);

    //     /* Check that we can write */
    //     memset(ptr, 'A', i);
    //     free(ptr);
    // }

    TEST_PASS();
}
