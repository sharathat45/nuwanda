#include<iostream>
#define SUM(a,b) a+b
using namespace std;

//function templates
template <typename T>
T add(T a, T b){
    return a+b;
}

//class templates
template <class T>
class mypair{
    private:
        T a,b;
    public:
        mypair(T first, T second){
            a = first;
            b = second;
        }
        T getmax(){
            return a>b?a:b;
        }
        void changemax(T c){
            a = a > b ? c:a;
            b = a > b ? c:b;
        }
};

//functional overloading: same  2 function name but different argumentsor number of arguments

enum day_1{mon,tue,wed,thu,fri,sat,sun};
enum season{summer, winter=8, spring} season_t;

namespace int_data{
    int x = 5;
    int y = 10;
}
namespace first{
   void func(){cout << "Inside first namespace" << endl;}
}
namespace second{
   void func(){cout << "Inside second namespace" << endl;}
}
int main(){
    int c = add<int>(1,2);
    float b = add<float>(1.0,2.0);

    mypair<int> myobj(100, 75);
    myobj.changemax(200);
    cout << myobj.getmax() << endl;

    day_1 d = mon;
    cout<< day_1::mon <<endl;
    cout<< season::winter << season::winter <<endl;
    season_t = spring;
    cout <<  season_t  << endl;

    int_data::x = 10;
    double x = 5.0;
    using namespace first;
    func();
    second::func();

    return 0;
}