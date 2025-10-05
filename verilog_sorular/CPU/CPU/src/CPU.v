module top (
    input clk_in,
    input reset,
    input [7:0] inregister,
    output [7:0] outregister
);

/*//CLOCK DIVIDER
localparam CLK_DIV = 0; //1Hz for 27MHz input clock
reg [24:0] clk_counter = 0;
reg clk_in;
always @(posedge clk) begin
    if (clk_counter == CLK_DIV) begin
        clk_in = ~clk_in;
        clk_counter = 0;
    end
    else begin
        clk_counter = clk_counter + 1;
    end
end*/

//REGISTER PARAMETERS
wire [11:0] AR_out;
wire [11:0] PC_out;
wire [15:0] IR_out;
wire [15:0] MEM_out;
wire [15:0] DR_out;
wire [15:0] AC_out;
wire [15:0] AC_in;
wire [15:0] ALU_out;
wire [15:0] TR_out;
wire [7:0] INPR_out;
wire [3:0] sct; 
wire E;
wire I;
wire FGI_in;
wire FGO_in;
wire IEN;



//Control Parameters
wire [2:0] S;
wire [2:0] pc_s;
wire [2:0] ar_s;
wire [2:0] ir_s;
wire [2:0] ac_s;
wire [2:0] dr_s;
wire [2:0] tr_s;
wire [2:0] outr_s;
wire [3:0] alu_s;
wire [1:0] e_s;
wire sct_reset;
wire inputr_s;
wire mem_read;
wire mem_write;
wire halt;


//Control Unit
CU CU_unit (
    .clk(clk_in),
    .ir(IR_out),
    .dr(DR_out),
    .ac(AC_out),
    .sct(sct),
    .e(E),
    .FGI_in(FGI_in),
    .FGO_in(FGO_in),
    .reset(reset),
    .e_s(e_s),
    .S(S),
    .pc_s(pc_s),
    .ar_s(ar_s),
    .ir_s(ir_s),
    .ac_s(ac_s),
    .dr_s(dr_s),
    .tr_s(tr_s),
    .sct_reset(sct_reset),
    .outr_s(outr_s),
    .inputr_s(inputr_s),
    .alu_s(alu_s),
    .IEN(IEN),
    .halt(halt),
    .mem_write(mem_write)
);
//sequence timer
wire sct_clk;
assign sct_clk = clk_in & ~halt; 
SC sctimer(
    .clk(sct_clk),
    .rst(sct_reset),
    .data_out(sct)
);

//BUS
wire [15:0] BUS;
assign BUS =(S == 3'b000) ? 8'h00 :
            (S == 3'b001) ? {4'b0, AR_out} :
            (S == 3'b010) ? {4'b0, PC_out} :
            (S == 3'b011) ? DR_out :
            (S == 3'b100) ? AC_out :
            (S == 3'b101) ? IR_out :
            (S == 3'b110) ? TR_out :
            (S == 3'b111) ? MEM_out : 16'b0;
//ALU

ALUs ALU_unit (
    .A(AC_out),
    .B(DR_out),
    .s(alu_s),
    .cin(E),
    .F(ALU_out),
    .cout(E)
);

//REGISTERS
REGISTER12 AR (
    .clk(clk_in),
    .rst(ar_s[0]),
    .ld(ar_s[2]),
    .inr(ar_s[1]),
    .ld_data(BUS[11:0]),
    .out(AR_out)
);
REGISTER12 PC (
    .clk(clk_in),
    .rst(pc_s[0]),
    .ld(pc_s[2]),
    .inr(pc_s[1]),
    .ld_data(BUS[11:0]),
    .out(PC_out)
);

REGISTER16 IR (
    .clk(clk_in),
    .rst(ir_s[0]),
    .ld(ir_s[2]),
    .inr(ir_s[1]),
    .ld_data(BUS),
    .out(IR_out)
);

REGISTER16 DR (
    .clk(clk_in),
    .rst(dr_s[0]),
    .ld(dr_s[2]),
    .inr(dr_s[1]),
    .ld_data(BUS),
    .out(DR_out)
);
assign AC_in = (inputr_s) ? {8'b0, INPR_out} : ALU_out;
REGISTER16 AC (
    .clk(clk_in),
    .rst(ac_s[0]),
    .ld(ac_s[2]),
    .inr(ac_s[1]),
    .ld_data(AC_in),
    .out(AC_out)
);

REGISTER16 TR (
    .clk(clk_in),
    .rst(tr_s[0]),
    .ld(tr_s[2]),
    .inr(tr_s[1]),
    .ld_data(BUS),
    .out(TR_out)
);

inputr INPR (
    .data_in(inregister),
    .data_out(INPR_out),
    .FGI(FGI_in)
);

Outr OUTR (
    .clk(clk_in),
    .ld(outr_s[2]),
    .data_in(BUS[7:0]),
    .data_out(outregister),
    .FGO(FGO_in)
);

//MEMORY
RAM MEMORY_unit (
    .clk(clk_in),
    .addr(AR_out),
    .data_in(BUS),
    .we(mem_write),
    .data_out(MEM_out)
);


endmodule