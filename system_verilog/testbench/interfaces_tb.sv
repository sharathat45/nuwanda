/*
interface: group many signals to single port
modport: defines signal direction
clocking block: 
    input sampled #n time before the trigger/edge
    output sampled #n delay after the trigger/edge
*/

interface test_if #(parameter N=10)(input clk);
    logic [N-1:0]a;
    logic [N-1:0]c;
    logic [N-1:0]b;


    //default input #1step and output #0ns
    clocking cb_clk @(posedge clk);
        default input #3ns output #2ns;
        input a,b;
        output #1step c; // or output negedge c
        //input #1 output #3 signal_name for inout signal 
    endclocking

    modport test(input a, clk, input b, output c);
    modport tb(output a, output b, input c);

endinterface

module test(test_if.test testif);
endmodule;

module interfaces_tb;
    bit clk;
    always #10 clk=!clk;
    test_if  testif(clk);
    test DUT(testif.test);

    initial begin
        
        @testif.cb_clk;
        // testif.cb_clk.a <= 2;

        testif.a=1;
        testif.b=1;
        $finish;
    end
endmodule