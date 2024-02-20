module vending_machine(
    input clk, rst,
    input logic [1:0]coin,
    output logic candy
);

typedef enum logic [1:0] {S0, S5, S10, S15} state_t;
state_t state, next_state;

always_ff @(posedge clk or negedge rst)
begin
    if(!rst)
        state <= S0;
    else 
        state <= next_state;
end


always_comb 
begin
    next_state = state;
    candy = '0;
    casez(state)
        S0: begin
                if(coin == 2'b01) next_state = S5;
                else if(coin == 2'b10) next_state = S10;
                else next_state = S0;
            end 

        S5: begin
                if(coin == 2'b01) next_state = S10;
                else if(coin == 2'b10) next_state = S15;
                else next_state = S5;
            end 

        S10: begin
                if(coin == 2'b01) next_state = S15;
                else if(coin == 2'b10) next_state = S15;
                else next_state = S10;
            end 

        S15: begin
                next_state = S0;
                candy = '1;
            end

        default: next_state = S0;
    endcase
end

endmodule

`timescale 1ps/1ps

module vending_machine_tb;

parameter PERIOD = 10;

logic clk, rst;
logic [1:0] coin;
logic candy;

always #(PERIOD/2) clk = ~clk;

vending_machine DUT(
    .clk(clk), .rst(rst),
    .coin(coin),
    .candy(candy)
);

initial 
begin
    $dumpfile("vending_machine.vcd");
    $dumpvars(0, vending_machine_tb);

    $display("\t\t time \t coin \t candy");
    // $monitor("%d \t %d \t %b", $time, coin, candy);

    clk = 0;
    rst = 1;
    coin = 2'b00;
    #(PERIOD) rst = 0;

    #(PERIOD) coin = 2'b01;
    $display("%d \t %d \t %b", $time, coin, candy);
    #(PERIOD) coin = 2'b10;
    $display("%d \t %d \t %b", $time, coin, candy);
    #(PERIOD) coin = 2'b01;
    $display("%d \t %d \t %b", $time, coin, candy);
    #(PERIOD) coin = 2'b10;
    $display("%d \t %d \t %b", $time, coin, candy);
    #(PERIOD) $finish;
end

// initial 
//         begin
//             $dumpfile("vending_machine.vcd");
//             $dumpvars(0, vending_machine_tb);
            
//             a=0; b=0;   #10;
//             assert(y===1) else error=1;
            
//             b=1;        #10;
//             assert(y===1) else error=1;
            
//             a=1; b=0;   #10;
//             assert(y===1) else error=1;
            
//             b=1;        #10;
//             assert(y===0) else error=1;
//         end
    
//     always@(a, b, y, error)
//         if(!error) $display("Time=%Dt inputs:a=%b\t b=%b\t output:y=%b", $time, a, b, y);            
        
//         else
//             begin
//                 $error("Test fail at time=%Dt inputs:a=%b\t b=%b\t output:y=%b", $time, a, b, y);
//                 error=0;      
//             end

endmodule
