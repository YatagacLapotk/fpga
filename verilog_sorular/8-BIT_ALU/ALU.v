module top (
    input [3:0] Ain, Bin,
    input [2:0] opcode,
    output [3:0] led,
    output wire z,
    output reg cout
);
    reg [3:0] Y;
    reg [2:0] op;
    reg c;
    reg [3:0] A,B;
    assign A = ~Ain;
    assign B = ~Bin;
    assign op = ~opcode; 
    always @(*) begin
        Y= 4'b0000;
        c = 0;
        case (op)
            3'b000: {c, Y} = A + B;                  // ADD with carry
            3'b001: {c, Y} = {1'b0, A} - {1'b0, B};   // SUB with borrow-out in c
            3'b010: Y = A & B;
            3'b011: Y = A | B;
            3'b100: Y = A ^ B;
            3'b101: Y = ~A;
            3'b110: Y = A << 1;
            3'b111: Y = A >> 1;
            default: begin
                Y = 4'b0000;
                c = 0;
            end
        endcase
    end
    assign cout = ~c;
    assign led = ~Y;
    assign z = (|Y);  // z = 1 if Y == 0

endmodule
