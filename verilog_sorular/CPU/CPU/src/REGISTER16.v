module REGISTER16 (
    input clk,
    input rst,
    input ld,
    input inr,
    input [15:0] ld_data,
    output reg [15:0] out
);
    initial begin
        out = 0;
    end
    always @(posedge clk) begin
        if (rst) begin
            out <= 0;
        end else if (ld) begin
            out <= ld_data;
        end else if (inr) begin
            out <= out + 1;
        end
        // else retain previous value (no assignment needed)
    end
endmodule
