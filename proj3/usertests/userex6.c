long foo(long arg1, long arg2, long arg3, long arg4, long arg5, long arg6)
{
    long temp1 = arg1;
    long temp2 = temp1;
    long temp3 = temp2 - 3;
    long temp4 = temp3 - temp1;
    long temp5 = 3 - temp4;

    return temp5;
}