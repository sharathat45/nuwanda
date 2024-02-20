/*
Cross domain crossing:
    Signal moving from clk1 to clk2 domain

*/

module CDC_FF (
    input  clk_src,
    input  clk_dst,
    input  async_reset,
    input  src_data,
    output dst_data
);

    reg ff1, ff2;
    reg reset_sync_src, reset_sync_dst;

    // Synchronize reset to source clock domain
    always @(posedge clk_src or negedge async_reset) begin
        if (!async_reset)
            reset_sync_src <= 1'b0;
        else
            reset_sync_src <= 1'b1;
    end

    // Synchronize reset to destination clock domain
    always @(posedge clk_dst or negedge async_reset) begin
        if (!async_reset)
            reset_sync_dst <= 1'b0;
        else
            reset_sync_dst <= 1'b1;
    end

    // Source domain flip-flop
    always @(posedge clk_src or posedge reset_sync_src) begin
        if (reset_sync_src)
            ff1 <= 1'b0;
        else
            ff1 <= src_data;
    end

    // Destination domain flip-flop
    always @(posedge clk_dst or posedge reset_sync_dst) begin
        if (reset_sync_dst)
            ff2 <= 1'b0;
        else
            ff2 <= ff1;
    end

    assign dst_data = ff2;

endmodule