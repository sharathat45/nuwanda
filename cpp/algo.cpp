#include <iostream>
using namespace std;

int gcd(int a, int b)
{
    while (a != 0 && b != 0)
    {
        int m = min(a,b);
        int n = max(a,b);
        a = n % m;
        b = m;
    }
   return max(a,b);
}
//6,8 -> 8,6 -> 6,2 -> 2,0

int lcm(int a, int b)
{
    return (a * b) / gcd(a, b);
}

//max product subarray [-1,2,3,4] -> 2*3*4=24
//optimise: make single loop
int maxProduct(vector<int> &nums)
{
    int max1 = INT_MIN, p = 1;
    for (auto i : nums)
    {
        p = p * i;
        max1 = max(p, max1);
        p = (p == 0) ? 1 : p;
    }
    p = 1;
    for (int i = nums.size() - 1; i > -1; i--)
    {
        p = p * nums[i];
        max1 = max(p, max1);
        p = (p == 0) ? 1 : p;
    }
    return max1;
}

int main()
{
    int num1 = 60, num2 = 48;
    int gcdResult = gcd(num1, num2);
    int lcmResult = lcm(num1, num2);

    cout << "The GCD of " << num1 << " and " << num2 << " is " << gcdResult << std::endl;
    cout << "The LCM of " << num1 << " and " << num2 << " is " << lcmResult << std::endl;

    return 0;
}
