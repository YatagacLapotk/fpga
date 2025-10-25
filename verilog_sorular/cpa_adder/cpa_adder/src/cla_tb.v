module cla_tb ();
    reg [3:0] a;
    reg [3:0] b;
    reg c_in;
    wire c_out;
    wire [3:0] sum;

    cla clainst(
        .a(a),
        .b(b),
        .carry_in(c_in),
        .sum(sum),
        .carry_out(c_out)
    );

    reg clk;
    initial begin
        clk = 0;
        forever #5 clk=~clk;
    end

    initial begin
        a = 4'b0010;
        b = 4'b0100;
        c_in = 1'b1;
        #10;  
        a = 4'b0110;
        b = 4'b001;
        c_in = 1'b1;
        #10;  
        a = 4'b0011;
        b = 4'b1101;
        c_in = 1'b1;
        #10;  
        a = 4'b0001;
        b = 4'b0001;
        c_in = 1'b1;
        #10;
        $finish;  
    end

    initial begin
        $dumpfile("cla_tb.vcd");
        $dumpvars(0,cla_tb);
    end
    

endmodule