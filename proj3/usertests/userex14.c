long foo(long arg1, long arg2) {

    long a = arg2;
    long b = a >> 2;
    long c = arg1 << b;
    long d = -c;
    long e = c / d;
    return e; 

}