/*
CRV = Constrained Random Verification

static constraint ... //constraints can be static

program name(input clk...)
    initial ...
endprogram

package my_pkg;
endpackage
*/

typedef class mypckt;

module constraints_tb;
initial begin
    mypckt p1;
    p1 = new;
    assert(p1.randomize());
    
    p1.randomize() with {a>5;}

    p1.mode1.constraint_mode(0); //0 = disable, 1= enable
    p1.a.rand_mode(0); // 0 = disable, 1= enable
    assert(p1.a.rand_mode()); // checks disabled or enabled

    $random;
    $cast(a,b); //dynamic casting

    bit a,b;

    sequence s_ab;
        a ##1 b; //b is high after the nxt clk when a is high
    endsequence
    sequence s_cd;
        c ##2 d; //d is high after the nxt 2 clk when c is high
    endsequence

    property p_seq;
        @(posedge clk) s_ab ##1 s_cd; //seq cd is high after nxt clk of seq ab is high
    endproperty

    assert property(p_seq);
    assert property(@(posedge clk) a && b); //both signal are high at posedge clk for whole simulation
    $assert(a&&b);
    // assert() else, $rose(), $fell(), $stable()
    
end
endmodule

class mypckt;
    rand bit[4:0] a;
    randc bit[4:0] b; // won't repeat the val until all possibilities are over
    rand bit[4:0] arr [];

    constraint mode1 { a>5; a<10; }
    constraint mode2 { !(a inside {[5:10]}); b inside {1,2,3,4}; } //between 5 to 10
    constraint mode3 { a  dist { 1:=10, 2:=80, 3:=50}; } //1 has 10/140 chances, 2=80/140, 3=50/140
    extern constraint mode4;
    constraint mode5 {if(a==2) b>5; solve a before b; } //or {a==2 -> b>2}
    constraint mode6 {arr.size()==5; foreach(arr[i])arr[i]==i; };

    function void pre_randomize();
        $display("Before randomisation");
    endfunction

    function void post_randomize();
        $display("After randomisation");
    endfunction  
endclass

constraint mypckt::mode4 {a<2;}

rand bit[2:0]a;
randc bit[2:0]b;

constraint m{
    a inside {1,2,3};
    b inside {[0:5]};
}

constraint n{
    if(a==2)
        b>0;
    solve a before b;
}
