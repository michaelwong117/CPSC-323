#include "kernel.h"
#include "lib.h"

// kernel.c
//
//    This is the kernel.


// INITIAL PHYSICAL MEMORY LAYOUT
//
//  +-------------- Base Memory --------------+
//  v                                         v
// +-----+--------------------+----------------+--------------------+---------/
// |     | Kernel      Kernel |       :    I/O | App 1        App 1 | App 2
// |     | Code + Data  Stack |  ...  : Memory | Code + Data  Stack | Code ...
// +-----+--------------------+----------------+--------------------+---------/
// 0  0x40000              0x80000 0xA0000 0x100000             0x140000
//                                             ^
//                                             | \___ PROC_SIZE ___/
//                                      PROC_START_ADDR

#define PROC_SIZE 0x40000       // initial state only

static proc processes[NPROC];   // array of process descriptors
                                // Note that `processes[0]` is never used.
proc* current;                  // pointer to currently executing proc

#define HZ 100                  // timer interrupt frequency (interrupts/sec)
static unsigned ticks;          // # timer interrupts so far

void schedule(void);
void run(proc* p) __attribute__((noreturn));

static uint8_t disp_global = 1;         // global flag to display memviewer

// PAGEINFO
//
//    The pageinfo[] array keeps track of information about each physical page.
//    There is one entry per physical page.
//    `pageinfo[pn]` holds the information for physical page number `pn`.
//    You can get a physical page number from a physical address `pa` using
//    `PAGENUMBER(pa)`. (This also works for page table entries.)
//    To change a physical page number `pn` into a physical address, use
//    `PAGEADDRESS(pn)`.
//
//    pageinfo[pn].refcount is the number of times physical page `pn` is
//      currently referenced. 0 means it's free.
//    pageinfo[pn].owner is a constant indicating who owns the page.
//      PO_KERNEL means the kernel, PO_RESERVED means reserved memory (such
//      as the console), and a number >=0 means that process ID.
//
//    pageinfo_init() sets up the initial pageinfo[] state.

typedef struct physical_pageinfo {
    int8_t owner;
    int8_t refcount;
} physical_pageinfo;

static physical_pageinfo pageinfo[PAGENUMBER(MEMSIZE_PHYSICAL)];

typedef enum pageowner {
    PO_FREE = 0,                // this page is free
    PO_RESERVED = -1,           // this page is reserved memory
    PO_KERNEL = -2              // this page is used by the kernel
} pageowner_t;

static void pageinfo_init(void);


// Memory functions

void check_virtual_memory(void);
void memshow_physical(void);
void memshow_virtual(x86_64_pagetable* pagetable, const char* name);
void memshow_virtual_animate(void);


// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

static void process_setup(pid_t pid, int program_number);

void kernel(const char* command) {
    hardware_init();
    pageinfo_init();
    console_clear();
    timer_init(HZ);

    // gonna add some stuff there for step 1
    // this is where ya put it
    // helping set up the kernel w correct perm

    for (uintptr_t addr = 0; addr < PROC_START_ADDR; addr += PAGESIZE)
    {
        virtual_memory_map(kernel_pagetable, addr, addr,  
        PAGESIZE, PTE_P | PTE_W);
    } 
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,  
    PAGESIZE, PTE_P | PTE_W | PTE_U);   

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
    for (pid_t i = 0; i < NPROC; i++) {
        processes[i].p_pid = i;
        processes[i].p_state = P_FREE;
    }

    if (command && strcmp(command, "fork") == 0) {
        process_setup(1, 4);
    } else if (command && strcmp(command, "forkexit") == 0) {
        process_setup(1, 5);
    } else if (command && strcmp(command, "test") == 0) {
        process_setup(1, 6);
    } else if (command && strcmp(command, "test2") == 0) {
        for (pid_t i = 1; i <= 2; ++i) {
            process_setup(i, 6);
        }
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
            process_setup(i, i - 1);
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
}


// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

// step 2: complicated
// modify process_set up
// create entire page table, going to find free physical pages
// actually have to search through the physical address space to 
// find free pages and then you're going to use those
// to create the page table
// you may also have to identity map the kernel

// you need two utility functions: used for process set up and fork

// you want a function to allocate a page for you: 
// that's finding a free physical frame, and doing the stuff you 
// need to allocate it

// the assign physical page function will help later
// assign_physical_page well help you, part of the allocation 

