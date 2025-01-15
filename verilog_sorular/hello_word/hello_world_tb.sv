module and_gate_tb;

    // Testbench signals
    reg in1, in2;
    wire out1;

    // Instantiate the and_gate module
    and_gate uut (
        .in1(in1),
        .in2(in2),
        .out1(out1)
    );

    // Test sequence
    initial begin
        // Initialize inputs
        in1 = 0; in2 = 0;
        #10;
        in1 = 0; in2 = 1;
        #10;
        in1 = 1; in2 = 0;
        #10;
        in1 = 1; in2 = 1;
        #10;

        // Finish simulation
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("At time %t, in1 = %b, in2 = %b, out1 = %b", $time, in1, in2, out1);
    end

endmodule
