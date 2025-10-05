module SC (
    input clk,
    input rst,
    output reg [3:0] data_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) data_out <= 0;
        else data_out <= data_out + 1;
    end
endmodule
