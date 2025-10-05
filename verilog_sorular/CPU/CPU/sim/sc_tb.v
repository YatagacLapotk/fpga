module sc_tb ();

reg clk;
reg rst;
wire [7:0] sc_out;

SC sc_inst (
    .clk(clk),
    .rst(rst),
    .data_out(sc_out)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units clock period
end
// Test sequence
initial begin
    // Initialize reset
    rst = 1;
    #10; // Hold reset for 10 time units
    rst = 0;
    // Run the simulation for a certain period
    #100;
    // Finish the simulation
    $finish;            
end
initial begin
    $dumpfile("sc_tb.vcd");
    $dumpvars(0, sc_tb);
end


endmodule