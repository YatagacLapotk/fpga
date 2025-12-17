`include "/Users/yatagaclapotk/Desktop/Genel_Calismalar/FPGA/verilog_sorular/FPGA_PROTOTYPING_BOOK/multi_function_barrel_shifter/first_pogram.v"

module shiftselect_tb ();

    reg [7:0] in_tb;
    reg lr_tb;
    wire[7:0] out_tb;

    shiftselect uut(.in(in_tb),.lr(lr_tb),.out(out_tb));

    reg clk;

    initial begin
        clk=0;
        forever #5 clk=~clk;
    end

    initial begin

        in_tb=8'b10101010;
        lr_tb = 1'b0;
        #10;
        in_tb=8'b11101010;
        lr_tb = 1'b1;
        #10;
        in_tb=8'b00000010;
        lr_tb = 1'b0;
        #10;
        $finish;
    end
    initial begin
        $dumpfile("shiftselect_tb.vcd");
        $dumpvars(0, shiftselect_tb);
    end
endmodule
