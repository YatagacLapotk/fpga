module inputr (
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg FGI
);
    initial begin
        data_out = 8'h00;
        FGI = 1'b0;
    end
    always @(*) begin
        data_out = data_in;
        if (data_in != 8'h00) begin
            FGI = 1'b1; // Data is available
        end else begin
            FGI = 1'b0; // No data available
        end
    end
    
endmodule
