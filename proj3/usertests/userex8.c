long bar2(long arg1)
{
    long temp1 = -arg1;
    return temp1;
}
long bar(long arg1)
{
    long temp1 = arg1 * 2;
    long temp2 = bar2(temp1);
    return temp2;
}

long foo(long arg1, long arg2) 
{
    long temp1 = bar(arg1);
    return temp1;
}
