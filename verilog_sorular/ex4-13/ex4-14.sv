module decoder64 (
    input logic [5:0] a,
    output [63:0] y
);
    wire [3:0] ky1, ky2, ky3;

    // Instantiate three 2:4 decoders
    decoder4 decoder4_u1 (.a(a[1:0]), .y(ky1));
    decoder4 decoder4_u2 (.a(a[3:2]), .y(ky2));
    decoder4 decoder4_u3 (.a(a[5:4]), .y(ky3));

    // Generate 6:64 decoding using three-input AND gates
    genvar i;
    generate
        for (i = 0; i < 64; i=i+1) begin : gen_decoder
            assign y[i] = ky1[i % 4] & ky2[(i / 4) % 4] & ky3[i / 16];
        end
    endgenerate
endmodule

module decoder4 (
    input  logic [1:0] a,
    output logic [3:0] y
);
  
always @(*) begin
    case (a)
        2'b00 :  y<=4'b0001; 
        2'b01 :  y<=4'b0010; 
        2'b10 :  y<=4'b0100; 
        2'b11 :  y<=4'b1000; 
        default: y<=4'b0000;
    endcase
    
end
endmodule