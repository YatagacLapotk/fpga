module REGISTER12 (
  input clk,
  input rst,
  input ld,
  input inr,
  input [11:0] ld_data,
  output reg [11:0] out
);
  initial begin
    out = 0;
  end 
  always @(posedge clk or posedge rst) begin
    if (rst) out <= 0; 
    else if (ld) out <= ld_data;
    else if (inr) out <= out + 1;
  end

endmodule