// the other utility function is creating the page table
// will call the allocation function you have
// it will allocate the five pages, and set them up how they should be

// step 2 you want to set up your processes pagetable
// pagetables exist in physical memory
// each table exists in memory
// you have to allocate five physical pages for your pagetable
// your pagetable is going to be l1 l2 l3 l4 l5

// have to find free pages and place them.

void process_setup(pid_t pid, int program_number) {
    process_init(&processes[pid], 0);

    x86_64_pagetable* res_pagetables[5];
    int res_pt = init_pagetable(pid, res_pagetables);
    assert(res_pt != -1);
    processes[pid].p_pagetable = res_pagetables[0];

    // starter code
    // processes[pid].p_pagetable = kernel_pagetable;
    // ++pageinfo[PAGENUMBER(kernel_pagetable)].refcount;
    int r = program_load(&processes[pid], program_number, NULL);
    assert(r >= 0);
    // this is setting up the stack
    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL;
    // log_printf("rsp: %p\n", processes[pid].p_registers.reg_rsp);
    uintptr_t next_page_addr = get_physical_page_addr(pid);
    assert(next_page_addr != 0xffffffffffffffff);
    // uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
    // assign_physical_page(stack_page, pid);

    
    // have to find a page for step 4
    virtual_memory_map(processes[pid].p_pagetable, processes[pid].p_registers.reg_rsp - PAGESIZE, next_page_addr,
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
}
// takes in the process id and the pagetable array
int init_pagetable(pid_t pid, x86_64_pagetable** res_pagetables)
{ // in here you would need to manually get rid of all the pagetables you've gotten so far
    // allocate before you write (memset and link)
    for (int i = 0; i < 5; i++)
    {
        // allocates a physical page for each level of the pagetable
        int res = pagetable_allocate_physical_page(pid, &res_pagetables[i]);
        if (res == -1)
        {
            return -1;
        }
    }

    x86_64_pagetable* res_pagetable = res_pagetables[0];
    // pagetables just contain entries

    for (int i = 0; i < 5; i++)
    {
        // log_printf("size of res_pt entry: %d\n", sizeof(res_pagetables[i]->entry));
        memset(res_pagetables[i]->entry, 0, sizeof(res_pagetables[i]->entry));
    }
    // res_pagetables[0] or res_pagetable is the l4 page table
    res_pagetables[0]->entry[0] =
        (x86_64_pageentry_t) res_pagetables[1] | PTE_P | PTE_W | PTE_U;
    res_pagetables[1]->entry[0] =
        (x86_64_pageentry_t) res_pagetables[2] | PTE_P | PTE_W | PTE_U;
    res_pagetables[2]->entry[0] =
        (x86_64_pageentry_t) res_pagetables[3] | PTE_P | PTE_W | PTE_U;
    res_pagetables[2]->entry[1] =
        (x86_64_pageentry_t) res_pagetables[4] | PTE_P | PTE_W | PTE_U;

    // copy mappings from kernel page tables
    for(uintptr_t addr = 0; addr < PROC_START_ADDR; addr += PAGESIZE){
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
        // log_printf("virtual add: %p, physical address: %p, permissions: %d\n", 
        //             addr, vmap.pa, vmap.perm);
        // vmap.pa is the physical address that the virutal address "addr"
        // is mapped to inside the kernel's pagetable
        if (vmap.pn != -1)
        { // if vmap.pn == -1 means the page isn't mapped
            int res = virtual_memory_map(res_pagetable, addr, vmap.pa,  
            PAGESIZE, vmap.perm); // pass the l4 page table in
            // should also copy the kernel's memory permissions
            // log_printf("virtual memory map result: %d\n", res);
        }
        // vmap = virtual_memory_lookup(res_pagetable, addr);
        // log_printf("res virtual add: %p, physical address: %p, permissions: %d\n", 
        // addr, vmap.pa, vmap.perm);
    }
    return 0;
    // this is updating the kernel's pagetable, don't need
    // set_pagetable(res_pagetable);
}

int find_free_process()
{
    int free_proc_slot = -1;
    // find a free proc slot that's not slot 0
    for (int i = 1; i < NPROC; i++)
    {
        if (processes[i].p_state == P_FREE)
        {   
            free_proc_slot = i; // the free process slot is i
            // memcpy((void *) &current->p_registers, (void *) &processes[i].p_registers, sizeof(processes[i].p_registers));
            // look at what each element of the processes array should be
            // and set each element accordingly
            // read fault -> probably something with permissions
            break;
        }
    }
    return free_proc_slot;
}
// unassigns the page at physical address addr
void unassign_page(uintptr_t addr, pid_t pid)
{
    if (pageinfo[PAGENUMBER(addr)].owner == pid && pageinfo[PAGENUMBER(addr)].refcount == 1)
    {
        // log_printf("CHANGE OWNER: physical addr %p has owner %d with refcount %d\n",
        //             addr, pageinfo[PAGENUMBER(addr)].owner, pageinfo[PAGENUMBER(addr)].refcount);
        pageinfo[PAGENUMBER(addr)].owner = PO_FREE;
        pageinfo[PAGENUMBER(addr)].refcount--;
    }
    else if (pageinfo[PAGENUMBER(addr)].refcount > 1 && pageinfo[PAGENUMBER(addr)].owner > 0)
    {
        // log_printf("REDUCE REFCOUNT ONLY: physical addr %p has owner %d with refcount %d\n",
        // addr, pageinfo[PAGENUMBER(addr)].owner, pageinfo[PAGENUMBER(addr)].refcount);
        pageinfo[PAGENUMBER(addr)].refcount--;
    }
    // log_printf("\nRESULT: physical addr %p has owner %d with refcount %d\n",
    // addr, pageinfo[PAGENUMBER(addr)].owner, pageinfo[PAGENUMBER(addr)].refcount);

    // if the pid is the same and refcount is 1
    // else if the refcount is greater than 1 and the owner is >= 0 ( meaning not the kernel or reserved)
}
void free_bad_pagetable(pid_t pid)
{
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE)
    {
        if (pageinfo[PAGENUMBER(addr)].owner == pid)
        {
            unassign_page(addr, pid);
        }
    }  
    
}
void garbage_collect(int process, x86_64_pagetable * pt)
{
    for(uintptr_t addr = 0; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE)
    {
        // looking up the virtual address addr in the original pagetable
        vamapping vmap = virtual_memory_lookup(pt, addr);
        // log_printf("virtual add: %p, physical address: %p, permissions: %d\n", 
        //             addr, vmap.pa, vmap.perm);
        if (vmap.perm & PTE_P && vmap.pn >= 0)
        {
            unassign_page(vmap.pa, process);
        }
    }
    
    processes[process].p_state = P_FREE;


    // copy process info to new process
    // if (pageinfo[PAGENUMBER(vmap.pa)].refcount >= 1 && pageinfo[PAGENUMBER(vmap.pa)].owner > 0)
    // {
    //     log_printf("Process %d IS NOT SUPPOSED TO BE P_FREE: physical addr %p has owner %d with refcount %d\n",
    //             process, vmap.pa, pageinfo[PAGENUMBER(vmap.pa)].owner, pageinfo[PAGENUMBER(vmap.pa)].refcount);
    // }

    // THIS CASE WON'T HAPPEN BECAUSE THE PARENT WILL ALWAYS EXIT AFTER THE CHILD
    // you can never have an a before b case
    // int still_running = 0;
    // for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) 
    // {
    //     if (pageinfo[pn].owner == process)
    //     {
    //         if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0)
    //         {
    //             still_running = 1;
    //         }
    //     }
    // }
    // if (!still_running)
    // {
        // processes[process].p_state = P_FREE;
    // }


    // for virtual memory you can iterate over the virtual memory size
    // use virtual memory lookup to look up if the page is present or not in the child
    // if the child is present
    // if refcount = 1: then free the page and reset owner
    // otherwise if the page is being used by some other process (if refcount > 1)
    // you just decrease the refcount

    //  garbage collect here
    // if a call to get physical page fails
    // we go through the pagetable
    // call virtual memory lookup on the pagetable in the forked process
    // if the page is present in the child process
    // we decrease the refcount of that page
    // if the refcount becomes zero, set the owner to PO_FREE
    // after you do this you then need to free the pagetable, free the five pages
    // then set the forked process back to PO_FREE (or PO_Broken)
    // set the parent's.rax value to -1 because the fork failed
    // garbage_collection_fork();
}


