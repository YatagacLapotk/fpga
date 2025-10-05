module RAM (
    input clk,
    input [11:0] addr,
    input [15:0] data_in, 
    input we,
    output reg [15:0] data_out
);

    reg [15:0] mem [0:4095]; // 4KB RAM

    initial begin
        // Initialize memory with some values (for testing)
        mem[0] = 16'b0010000000001000; //LDA
        mem[1] = 16'b0000000000001000; //AND
        mem[2] = 16'b1111100000000000; //INP
        mem[3] = 16'b1111010000000000; //OUT
        mem[4] = 16'b0111000000000001; //halt
        mem[8] = 16'b0000000000000010; //DATA 2
        //data_out initial value
        data_out = mem[0];
    end

    always @(clk) begin
        data_out <= mem[addr];
        if (we) begin
            mem[addr] <= data_in;
        end
    end

endmodule
