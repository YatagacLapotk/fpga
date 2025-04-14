module xor4 (
    input [3:0] x,
    output y
);

assign y = ^x;
    
endmodule