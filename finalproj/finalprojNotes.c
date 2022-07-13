rm -rf weensyos.img ./.hosts.txt ./.hosts.lock

Debugging

mem_tog(0);

for (int i = 0; i < 100000000; i++);
app_printf(0, "size of malloc block: %d, size of free block: %d\n", malloc_block_sz, free_block->sz);


// size_array = malloc(sizeof(long) * num_allocs);
    // if (size_array == NULL) return -1;
    // header_list * size_header = retrieve_header((void *) size_array);
    // size_header->allocated_by_info = 1;

    // ptr_array = malloc(sizeof(uintptr_t) * num_allocs);
    // if (ptr_array == NULL) return -1;
    // header_list * ptr_header = retrieve_header((void *) ptr_array);
    // ptr_header->allocated_by_info = 1;

    // ret_ptr_array = malloc(sizeof(uintptr_t) * num_allocs);
    // if (ref_ptr_array == NULL) return -1;
    // header_list * ret_ptr_header = retrieve_header((void *) ret_ptr_array);
    // ret_ptr_header->allocated_by_info = 1;

    // app_printf(0, "size_array add: %p, start of ptr_array add: %p, ret_ptr add %p\n", (uintptr_t) ptr_array, (uintptr_t) size_array, (uintptr_t) ret_ptr_array);
    // // app_printf(0, "curr: %p\n", curr);
    // app_printf(0, "ptr_array address: %p, size_array address: %p\n", (uintptr_t) ptr_array + sizeof(uintptr_t) * i, (uintptr_t) size_array + sizeof(long) * i);

    // app_printf(0, "ptr array at index i = %d is %p\n", i, ptr_array[i]);
    // app_printf(0, "ptr array at index i = %d is %p\n", i, ptr_array[i]);


    // size_t b = 0;
    
    // for (header_list * curr = head; curr != NULL; curr = curr->next)
    // {
    //     if (curr->is_allocated == 1 && curr->allocated_by_info != 1)
    //     {
    //         app_printf(0, "allocated number %d found\n", b);
    //         b++;
    //     }
    // }


    // long * a = malloc(10 * sizeof(long)); 
    // void ** p_array = malloc(10 * sizeof(uintptr_t));
    // long b[] =  {30, 20, 40, 30, 50, 10, 0, 80, 90, -50};
    // uintptr_t idx[] =  {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};


    // for (int j = 0; j < 10; j++)
    // {
    //     a[j] = b[j];
    //     app_printf(0, "a[%d] = %d ", j, a[j]);
    // }
    // app_printf(0, "\n");
    // for (int j = 0; j < 10; j++)
    // {    
    //     // p_array[j] = (idx + j * sizeof(uintptr_t));
    // //     app_printf(0, "ptr[%d] = %d ", j, p_array[j]);
    // }

    // app_printf(0, "\n");
    // app_printf(0, "\n");

    // merge_sort(a, 0, 9, (uintptr_t *) p_array);
    // for (int j = 0; j < 10; j++)
    // {
    //     app_printf(0, "a[%d] = %d ", j, a[j]);
    // }
    // app_printf(0, "\n");
    // for (int j = 0; j < 10; j++)
    // {    
    //     app_printf(0, "ptr[%d] = %d ", j, p_array[j]);
    // }
    // app_printf(0, "\n");
