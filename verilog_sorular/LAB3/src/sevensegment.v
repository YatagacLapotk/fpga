module top (
    input [3:0] A,B,
    output cout,
    output [6:0] seg_out
);
    wire [3:0] led;
    FourbitAdder fba(.A(A), .B(B), .Cout(cout), .led(led));
    sevensegment sseg(.i(led), .out(seg_out));

endmodule

module sevensegment (
    input [3:0] i,
    output reg [6:0] out
);
    always @(*) begin       
        case (~i)
            4'h0: out = ~7'b1000000;
            4'h1: out = ~7'b1111001;
            4'h2: out = ~7'b0100100;
            4'h3: out = ~7'b0110000;
            4'h4: out = ~7'b0011001;
            4'h5: out = ~7'b0010010;
            4'h6: out = ~7'b0000010;
            4'h7: out = ~7'b1111000;
            4'h8: out = ~7'b0000000;
            4'h9: out = ~7'b0010000;
            4'hA: out = ~7'b0001000;
            4'hB: out = ~7'b0000011;
            4'hC: out = ~7'b1000110;
            4'hD: out = ~7'b0100001;
            4'hE: out = ~7'b0000110;
            4'hF: out = ~7'b0001110;
            default: out = ~7'b1111111; 
        endcase     
    end
 
endmodule
module FourbitAdder (
    input [3:0] A,B,
    output Cout,
    output [3:0] led
);
    wire [2:0] K;
    OnebitAdder a0(.A(A[0]),.B(B[0]),.Cin(1'b1), .Y(led[0]),.Cout(K[0]));
    OnebitAdder a1(.A(A[1]),.B(B[1]),.Cin(K[0]),.Y(led[1]),.Cout(K[1]));
    OnebitAdder a2(.A(A[2]),.B(B[2]),.Cin(K[1]),.Y(led[2]),.Cout(K[2]));
    OnebitAdder a3(.A(A[3]),.B(B[3]),.Cin(K[2]),.Y(led[3]),.Cout(Cout));
endmodule

module OnebitAdder (
    input A,B,Cin,
    output Y,Cout
);
    assign {Cout,Y} = A+B+Cin;
endmodule
