#include <iostream>
using namespace std;

class Server
{   
    public:
        static string a;
        static int compute(long long A, long long B)
        {
            if (A < 0 || B < 0)
                throw std::invalid_argument("A and B should be non-negative");

            int result = A % B;
            return result;
        }
};

string Server::a = "hello";

int main()
{
long long A =10, B = -10;

try
{
    int result = Server::compute(A, B);
    cout << result << '\n';
}
catch (const std::bad_alloc &e)
{
    cout << "Not enough memory" << '\n';
}
catch (const exception &e)
{
    cout << "Exception: " << e.what() << '\n';
}
catch (...)
{
    cout << "Other Exception" << '\n';
}
return 0;
}