int fork_copy(pid_t child_pid, x86_64_pagetable * child, x86_64_pagetable * parent)
{  // STEP 1: copy pagetable
   // create an exact copy of the pagetable by looking up each virtual address
   // in the parent, and copying that mapping from va to pa in the child

    // initalizing the page table WILL create a tree structure
    // but the contents of the entries has to be the same 

    for(uintptr_t addr = PROC_START_ADDR; addr < MEMSIZE_VIRTUAL; addr += PAGESIZE)
    {
        // looking up the virtual address addr in the original pagetable
        vamapping vmap = virtual_memory_lookup(parent, addr);
        // log_printf("virtual add: %p, physical address: %p, permissions: %d\n", 
        //             addr, vmap.pa, vmap.perm);

        // if (addr == (uintptr_t) CONSOLE_ADDR)
        // {
        //     log_printf("virtual address %p is mapped to the console address %p\n", 
        //                     addr, CONSOLE_ADDR);
        // }

        int res = virtual_memory_map(child, addr, vmap.pa,
                    PAGESIZE, vmap.perm);
        if (res < 0) return -1;
        // mapping should be okay for freeing
        // map will only fail if you give it a bad address
        if ((vmap.perm & (PTE_P | PTE_W)) == (PTE_P | PTE_W))
        { // if there is a page present in the original pagetable and it's not read-only
        // the page is indeed present and we have a find a new physical page for the copy
        // for which to put that virtual address at

            // log_printf("writable vmap.perm: %d\n", vmap.perm);
            uintptr_t next_page_addr = get_physical_page_addr(child_pid);
            if (next_page_addr == 0xffffffffffffffff) return -1;
            

            // use virtual memory lookup
            // copying from one pa to another all the bytes of the next pagesize
            memcpy((void *) next_page_addr, (void *) vmap.pa, PAGESIZE);

            // log_printf("MAPPING virtual address %p to physical addreses %p, instead of original physical address %p\n", 
            //             addr, next_page_addr, vmap.pa);

            res = virtual_memory_map(child, addr, next_page_addr,
                            PAGESIZE, vmap.perm);
            if (res < 0) return -1;
            
        }
        else if ((vmap.perm & (PTE_P | PTE_U)) == (PTE_P | PTE_U) && !(vmap.perm & PTE_W))
        { // present but not writable
            // log_printf("the virtual addr %p is shared by %d processes\n",
            //             pageinfo[PAGENUMBER(addr)].refcount);
            // only want to increase the refcount of the physical page
            // these two processes each have their own pagetable, and the entries
            // in these pagetables point to the same physical memory address
            
            update_refcount(vmap.pa); // update the refcounts so the OS marks page as shared
            // the addr is already mapped to the same pa (which is fine in the case of no write access)            

        }
        int free_process = (int) child_pid;
        // copy process info to new process
        processes[free_process].p_state = P_RUNNABLE;
        processes[free_process].p_pid = free_process;
        processes[free_process].p_registers = current->p_registers;
        processes[free_process].p_registers.reg_rax = 0;
        current->p_registers.reg_rax = free_process;
        processes[free_process].p_pagetable = child;

        // else
        // {
            // otherwise if it's not present don't have to do anything

            // log_printf("the third case somehow!\n");
        // }

 
        // vmap = virtual_memory_lookup(res_pagetable, addr);
        // log_printf("res virtual add: %p, physical address: %p, permissions: %d\n", 
        // addr, vmap.pa, vmap.perm);
    }
    return 0;
}

