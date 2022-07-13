rm -rf weensyos.img ./.hosts.txt ./.hosts.lock

// quit every time you run OS (just press q)

TODO: Write a function that allocates n pages and then calls fork

(make it so that you cant a complete pagetable: you want to see how init_pagetable responds when it fails)

if none of the assertions fail and fork should return that it fails
say you waited until theres only three physical pages left, try fork

then try allocating three physical pages to make sure that memory is avaliable

make this test, then uncomment that change to garbagecollect in init_pagetable to confirm
that fixed the error


CHECK WHEN THINGS FAIL: partial page table, fork fails, out of memory and call page_alloc,


make test-sys_page_alloc

    // need to do things
    // find five free physical pages to use
    // basically cast them into page table structures
    // in terms of pointers
    // we're writing this in kernel
    // we can use kernel virtual address to get the physical address of the page

    // page table structures: the structures are there for you already
    // l4 l3 l2 l1, the entry thing you were doing
    // page tables (pts) have page entries (pe)
    // pagetable->entry gives you one pe

    // then, link them together
    // the first entry of l1 should point to l2
    // the first entry of l2 should point to l3
    // ^ just page table logic.

    // page tables: most people just choose to loop through physical page
    // memory and find the first one
    // assign physical page uses the page info struct
    // anything to do with physical pages should be done with physical page func
    // anything with virutal pages should be done w virtual memory map

    // virtual always exists in its own page table
    // p_p_pagetable
    // for physical stuff it exists across all processes
    // you're doing this abstraction so each process seems like it has
    // a lot of virtual memory, but in reality it's sharing this physical memory


    // i have to copy the pagetable over
    // can't be the same for both
    // the exact same virtual addresses needs to be the same
    // and the data that those addresses point to needs to be the same
    // in the whole address space of 3MB, only a few pages are being used
    // by a process

    // the new processes' page table must point to different physical pages

    // i have to copy the individual virtual address info
    // but i need to allocate new pages where pages are allocated for the org process

