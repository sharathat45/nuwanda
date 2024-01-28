/*
FIFO = 0 1 2 3

circular buffer: 1 slot is left unused to maintain full logic or else use cntr/flag to indicate empty or full
    rptr = 0
    wptr = 0


*/

module FIFO #(parameter N=32, DEPTH=8) (input clk, rst, ren, wen, [N-1:0]wdata, output empty, full, [N-1:0]rdata);

reg [N-1:0] mem [0:DEPTH-1];
reg [log2(DEPTH)-1:0] wptr, rptr;

logic [DEPTH-1:0] flags;
logic [log2(DEPTH)-1:0] cntr;

always @(posedge clk or posedge rst) begin
    if (rst) 
    begin
        wptr <= 0;
        rptr <= 0;
        empty <= 1; //important
        full <= 0;

    end else begin

        //circular buffer:
        if (wen && !full) begin // no write on full ****** important
            mem[wptr] <= wdata;
            wptr <= wptr + 1;
        end
        if (ren && !empty) begin // no read on full ****** important
            rdata <= mem[rptr];
            rptr <= rptr + 1;
        end
        empty <= (wptr == rptr);
        full <= ((wptr + 1) % DEPTH == rptr); // full when next write ptr is equal to read ptr (1%4=1 , 4%4=0)

        //flags:
        if (wen && !full) begin
            mem[wptr] <= wdata;
            flags[wptr] <= 1'b1;
            wptr <= wptr + 1;
        end
        if (ren && !empty) begin
            rdata <= mem[rptr];
            flags[rptr] <= 1'b0;
            rptr <= rptr + 1;
        end
        empty <= flags == '0;
        full <= flags == (2**DEPTH) - 1;

        //counter:
        if (wen && !full) begin
            mem[wptr] <= wdata;
            cntr <= cntr + 1;
            wptr <= wptr + 1;
        end
        if (ren && !empty) begin
            rdata <= mem[rptr];
            cntr <= cntr - 1;
            rptr <= rptr + 1;
        end
        empty <= cntr == '0;
        full <= cntr == DEPTH - 1;
    end
end
    
endmodule

`timescale 1ns / 1ps

module fifo_tb;
    reg clk;
    reg rst;
    reg ren;
    reg wen;
    reg [31:0] wdata;
    wire empty;
    wire full;
    wire [31:0] rdata;

    // Instantiate the FIFO module
    FIFO #(32, 8) u1 (.clk(clk), .rst(rst), .ren(ren), .wen(wen), .wdata(wdata), .empty(empty), .full(full), .rdata(rdata));

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        clk = 0;
        rst = 1;
        ren = 0;
        wen = 0;
        wdata = 0;
        #10 rst = 0;
        #10 wen = 1; wdata = 32'hDEADBEEF; // Write data to FIFO
        #10 wen = 0; ren = 1; // Read data from FIFO
        #10 ren = 0;
        #10 wen = 1; wdata = 32'hCAFEBABE; // Write data to FIFO
        #10 wen = 0; ren = 1; // Read data from FIFO
        #10 ren = 0;
        #10 $finish; // End of test
    end
endmodule