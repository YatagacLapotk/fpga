module top (
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
