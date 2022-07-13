long foo(long arg1, long arg2) {

    long a = arg1 + 5;

    long b = a * arg2;

    long b2 = -b;

    long c = b2 + 2;
    long d = 8 - c;
    long e = d & arg2; // 2
    long f = 18 | arg2; // 31
    long g = f ^ 14; // 31
    long h = g << 8;
    long i = h >> 4;
    long j = i << arg2;

    return j; 

}