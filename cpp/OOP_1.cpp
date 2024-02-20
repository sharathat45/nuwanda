#include <iostream>
#include <string>
using namespace std;


class animal{
        int val; //private by default

    private:
        int leg_count;

        friend class tiger; //friend class can access private members of this class
        friend int find_count(animal); //friend function can access private members of this class

    public:
        string name;
        void display(){cout<<"I'm animal"<<endl;}
        void make_sound() { cout << "I'm making sound" << endl; }
        
        animal() : leg_count(4) {} // constructor

    protected: //protected can be only accessed by same member or subclass
        string owner;
        void display_owner(){cout<<"I'm owner "+owner<<endl;}
};

class dog: public animal{
    public:
        void display_who(){cout<<"I'm "+name<<endl;} 
        void display_info(){owner="Pallu"; display_owner();}
        void make_sound(){
            cout<<"I'm barking"<<endl;
            animal::make_sound(); //:: scope resolution operator
        }      
};

int find_count(animal a)
{
    return a.leg_count;
}

class tiger
{
    public:
        animal a1;
        tiger() { cout << "tiger legs are " << a1.leg_count << endl; }
};


class base
{
    public:
        virtual void print() { cout << "base function" << endl; }
        virtual void print2() = 0; //pure virtual function, hence this class is called abstract class

        void print3() { cout << "base normal function" << endl; }
};

class derived : public base
{
    public:
        void print() { cout << "derived function" << endl; }
        void print2() { cout << "derived pure virtual function" << endl; }
};

int main(){
 
    dog dog1;
    dog1.name = "zuko";
    dog1.display();
    dog1.display_who();
    dog1.display_info();
    
    dog1.make_sound(); //or
    dog1.animal::make_sound(); //to access superclass

    animal cat;
    cout << "cat legs are " << find_count(cat) << endl; 
    tiger t1;

    // base* b = new derived(); //cannot instantiate the abstract class
    // b->print(); //should be derived function, making base function virtual will make it derived function
    derived d1;
    d1.print();
    d1.print2();
    d1.print3();

    return 0;
}
