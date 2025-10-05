module RAM (
    input clk,
    input [11:0] addr,
    input [15:0] data_in, 
    input we,
    input re,
    output reg [15:0] data_out
);

    reg [15:0] ram [0:4095]; // 4KB RAM

    always @(posedge clk) begin
        if (we) begin
            ram[addr] <= data_in;
        end
        if (re) begin
            data_out <= ram[addr];
        end
    end

endmodule