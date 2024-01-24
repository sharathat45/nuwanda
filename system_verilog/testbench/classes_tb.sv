/*
class obj instantiation shld be inside initial begin

child c ;
base b = c::new(1); scope operator
allowed: b = c
not allowed: c = b =>use  if(! $cast(c,b))  else assert(error)

class name #(int N=10);
name #(5) n;

class name #(type T=int);
    T a,b;
endfunction
name #(byte) n;

virtual class name; cannot be instantiated but can be extended/inherited as base class
virtual class name;
    pure virtual function void fun(); no need of definition for pure functions
endclass

*/

typedef class base; //inform compiler that this class is defined later
typedef class child;

module classes_tb;
initial begin
    child b, b1, b2;
    b = new(1);
    $display("a = %0d, c = %0d", b.a, b.c);

    b.display();

    child::ctrl = 1; //or b.ctrl = 1;
    child::ex();

    b1 = new(5);
    b2 = new b1; //shalllow copy: won't copy obj of subclass to b2
    b1.hdr.h = 2;
    $display("b2.hdr.h = %0d ", b2.hdr.h); //changed to 2
    
    b2 = new(0);
    b2.copy(b1); //deep copy
    b1.hdr.h = 8;
    $display("b2.hdr.h = %0d ", b2.hdr.h); //won't change to 8
end
endmodule

class base;
    int a;
    local int m=0; //only accessible within this class or this handle, cannot be inherited

    function new(int val);
        a = val;
    endfunction

    virtual function display();
        $display("base class");
    endfunction
endclass

class header;
    int h;
    extern function void hello();
endclass

function void header::hello();
    $display("header class");
endfunction

class child extends base;
    int c;
    header hdr;
    
    static int ctrl = 0;
    static function ex();
    endfunction

    function new(int val);
        super.new(val);
        c = val;

        hdr = new;
        hdr.h = val;
    endfunction

    function display();
        $display("child class");
    endfunction

    function copy(child c1);
        this.c = c1.c;
        this.hdr.h = c1.hdr.h;
    endfunction
endclass