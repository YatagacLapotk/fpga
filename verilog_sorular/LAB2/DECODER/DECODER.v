module top (
    input [1:0] btn,
    output [3:0] led
);
    assign led = (btn== 2'b00) ? ~4'b0001 :
                 (btn== 2'b01) ? ~4'b0010 :
                 (btn== 2'b10) ? ~4'b0100 :
                 (btn== 2'b11) ? ~4'b1000 :
                 ~4'b0000;
                 
endmodule
