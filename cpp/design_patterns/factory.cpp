#include <iostream>
#include <string>
using namespace std;

/*
Creational pattern
1. Singleton
2. Factory
3. Abstract Factory
4. Builder
5. Prototype

Factory pattern : create an object without exposing creation logic, runtime instantioation / dynamic binding

toy{ virtual ~toy(), virtual fun()}
    car: toy {car(), fun()}
    bike: toy {bike(), fun()}

toy *t = new car/bike
t->fun()

Abstract Factory pattern : create an instance of several families of classes    

*/

class toy{
    protected:
        string name;
        float price;
    public:
        virtual ~toy() {}
        virtual void print() = 0;
};

class car: public toy{
    public:
        car() {name = "building car"; price = 10;}
        void print(){ cout << "name = " << name << "," << " price = " << price << endl; }
};

class bike: public toy{
    public:
        bike() {name = "building bike"; price = 20;}
        void print(){ cout << "name = " << name << "," << " price = " << price << endl; }
};

class toyfactory{
    public:
        static toy* createToy(string type){
            toy *Toy = NULL;
            if(type.compare("car") == 0) Toy = new car;
            else if(type.compare("bike") == 0) Toy = new bike;
            else return NULL;
            Toy->print();
            return Toy;
        }
};

int main(){
    toy *t = toyfactory::createToy("car");
    t->print();
    delete t;
    return 0;
}