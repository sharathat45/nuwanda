#include <iostream>
#include <vector>
using namespace std;

#define ITER
// #define SORT_METHOD(ARR,N) counting_sort(ARR)
#define SORT_METHOD(ARR,N) fun(ARR,0,N-1)

//time cmplx: o(n), space cmplx: o(1)
void reverse(int start, int end, vector<int> &arr)
{

#ifdef RECURSIVE
    if(start >= end)
        return;
    int temp = arr[start];
    arr[start] = arr[end];
    arr[end] = temp;
    reverse(start+1, end-1, arr);
#endif

#ifdef ITER
    int n = end + 1;
    for (int i = 0; i < n / 2; i++)
    {
        int temp = arr[i];
        arr[i] = arr[n-1-i];
        arr[n-1-i] = temp;
    }
#endif

#ifdef INBUILT
    reverse(arr.begin(), arr.end());
#endif
}

/*
no optimization for worst = best
time cmplx: o(n^2), space cmplx: o(1)
*/
void selection_sort(vector<int> &arr)
{
    int n = arr.size();
    for (int i = 0; i < n; i++)
    {
        int min = i;
        for (int j = i+1; j < n; j++)
        {
            if(arr[j] < arr[min])
                min = j;
        }
        int temp = arr[i];
        arr[i] = arr[min];
        arr[min] = temp;
    }
}

/*
best: o(n) already sorted
worst: o(n^2) reverse order
space cmplx: o(1)
*/
void bubble_sort(vector<int> &arr)
{
    int n = arr.size();
    for (int i = 0; i < n; i++)
    {
        bool swap = false;
        for (int j = 0; j < n - 1; j++)
        {
            if(arr[j] > arr[j+1])
            {
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
                swap = true;
            }
        }
        if(!swap)
            break;
    }

}

/*
time cmplx: o(nlogn) best, worst, avg
space cmplx: o(n)
*/
void merge(vector<int> &arr, int start, int mid, int end)
{
    int n1 = mid - start + 1;
    int n2 = end - mid;
    vector<int> left(n1);
    vector<int> right(n2);
    for (int i = 0; i < n1; i++)
    {
        left[i] = arr[start + i];
    }
    for (int i = 0; i < n2; i++)
    {
        right[i] = arr[mid + 1 + i];
    }
    int i = 0, j = 0, k = start;
    while (i < n1 && j < n2)
    {
        if(left[i] <= right[j])
        {
            arr[k] = left[i];
            i++;
        }
        else
        {
            arr[k] = right[j];
            j++;
        }
        k++;
    }
    while (i < n1)
    {
        arr[k] = left[i];
        i++;
        k++;
    }
    while (j < n2)
    {
        arr[k] = right[j];
        j++;
        k++;
    }
}

void merge_sort(vector<int> &arr, int start, int end)
{
    if(start >= end)
        return;
    int mid = start + (end - start) / 2;
    merge_sort(arr, start, mid);
    merge_sort(arr, mid+1, end);
    merge(arr, start, mid, end);
}

/*
Best case: o(nlogn)
worst case: o(n^2)  when pivot is smallest or largest
space cmplx: best: o(logn) -> binary tree ht , worst: o(n)
*/
void quick_sort(vector<int> &arr, int start, int end)
{
    if(start >= end)
        return;
    int pivot = arr[end];
    int i = start - 1;
    for (int j = start; j < end; j++)
    {
        if(arr[j] < pivot)
        {
            i++;
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
    }
    int temp = arr[i+1];
    arr[i+1] = arr[end];
    arr[end] = temp;
    quick_sort(arr, start, i);
    quick_sort(arr, i+2, end);
}

/*
stable sort: maintains the order
n: no of elements, k: range of input
time cmplx: o(n + k), space cmplx: o(n+k)
*/
void counting_sort(vector<int> &arr)
{
    int max = * max_element(arr.begin(), arr.end());
    int n = arr.size();
    vector<int> count(max+1, 0);
    vector<int> arr_copy(arr);

    for (auto i: arr)
        count[i]++;

    for (int i = 1; i < max+1; i++)
        count[i] += count[i-1];
    
    for (int i = n-1; i >= 0; i--)
    {
        arr[count[arr_copy[i]]-1] = arr_copy[i];
        count[arr_copy[i]]--;
    }
}

/* stable sort
time cmplx: o(n + k), space cmplx: o(n+k)
k = range of input
*/
void radix_sort(vector<int> &arr)
{
    int max = * max_element(arr.begin(), arr.end());
    int n = arr.size();
    for (int pos = 1; max/pos > 0; pos *= 10)
    {
        vector<int> count(10, 0);
        vector<int> arr_copy(arr);

        for (auto i: arr)
            count[(i/pos)%10]++;
        for (int i = 1; i < 10; i++)
            count[i] += count[i-1];
        for (int i = n-1; i >= 0; i--)
        {
            arr[count[(arr_copy[i]/pos)%10]-1] = arr_copy[i];
            count[(arr_copy[i]/pos)%10]--;
        }
    }
}

int main()
{
    vector<int> arr = {5, 2, 3, 4, 6, 1};
    int n = arr.size();

    SORT_METHOD(arr,n);
    reverse(0, n - 1, arr);
    reverse(0, n - 1, arr);

    for (auto i: arr)
    {
        cout << i << " ";
    }
    cout << endl;

    return 0;
}