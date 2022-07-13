fprintf(stderr, "MEMORY BUG :%s:%ld: invalid free of pointer %p, double free", file, line, (uintptr_t)ptr);

    // std::unordered_map<void *, header *>::iterator it;
    
    // for (it = advleaks.begin(); it != advleaks.end(); it++)
    // {
    //     void * ptr = it->first;
    //     header * h = it->second;
    //     long line = h->line;
    //     size_t diff = h->diff;
    //     size_t sz = h->sz;

    //     printf("test0xx.cc:%ld: %p is %zu bytes inside a %zu region allocated here\n", line, ptr, diff, sz);
    //                     //  test???.cc:8: ??? is 128 bytes inside a 2001 byte region allocated here
    // }

advleaks.insert(std::pair(ptr, h));
