module shiftselect (
    input [7:0] in,
    input  lr,
    output [7:0] out
);
    
assign out = lr ? {in[6:0],1'b0}:{1'b0,in[7:1]};
    
endmodule