void update_refcount(uintptr_t addr)
{
    pageinfo[PAGENUMBER(addr)].refcount++;
}
// takes in the owner's process id and a pointer to a pagetable
int pagetable_allocate_physical_page(int8_t owner, x86_64_pagetable ** curr_pt)
{
  for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE)
    {
        if (pageinfo[PAGENUMBER(addr)].owner == PO_FREE)
        {
            assign_physical_page(addr, owner);
            // log_printf("FOUND physical address: %p\n", addr);
            *(curr_pt) = (x86_64_pagetable *) addr;
            return 0;
        }
    }  
    return -1;
}

uintptr_t get_physical_page_addr(int8_t owner)
{
  for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE)
    {
        if (pageinfo[PAGENUMBER(addr)].owner == PO_FREE)
        {
            int res = assign_physical_page(addr, owner);
            if (res == -1) return -1;
            // log_printf("FOUND physical address: %p\n", addr);
            return addr;
        }
    }  
    return -1;
}


// go to where the assertion, log_printf both sides of the assertion
// reason about which one is correct ( which owner is correct )
// did you set your physical page owner? or is it because your virtual
// memory manager did something funky


// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
    if ((addr & 0xFFF) != 0
        || addr >= MEMSIZE_PHYSICAL
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
        return -1;
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
        pageinfo[PAGENUMBER(addr)].owner = owner;
        return 0;
    }
}

