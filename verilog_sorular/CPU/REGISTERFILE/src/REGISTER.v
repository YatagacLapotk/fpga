module moduleName (
    input clk,
    input reset,
    input ld,
    input inr,
    input [15:0] data_in,
    output reg [15:0] data_out
);
    reg [15:0] temp;
    always @(posedge clk) begin
        temp <= data_out;    
        if (reset) begin
            data_out<=0;
        end else if (ld) begin
            data_out<=data_in;
        end else if (inr) begin
            data_out<=data_out+1;
        end
        else 
            data_out<=temp;

    end  
endmodule