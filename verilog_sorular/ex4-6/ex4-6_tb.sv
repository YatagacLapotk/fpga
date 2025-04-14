module testbench ();
    reg  [3:0] x;
    wire [6:0] y;
    sevensegment dut(
        .A(x[3]), 
        .B(x[2]), 
        .C(x[1]), 
        .D(x[0]), 
        .a(y[0]), 
        .b(y[1]), 
        .c(y[2]), 
        .d(y[3]), 
        .e(y[4]), 
        .f(y[5]), 
        .g(y[6]));
    
    initial begin
    x=4'b0000; #10;
    x=4'b0001; #10;
    x=4'b0010; #10;
    x=4'b0011; #10;
    x=4'b0100; #10;
    x=4'b0101; #10;
    x=4'b0110; #10;
    x=4'b0111; #10;
    x=4'b1000; #10;
    x=4'b1001; #10;
    x=4'b1010; #10;
    x=4'b1011; #10;
    x=4'b1100; #10;
    x=4'b1101; #10;
    x=4'b1110; #10;
    x=4'b1111; #10;
    end
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,testbench);
    end 
endmodule