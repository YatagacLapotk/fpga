
module programcounter (
    input clk,
    input reset,
    output reg [3:0] pc
);

    always @(posedge clk) begin
        if (reset) begin
            pc <= 4'b0000;
        end else begin
            pc <= pc + 1;
        end
    end

endmodule