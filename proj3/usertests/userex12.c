long bar(long arg1)
{
    long temp4 = arg1 + 5;
    return temp4;
}
long foo(long arg1, long arg2)
{
    long temp1 = 5;
    long temp2 = bar(arg1);
    long temp3 = temp1/temp2;
    return temp3;
}