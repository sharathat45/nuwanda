#include <iostream>
#include <string>
using namespace std;

int main(){

    int arr[5] = {0,1,2,3,4};
    // Ranged for loop
    for(int var : arr){cout<<var<<endl;}
    
    int n = 5;
    float* p = new float[n];
    *(p+1) = 1;
    delete[] p;
    //Now P Dangling pointer
    p = NULL; // good practise to avoid dangling pointer

    void *ptr;
    ptr = &n; 

    string str = "abcd";
    n = str.length();
    string str2 = "efgh";
    str.append(str2);
    str.swap(str2);
    getline(cin,str);

    char str3[7] = {'a','b','c','d','e','f','\0'};
    cin.get(str3,7);
    str = str + to_string(12);

    // #include <cstring>
    // strlen();
    // strcat();
    // strcpy();

    //toupper(char); tolower(char);
    //for(char& c : str) -> auto loop

    n = sizeof(arr)/sizeof(arr[0]);
    sort(arr, arr+n); //to sort the array in ascending order
    sort(arr, arr+n, greater<int>()); //to sort the array in descending order
    //custom functions other than greater
    struct Point{
        int x,y;
    };
    Point p[5] = {{1,2},{3,4},{5,6},{7,8},{9,10}};
    sort(arr, arr + n, [](Point a, Point b)
         { return a.x > b.x; }); // to sort the array with custom functoion or just passfunction name
    return 0;
}
