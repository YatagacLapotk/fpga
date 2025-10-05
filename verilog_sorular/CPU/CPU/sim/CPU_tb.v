module CPU_tb ();
    reg clk;
    reg reset;
    reg [7:0] inputr;
    wire [7:0] outputr;
    // Instantiate the CPU module
    top cpu (
        .clk_in(clk),
        .reset(reset),
        .inregister(inputr),
        .outregister(outputr)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units clock period
    end

    // Test sequence
    initial begin
        // Initialize reset
        reset = 1;
        #15; // Hold reset for 15 time units
        reset = 0;

        inputr = 8'b00000100; // Example input
        // Run the simulation for a certain period
        #1000;

        // Finish the simulation
        $finish;
    end

    // Monitor signals (optional)
    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, CPU_tb);
    end
endmodule