
module RAM_tb;

    reg clk;
    reg [11:0] addr;
    reg [15:0] data_in;
    wire [15:0] data_out;
    reg we;
    reg re;

    top dut (
        .clk(clk),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out),
        .we(we),
        .re(re)
    );

    initial begin
        // Initialize signals
        clk = 0;
        addr = 0;
        data_in = 0;
        we = 0;
        re = 0;

        // Write data to RAM
        @(posedge clk);
        addr = 12'h000;
        data_in = 16'hA5A5;
        we = 1;
        re = 0;

        @(posedge clk);
        addr = 12'h001;
        data_in = 16'h5A5A;
        we = 1;
        re = 0;

        @(posedge clk);
        addr = 12'h002;
        data_in = 16'hFFFF;
        we = 1;
        re = 0;

        // Stop writing
        @(posedge clk);
        we = 0;

        // Read data from RAM
        @(posedge clk);
        addr = 12'h000;
        re = 1;

        @(posedge clk);
        addr = 12'h001;

        @(posedge clk);
        addr = 12'h002;

        // Finish simulation
        @(posedge clk);
        re = 0;
        $finish;
    end
    // Waveform dumping for simulation analysis
    initial begin
        $dumpfile("ram.vcd");
        $dumpvars(0,RAM_tb);
    end

    always #5 clk = ~clk;

endmodule

