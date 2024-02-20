Class: 
    User-defined data type that has data members and member functions.

Encapsulation: 
    binding together the data and the functions that manipulate them
    Encapsulation improves readability, maintainability, and security by grouping data and methods together.

Abstraction:
    displaying only essential information and hiding the details. 
    - by header files
    - by Class

    1. Data Abstraction: variables in private
    2. Control Abstraction: functions in private 

Polymorphism:
    having many forms
    - function overloading
    - operator overloading
    - virtual functions

Inheritance:
    - Super Class or Base Class or Superclass.
    - Sub Class or Derived Class.
    - Reusability: by inherinting we can use base class methods and functions in derived class.

(OOPS supports static binding: connects function call and definition at build time.)
Dynamic binding:
    Code to be executed in response to the function call is decided at runtime
    - virtual functions

Message passing:
    - Objec

copy constructor:
    class abc{
        int a;
        public:
            abc(int x):a(x){}
            abc(abc &obj): a(obj.a;){}
    };

Shallow copy:
    if variables/class obj are in heap memory then only address is copied not the value.
    - default copy constructor from cpp
    - assignment operator (=)
    obj1 = obj2;

Deep copy:
    allocated saimilar memory resources in heap
    - user defined copy constructor
    - for any var defined in heap memory, copy constructor should create new heap memory and define int
    
    class abc{
        int *p; int a;
        public:
            abc(int x):a(x){
                p = new int;
                *p = x;
            }
            abc(abc &obj):a(obj.a){
                p = new int;
                *p = *(obj.p);
            }
    };