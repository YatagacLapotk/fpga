module top (
    input [3:0] A,
    input [1:0] s,
    output Y
);
    wire [1:0] K;
    mux2to1 m1(.A(A[1:0]),.s(s[0]),.Y(K[0]));
    mux2to1 m2(.A(A[3:2]),.s(s[0]),.Y(K[1])); 
    mux2to1 m3(.A(K[1:0]),.s(s[1]),.Y(Y));

endmodule

module mux2to1 (
    input [1:0] A,
    input s,
    output Y
);
    assign Y = s ? (A[1]):
                   (A[0]);
endmodule
