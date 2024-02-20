
module MUX #(parameter INPUT=8, WIDTH=32, SEL_WIDTH = $clog2(INPUT)) (
    input logic [WIDTH-1:0] in [0:INPUT-1],
    input logic [SEL_WIDTH-1:0] sel,
    output logic [WIDTH-1:0] out
);

//Encoded
assign out = in[sel];

//one hot encoding => SEL_WIDTH = INPUT
always_comb
begin
    for (int i=0; i<INPUT; i++) begin
        out = (sel[i] == 1) ? in[i] : '0;
    end
end

endmodule


`timescale 1ns / 1ps

module mux_tb;
    logic [31:0] in [0:7];
    logic [2:0] sel;
    logic [31:0] out;

    // Instantiate the MUX module
    MUX #(8, 32, 3) u1 (.in(in), .sel(sel), .out(out));

    // Test sequence
    initial begin
        // Initialize inputs
        for (int i = 0; i < 8; i = i + 1) begin
            in[i] = i;
        end

        // Test different select values
        for (int i = 0; i < 8; i = i + 1) begin
            sel = i;
            #10;
            if (out != in[i]) 
            begin
                $display("Test failed: sel = %0d, out = %0d, expected = %0d", i, out, in[i]);
            end
        end

        $display("Test passed");
        $finish; // End of test
    end
endmodule