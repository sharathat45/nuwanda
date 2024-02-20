// #include <stdc++.h>
#include <iostream>
using namespace std;

class Box
{
private:
    long long l, b, h;

public:
    Box(int length=0, int breadth=0, int height=0) : l(length), b(breadth), h(height) {}
    Box(Box& B) : l(B.l), b(B.b), h(B.h) {}
    int getLength()  { return l; } // Return box's length
    int getBreadth() { return b; } // Return box's breadth
    int getHeight()  { return h; } // Return box's height
    long long CalculateVolume() { return (l * b * h); } // Return the volume of the box

    friend ostream &operator<<(ostream &os, Box &bobj);

    // operator overload '<'
    bool operator<(Box &bobj)
    {
        if (l < bobj.l)
            return true;
        else if (b < bobj.b && l == bobj.l)
            return true;
        else if (h < bobj.h && b == bobj.b && l == bobj.l)
            return true;
        
        return false;
    }
};

ostream& operator<<(ostream &os, Box &bobj)
{
    os << bobj.l << " " << bobj.b << " " << bobj.h << endl;
    return os;
}

int main()
{
        Box b1;               // Should set b1.l = b1.b = b1.h = 0;
        Box b2(1039, 3749, 8473); // Should set b1.l = 2, b1.b = 3, b1.h = 4;
        b2.getLength();       // Should return 2
        b2.getBreadth();      // Should return 3
        b2.getHeight();       // Should return 4
        cout << b2.CalculateVolume()<<endl; // Should return 24
        bool x = (b1 < b2);   // Should return true based on the conditions given
        cout << b2;           // Should print 2 3 4 in order.
}