void syscall_mapping(proc* p){

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
    uintptr_t ptr = p->p_registers.reg_rsi;

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
}

void syscall_mem_tog(proc* process){

    pid_t p = process->p_registers.reg_rdi;
    if(p == 0) {
        disp_global = !disp_global;
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
            return;
        process->display_status = !(process->display_status);
    }
}

// exception(reg)
//    Exception handler (for interrupts, traps, and faults).
//
//    The register values from exception time are stored in `reg`.
//    The processor responds to an exception by saving application state on
//    the kernel's stack, then jumping to kernel assembly code (in
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.


// step 3 and onward
// a bunch of case statememt
// also might have to do something for step 1 or step 2 in here

void exception(x86_64_registers* reg) {
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
    set_pagetable(kernel_pagetable);

    // It can be useful to log events using `log_printf`.
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
    {
        check_virtual_memory();
        if(disp_global){
            memshow_physical();
            memshow_virtual_animate();
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();


    // Actually handle the exception.
    switch (reg->reg_intno) {

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
		if((void *)addr == NULL)
		    panic(NULL);
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
		memcpy(msg, (void *)map.pa, 160);
		panic(msg);

	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
        break;

    case INT_SYS_YIELD:
        schedule();
        break;                  /* will not be reached */

    case INT_SYS_PAGE_ALLOC: {
        // this is what gets called when you want to alloc a page

        // you made a syscall, the syscall is saying
        // i need a page, you run into a pagefault, and the issue
        // is you need to alloc a page now

        // sys_page_alloc addr IS a virtual address
        // the page with physical address X is used to 
        // satisfy the sys_page_alloc(X) allocation request for virtual address X.
        uintptr_t addr = current->p_registers.reg_rdi; // look at virtual address

        if (addr < PROC_START_ADDR && addr != CONSOLE_ADDR)
        {
            current->p_registers.reg_rax = -1;
            break;
        }
        if (addr > MEMSIZE_VIRTUAL || addr % PAGESIZE != 0)
        {
            current->p_registers.reg_rax = -1;
            break;
        }

        // log_printf("virtual address: %p\n", addr);

        uintptr_t next_page_addr = get_physical_page_addr(current->p_pid);
        
        if (next_page_addr == 0xffffffffffffffff)
        {
            current->p_registers.reg_rax = -1;
            break;  
        }

        int r = 0;

        // log_printf("MAPPING virtual address %p to physical addreses %p\n", 
        //             addr, next_page_addr);

        if (r >= 0) {
            int res = virtual_memory_map(current->p_pagetable, addr, next_page_addr,
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
            if (res < 0)
            {
                current->p_registers.reg_rax = -1;
                break;  
            }
        }
        current->p_registers.reg_rax = r;
        break;
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
            break;
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
	    break;
	}

    case INT_TIMER:
        ++ticks;
        schedule();
        break;                  /* will not be reached */

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
        const char* operation = reg->reg_err & PFERR_WRITE
                ? "write" : "read";
        const char* problem = reg->reg_err & PFERR_PRESENT
                ? "protection problem" : "missing page";

        if (!(reg->reg_err & PFERR_USER)) {
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
        current->p_state = P_BROKEN;
        break;
    }
    case INT_SYS_FORK: 
    
    // TODOS: look at processes array carefully
    // create garbage collection: when the fork fails, go through
    // your process array and your pageinfo table and reset refcounts, owners
    // states, etc.
        // you need to handle the fork case for step 5
        // you'll end up creating a new page table again
        // back to the process_setup

        int free_process = find_free_process();

        if (free_process == -1) // if not found
        {
            current->p_registers.reg_rax = -1; break;  
        }

        // initiate and copy over process pagetable

        process_init(&processes[free_process], 0);

        x86_64_pagetable* res_pagetables[5];
        int res_pt = init_pagetable(free_process, res_pagetables);
        if (res_pt == -1)
        {
            free_bad_pagetable(free_process);
            current->p_registers.reg_rax = -1; break;  
        }
        x86_64_pagetable* res_pagetable = res_pagetables[0];
        int res_fork = fork_copy(free_process, res_pagetable, current->p_pagetable);
        if (res_fork == -1)
        {
            garbage_collect(free_process, res_pagetable);
            free_bad_pagetable(free_process);
            current->p_registers.reg_rax = -1; break;  
        }

        break;
    case INT_SYS_EXIT:
        garbage_collect(current->p_pid, current->p_pagetable);
        free_bad_pagetable(current->p_pid);
        break;

    default:
        default_exception(current);
        break;                  /* will not be reached */

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
        run(current);
    } else {
        schedule();
    }
}


// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
    pid_t pid = current->p_pid;
    while (1) {
        pid = (pid + 1) % NPROC;
        if (processes[pid].p_state == P_RUNNABLE) {
            run(&processes[pid]);
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
    }
}


// run(p)
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
    assert(p->p_state == P_RUNNABLE);
    current = p;

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);

 spinloop: goto spinloop;       // should never get here
}


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
        int owner;
        if (physical_memory_isreserved(addr)) {
            owner = PO_RESERVED;
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
            owner = PO_KERNEL;
        } else {
            owner = PO_FREE;
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
    }
}


// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
        if (vam.pa != va) {
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
        }
        // log_printf("physical address of kernel mapping: %p, virtual address: %p\n",
        //                 vam.pa, va);
        assert(vam.pa == va);
        if (va >= (uintptr_t) start_data) {
            assert(vam.perm & PTE_W);
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
    vamapping vam = virtual_memory_lookup(pt, kstack);
    assert(vam.pa == kstack);
    assert(vam.perm & PTE_W);
}


// check_page_table_ownership
//    Check operating system invariants about ownership and reference
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
    // calculate expected reference count for page tables
    int owner = pid;
    int expected_refcount = 1;
    if (pt == kernel_pagetable) {
        owner = PO_KERNEL;
        for (int xpid = 0; xpid < NPROC; ++xpid) {
            if (processes[xpid].p_state != P_FREE
                && processes[xpid].p_pagetable == kernel_pagetable) {
                ++expected_refcount;
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
}

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
    assert(PAGENUMBER(pt) < NPAGES);
    // uncommment at some point
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
    if (level < 3) {
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
            if (pt->entry[index]) {
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
            }
        }
    }
}


// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);

    // The kernel page table should be owned by the kernel;
    // its reference count should equal 1, plus the number of processes
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
    check_page_table_ownership(kernel_pagetable, -1);

    for (int pid = 0; pid < NPROC; ++pid) {
        if (processes[pid].p_state != P_FREE
            && processes[pid].p_pagetable != kernel_pagetable) {
            check_page_table_mappings(processes[pid].p_pagetable);
            check_page_table_ownership(processes[pid].p_pagetable, pid);
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
        }
    }
}

// memshow_physical
//    Draw a picture of physical memory on the CGA console.

static const uint16_t memstate_colors[] = {
    'K' | 0x0D00, 'R' | 0x0700, '.' | 0x0700, '1' | 0x0C00,
    '2' | 0x0A00, '3' | 0x0900, '4' | 0x0E00, '5' | 0x0F00,
    '6' | 0x0C00, '7' | 0x0A00, '8' | 0x0900, '9' | 0x0E00,
    'A' | 0x0F00, 'B' | 0x0C00, 'C' | 0x0A00, 'D' | 0x0900,
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
        if (pn % 64 == 0) {
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
        }

        int owner = pageinfo[pn].owner;
        if (pageinfo[pn].refcount == 0) {
            owner = PO_FREE;
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
    }
}


// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pagetable, va);
        uint16_t color;
        if (vam.pn < 0) {
            color = ' ';
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
            int owner = pageinfo[vam.pn].owner;
            if (pageinfo[vam.pn].refcount == 0) {
                owner = PO_FREE;
            }
            color = memstate_colors[owner - PO_KERNEL];
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
                    | (color & 0x00FF);
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
                if(! (vam.perm & PTE_U))
                    color = color | 0x0F00;

#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
        if (pn % 64 == 0) {
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
    }
}


// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
        last_ticks = ticks;
        ++showing;
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
    }
    showing = showing % NPROC;

    if (processes[showing].p_state != P_FREE) {
        char s[4];
        snprintf(s, 4, "%d ", showing);
        memshow_virtual(processes[showing].p_pagetable, s);
    }
}
