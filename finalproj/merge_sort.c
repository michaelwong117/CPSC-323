#include "malloc.h"

void merge_array(long *array, int start, int mid, int end, uintptr_t * ptr_array)  
{
     long sorted[end - start + 1];
     uintptr_t temp_ptr[end - start + 1];
     int a = 0;
     int b = start;
     int c = mid + 1;
     while(b <= mid && c <= end)
     {
            if(array[b] > array[c])
            {
                sorted[a] = array[b];
                temp_ptr[a] = ptr_array[b];
                a++; b++;
            }
            else
            {
                sorted[a] = array[c];
                temp_ptr[a] = ptr_array[c];
                a++; c++;
            }
     }

     while(b <= mid) 
     {
         sorted[a] = array[b];
         temp_ptr[a] = ptr_array[b];
         a++; b++;
     }
     while(c <= end)
     {
        sorted[a] = array[c];
        temp_ptr[a] = ptr_array[c];
        a++; c++;
     }
     int i;
     for(i = 0; i < a; i++) 
     {
        array[i + start] = sorted[i];
        ptr_array[i + start] = temp_ptr[i];
     }
}

void merge_sort(long * array, int start, int end, uintptr_t * ptr_array) {
    int mid = (start + end) / 2;
    if(start < end) {
        merge_sort(array, start, mid, ptr_array);
        merge_sort(array, mid + 1, end, ptr_array);
        merge_array(array, start, mid, end, ptr_array);
    }

}



int main(int argc, char *argv[]) {
    long * a = malloc(10 * sizeof(long)); 
    long * ptr_array = malloc(10 * sizeof(uintptr_t));
    long b[] =  {30, 20, 40, 30, 50, 10, 0, 80, 90, -50};
    long idx[] =  {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};


    for (int i = 0; i < 10; i++)
    {
        a[i] = b[i];
        printf("a[i] = %d ", a[i]);
    }
    printf("\n");
    for (int i = 0; i < 10; i++)
    {    
        ptr_array[i] = idx[i];
        printf("ptr[i] = %d ", ptr_array[i]);
    }

    printf("\n");
    printf("\n");

    merge_sort(a, 0, 9, ptr_array);
    for (int i = 0; i < 10; i++)
    {
        printf("a[i] = %d ", a[i]);
    }
    printf("\n");
    for (int i = 0; i < 10; i++)
    {    
        printf("ptr[i] = %d ", ptr_array[i]);
    }
    printf("\n");

}