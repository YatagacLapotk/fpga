module RAM_tb ();
    reg clk;
    reg [11:0] addr;
    reg [15:0] data_in;
    reg we;
    reg re;
    wire [15:0] data_out;

    RAM ram_inst (
        .clk(clk),
        .addr(addr),
        .data_in(data_in),
        .we(we),
        .re(re),
        .data_out(data_out)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock with period of 10 time units
    end

    initial begin
        // Initialize signals
        addr = 0;
        data_in = 16'b0000000000000000;
        we = 0;
        re = 0;

        // Test write operation
        #10 addr = 12'd10; data_in = 16'b1010101010101010; we = 1; re = 0; // Write to address 10
        #10 we = 0; // Disable write

        // Test read operation
        #10 addr = 12'd10; we = 0; re = 1; // Read from address 10
        #10 re = 0; // Disable read

        // Test reading uninitialized memory
        #10 addr = 12'd1; we = 0; re = 1; // Read from address 1 (initialized in RAM)
        #10 re = 0; // Disable read

        #10 addr = 12'd0; we = 0; re = 1; // Read from address 0 (initialized in RAM)
        #10 re = 0; // Disable read

        // Finish simulation
        #20 $finish;
    end

    // Monitor changes
    initial begin
        $dumpfile("RAM_tb.vcd");
        $dumpvars(0, RAM_tb);
    end
    
endmodule