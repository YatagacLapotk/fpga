`timescale 1ns/1ps

module tb_top;
    reg [3:0] A, B;
    reg [2:0] opcode;
    wire [3:0] Y;
    wire z;
    wire c;

    // Instantiate the DUT (Device Under Test)
    top uut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .led(Y),
        .z(z),
        .c(c)
    );

    // Test all opcodes and dump waveforms
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb_top);

        $display("Time |   A    B   OP  |   Y   C Z");
        A = 4'b0101; B = 4'b0011; opcode = 3'b000; #10;
        // SUB
        A = 4'b1001; B = 4'b0010; opcode = 3'b001; #10;
        // AND
        A = 4'b1100; B = 4'b1010; opcode = 3'b010; #10;
        // OR
        A = 4'b0110; B = 4'b0011; opcode = 3'b011; #10;
        // XOR
        A = 4'b1111; B = 4'b0101; opcode = 3'b100; #10;
        // NOT A
        A = 4'b1010; B = 4'b0000; opcode = 3'b101; #10;
        // Shift Left A
        A = 4'b0011; B = 4'b0000; opcode = 3'b110; #10;
        // Shift Right A
        A = 4'b1000; B = 4'b0000; opcode = 3'b111; #10;

        // Zero check
        A = 4'b0000; B = 4'b0000; opcode = 3'b000; #10;

        // Zero check
        A = 4'b0000; B = 4'b0000; opcode = 3'b000; #10;

        $finish;
    end

endmodule