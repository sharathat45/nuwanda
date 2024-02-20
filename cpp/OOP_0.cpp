#include <iostream>
#include <string>
using namespace std;

class car{
    private:
        string car_name;

    public:
        // data members
        int gear, speed;

        // (only one copy) shared data members across all objects
        static string car_build;
        //only static var inside static functions
        static void display_car_build(){ cout<<"car build = "<<car_build<<endl;}

        // CONSTRUCTOR, by default compilers creates constructor intialising all data members to 0
        car(int g, int s): gear(g), speed(s), car_name("Benz"){}
        // or car(int g, int s){gear = g; speed = s;}

        // setter function
        void set_name(string name) { car_name = name;}
        // getter function
        string get_name() { return car_name; }

        car( const car &C ): gear(C.gear), speed(C.speed) {} // copy constructor

};

//for static variables
string car::car_build;
// void car::display_car_build()
// {
//     cout<<"car build = "<<car_build<<endl;
// }

int main(){

    car car1(1,20);
    car car2(5,100);

    cout<<"gear = "<<car1.gear<<endl;
    cout<<"name = "<<car1.get_name()<<endl;

    //ptr to class constructor
    car *car_ptr = new car(3,40);
    car_ptr -> gear=4;
    cout<<"car ptr gear = "<<car_ptr -> gear<<endl;    
    
    //accessing static variables
    car1.car_build = "race car";
    car::car_build = "road car";
    car2.display_car_build();
    car::display_car_build();
    cout<<"car build = "<<car2.car_build<<endl;

return 0;
}

//members of class are private by default, members of struct are public by default