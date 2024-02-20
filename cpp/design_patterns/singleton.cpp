/*

Singleton pattern : ensure that only one object of a class is created, no owner
    ex: logger

*/

#include <iostream>
#include <string>
#include <chrono> // Add this line
#include <thread> // Add this line
using namespace std;

/**
 * The Singleton class defines the `GetInstance` method that serves as an
 * alternative to constructor and lets clients access the same instance of this
 * class over and over.
 */
class Singleton
{
    /**
     * The Singleton's constructor should always be private to prevent direct
     * construction calls with the `new` operator.
     */

protected:
    Singleton(const string value) : value_(value) {}
    static Singleton *singleton_;
    string value_;

public:
    
    // Singletons should not be cloneable.
    Singleton(Singleton &other) = delete;
    // Singletons should not be assignable.
    void operator=(const Singleton &) = delete;
    static Singleton *GetInstance(const string &value);
    void SomeBusinessLogic(){ /* ... */}
    string value() const{ return value_; }
};

Singleton* Singleton::singleton_ = nullptr;
Singleton* Singleton::GetInstance(const string &value)
{
    if (singleton_ == nullptr) { singleton_ = new Singleton(value); }
    return singleton_;
}

void ThreadFoo()
{
    this_thread::sleep_for(chrono::milliseconds(1000));
    Singleton *singleton = Singleton::GetInstance("FOO");
    cout << singleton->value() << "\n";
}


void ThreadBar()
{
    this_thread::sleep_for(chrono::milliseconds(1000));
    Singleton *singleton = Singleton::GetInstance("BAR");
    cout << singleton->value() << "\n";
}

int main()
{
    cout << "If you see the same value, then singleton was reused (yay!\n"
        << "If you see different values, then 2 singletons were created (booo!!)\n\n"
        << "RESULT:\n";
    thread t1(ThreadFoo);
    thread t2(ThreadBar);
    t1.join();
    t2.join();
    return 0;
}
