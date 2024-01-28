module Count_bits #(parameter N=32)( 
    input clk, nrst,
    input logic [N-1:0] in,
    output logic [$clog2(N)-1:0] out
);

always_ff @(posedge clk, negedge nrst) begin
    if (!nrst) begin
        out <= 0;
    end
    else begin
        out <= 0;
       
        for (int i=0; i<N; i++) 
        begin
            out <= out + in[i];
        end

        // while(in!=0) 
        // begin
        //     if(in[0]==1) 
        //         out <= out + 1;
            
        //     in <= in & (in-1); // or in <= in >> 1;

        // end
    end
end

endmodule

`timescale 1ns / 1ps

module count_bits_tb;
    logic [31:0] in;
    logic [4:0] out;
    logic clk = 0, nrst;

    always #5 clk = ~clk;

    // Instantiate the count_bits module
    Count_bits #(32) u1 (.clk(clk), .nrst(nrst), .in(in), .out(out));

    // Test sequence
    initial begin
        nrst = 0;
        #10;
        nrst = 1;
        #10;

        // Test different input values
        for (int i = 0; i < 32; i = i + 1) begin
            in = 1 << i; // Only one bit set
            #100;
            if (out != 1) begin
                $display("Test failed: in = %0d, out = %0d, expected = 1", in, out);
            end
        end

        #100;

        in = '1; // All bits set
        #20;
        if (out != 32) begin
            $display("Test failed: in = %0d, out = %0d, expected = 32", in, out);
        end

        $display("Test passed");
        $finish; // End of test
    end
endmodule