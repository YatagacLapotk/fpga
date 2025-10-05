module cu_tb();

    reg clk;
    reg [15:0] ir;
    reg [15:0] dr;
    reg [15:0] ac;
    reg r;
    reg e;
    reg FGO_in;
    reg FGI_in;
    reg reset;
    wire r_s;
    wire [1:0] e_s;
    wire [2:0] S;
    wire [2:0] pc_s;
    wire [2:0] ar_s;
    wire [2:0] ir_s;
    wire [2:0] ac_s;
    wire [2:0] dr_s;
    wire [2:0] tr_s;
    wire [2:0] outr_s;
    wire [3:0] alu_s;
    wire inputr_s;
    wire IEN;
    wire halt;
    wire mem_read;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end


    CU cu (
        .clk(clk),
        .ir(ir),
        .dr(dr),
        .ac(ac),
        .r(r),
        .e(e),
        .FGO_in(FGO_in),
        .FGI_in(FGI_in),
        .reset(reset),
        .r_s(r_s),
        .e_s(e_s),
        .S(S),
        .pc_s(pc_s),
        .ar_s(ar_s),
        .ir_s(ir_s),
        .ac_s(ac_s),
        .dr_s(dr_s),
        .tr_s(tr_s),
        .outr_s(outr_s),
        .alu_s(alu_s),
        .inputr_s(inputr_s),
        .IEN(IEN),
        .halt(halt),
        .mem_read(mem_read)
    );

    initial begin
        // Initialize signals
        reset = 1;
        ir = 16'b0000000000000000; // NOP instruction
        dr = 16'b0000000000000000;
        ac = 16'b0000000000000000;
        r = 0;
        e = 0;
        FGO_in = 0;
        FGI_in = 0;

        // Release reset after some time
        #10;
        reset = 0;

        #20;
        ir = 16'b0000000000000010; // Example AND instruction
        #40;

        ir = 16'b0010000000000011; // Example LDA instruction
        #40;

        // Finish simulation
        $finish;
    end

    initial begin
        $dumpfile("cu_tb.vcd");
        $dumpvars(0, cu_tb);
    end


endmodule