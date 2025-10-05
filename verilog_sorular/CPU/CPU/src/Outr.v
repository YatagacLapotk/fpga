module Outr (
    input clk,
    input ld,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg FGO
);
    initial begin
        data_out = 8'h00;
        FGO = 1'b0;
    end
    always @(posedge clk) begin
        if (ld) begin
            data_out <= data_in;
        end
        if (data_in != 8'h00) begin
            FGO <= 1'b1; // Ready to send data
        end else begin
            FGO <= 1'b0; // Not ready to send data
        end
    end

endmodule
