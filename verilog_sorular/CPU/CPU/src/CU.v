module CU (
    input clk,
    input [15:0] ir,
    input [15:0] dr,
    input [15:0] ac,
    input [3:0] sct,
    input e,
    input FGO_in,
    input FGI_in,
    input reset,
    output reg [1:0] e_s,
    output reg [2:0] S,
    output reg [2:0] pc_s,
    output reg [2:0] ar_s,
    output reg [2:0] ir_s,
    output reg [2:0] ac_s,
    output reg [2:0] dr_s,
    output reg [2:0] tr_s,
    output reg [2:0] outr_s,
    output reg [3:0] alu_s,
    output reg sct_reset,
    output reg inputr_s,
    output reg IEN,
    output reg halt,
    output reg mem_write
);

//timer setup
reg [15:0] dec_t; //decoded timer

always @(sct,reset) begin
    if (reset) begin
            dec_t = 16'b0000_0000_0000_0000;
    end
    else begin
        case (sct)
            4'b0000: dec_t = 16'b0000_0000_0000_0001; //T0
            4'b0001: dec_t = 16'b0000_0000_0000_0010; //T1
            4'b0010: dec_t = 16'b0000_0000_0000_0100; //T2
            4'b0011: dec_t = 16'b0000_0000_0000_1000; //T3
            4'b0100: dec_t = 16'b0000_0000_0001_0000; //T4
            4'b0101: dec_t = 16'b0000_0000_0010_0000; //T5
            4'b0110: dec_t = 16'b0000_0000_0100_0000; //T6
            4'b0111: dec_t = 16'b0000_0000_1000_0000; //T7
            4'b1000: dec_t = 16'b0000_0001_0000_0000; //T8
            4'b1001: dec_t = 16'b0000_0010_0000_0000; //T9
            4'b1010: dec_t = 16'b0000_0100_0000_0000; //T10
            4'b1011: dec_t = 16'b0000_1000_0000_0000; //T11
            4'b1100: dec_t = 16'b0001_0000_0000_0000; //T12
            4'b1101: dec_t = 16'b0010_0000_0000_0000; //T13
            4'b1110: dec_t = 16'b0100_0000_0000_0000; //T14
            4'b1111: dec_t = 16'b1000_0000_0000_0000; //T15 
            default: dec_t = 16'b0000_0000_0000_0000; 
        endcase
    end
end

//opcode decoder
reg [7:0] dec_op;//decoded opcode
reg I; //indirect bit
reg r = 1'b0; //interrupt flip-flop

//state encoding
localparam FETCH = 2'b00; 
localparam DECODE = 2'b01;
localparam EXECUTE = 2'b10; 

reg r_io; //I/O operation flip-flop
reg [1:0] state; //state register

always @(dec_t,reset) begin
    e_s <= 2'b00;
    pc_s <= 3'b000;
    ar_s <= 3'b000;
    ir_s <= 3'b000;
    ac_s <= 3'b000;
    dr_s <= 3'b000;
    tr_s <= 3'b000;
    outr_s <= 3'b000;
    inputr_s <= 1'b0;
    alu_s <= 4'b0000;
    sct_reset <= 1'b0;
    mem_write <= 1'b0;
    halt <= 1'b0;
    S <= 3'b000;
    if (reset) begin 
        state<= FETCH;
        e_s <= 2'b00;
        pc_s <= 3'b000;
        ar_s <= 3'b000;
        ir_s <= 3'b000;
        ac_s <= 3'b000;
        dr_s <= 3'b000;
        tr_s <= 3'b000;
        outr_s <= 3'b000;
        inputr_s <= 1'b0;
        mem_write <= 1'b0;
        alu_s <= 4'b0000;
        sct_reset <= 1'b1;
        S <= 3'b000;
    end   
    else begin      
        if(~dec_t[0] && ~dec_t[1] && ~dec_t[2] && IEN &&(FGO_in||FGI_in)) r<=1'b1;
        case (state)
            FETCH:begin 
                r_io <= 1'b0;
                if(~r)begin
                    if(dec_t[0])begin 
                        ar_s <= 3'b100;
                        S <= 3'b010; //AR <- PC
                    end
                    else if (dec_t[1]) begin
                        S <= 3'b111; 
                        ir_s <= 3'b100; //IR <- M[AR]
                        pc_s <= 3'b010; //PC <- PC + 1
                        state <= DECODE;
                    end
                end
                else if (r) begin //Interrupt
                    if(dec_t[0])begin 
                        ar_s <= 3'b001;
                        tr_s <= 3'b100;
                        S <= 3'b010; //TR <- PC
                    end
                    else if (dec_t[1]) begin
                        S <= 3'b110;
                        mem_write <= 1'b1; //M[AR] <- TR
                        pc_s <= 3'b001; //PC <- 0 
                    end
                    else if (dec_t[2]) begin
                        pc_s <= 3'b010; //PC <- PC + 1
                        r <= 1'b0;
                        IEN <= 1'b0;
                        sct_reset <= 1'b1; //reset sequence timer
                        state <= FETCH; //go to fetch state
                    end
                end 
            end
            DECODE: begin
                if (dec_t[2]) begin
                    S <= 3'b101;
                    ar_s <= 3'b100; //AR <- IR[11-0]
                    I = ir[15];
                    case (ir[14:12])
                        3'b000: dec_op = 8'b0000_0001;
                        3'b001: dec_op = 8'b0000_0010;
                        3'b010: dec_op = 8'b0000_0100;
                        3'b011: dec_op = 8'b0000_1000;
                        3'b100: dec_op = 8'b0001_0000;
                        3'b101: dec_op = 8'b0010_0000;
                        3'b110: dec_op = 8'b0100_0000;
                        3'b111: dec_op = 8'b1000_0000; 
                        default: dec_op = 8'b0000_0000; 
                    endcase
                if(dec_op[7])begin 
                    state<=EXECUTE;
                end 
                end 
                else if (dec_t[3]) begin
                    if(I)begin 
                        S <= 3'b111;
                        ar_s <= 3'b100; //AR <- M[AR]
                    end
                    state<=EXECUTE;
                end
            end
            EXECUTE: begin 
                if(dec_t[3])begin 
                    if (~I) begin
                        if (ir[11]) ac_s<=3'b001;//CLA
                        if (ir[10]) e_s<=2'b01;//CLE
                        if (ir[9]) begin //CMA
                            ac_s<=3'b100;
                            alu_s <= 4'b0111;
                        end
                        if (ir[8]) e_s <= 2'b10;//CME
                        if (ir[7]) begin //CIR
                            ac_s <= 3'b100;
                            alu_s<=4'b1000;
                        end
                        if (ir[6]) begin //CIL
                            ac_s <= 3'b100;
                            alu_s<=4'b1001;
                        end
                        if (ir[5]) ac_s<=3'b010;//INC
                        if (ir[4]) begin//SPA
                            if(~ac[15])begin
                                pc_s<= 3'b010;
                            end
                        end
                        if (ir[3]) begin//SNA
                            if(ac[15])begin
                                pc_s<= 3'b010;
                            end
                        end
                        if (ir[2]) begin //SZA
                            if(ac==0)begin
                                pc_s<= 3'b010;
                            end
                        end
                        if (ir[1]) begin//SZE
                            if(e)begin
                                pc_s<= 3'b010;
                            end
                        end
                        if (ir[0]) halt<= 1'b1; //HLT
                    end
                    else if(I) begin 
                        if(ir[11])begin //INP
                            ac_s <= 3'b100;
                            inputr_s <= 1'b1;
                        end
                        if(ir[10])begin //OUT
                            S<=3'b100;
                            outr_s <= 3'b100;
                        end
                        if (ir[9]) begin //SKI
                            if(FGO_in) pc_s <= 3'b010;
                        end
                        if (ir[8]) begin //SKO
                            if(FGO_in) pc_s <= 3'b010;
                        end
                        if (ir[7]) IEN <= 1'b1;//ION
                        if (ir[6]) IEN <= 1'b0;//IOF
                    end
                    r_io <= 1'b1;
                end
                else if (r_io)begin
                    sct_reset <= 1'b1;
                    state <= FETCH; //go to fetch state
                end
                else begin 
                    if (dec_op[0]) begin //AND 
                        if (dec_t[4]) begin
                            S <= 3'b111;
                            dr_s <= 3'b100; //DR <- M[AR]
                        end
                        else if (dec_t[5]) begin
                            alu_s <= 4'b0100;
                            ac_s <= 3'b100; //AC <- AC AND DR
                        end
                        else begin
                            sct_reset <= 1'b1;
                            state <= FETCH; //go to fetch state
                        end
                    end
                    if (dec_op[1]) begin //ADD 
                        if (dec_t[4]) begin
                            S <= 3'b111;
                            dr_s <= 3'b100; //DR <- M[AR]
                        end
                        else if (dec_t[5]) begin
                            alu_s <= 4'b0001;
                            ac_s <= 3'b100; //AC <- AC + DR
                        end
                        else begin
                            sct_reset <= 1'b1;
                            state <= FETCH; //go to fetch state
                        end
                    end
                    if (dec_op[2]) begin //LDA
                        if (dec_t[4]) begin
                            S <= 3'b111;
                            dr_s <= 3'b100; //DR <- M[AR]
                        end
                        else if (dec_t[5]) begin
                            S <= 3'b011;
                            ac_s <= 3'b100; //AC <- DR
                        end
                        else begin
                            sct_reset <= 1'b1;
                            state <= FETCH; //go to fetch state
                        end
                    end
                    if (dec_op[3]) begin //STA
                        if (dec_t[4]) begin
                            S <= 3'b100;
                            mem_write <= 1'b1; //M[AR] <- AC 
                        end
                        else begin
                            sct_reset <= 1'b1;
                            state <= FETCH;
                        end
                    end
                    if (dec_op[4]) begin //BUN
                        if (dec_t[4]) begin
                            S <= 3'b001;
                            pc_s <= 3'b100; //PC <- AR 
                        end
                        else begin
                            sct_reset <= 1'b1;
                            state <= FETCH;
                        end
                    end
                    if (dec_op[5]) begin //BSA
                        if (dec_t[4]) begin
                            S <= 3'b010;
                            mem_write <= 1'b1; //M[AR] <- PC
                        end
                        else if (dec_t[5]) begin
                            S <= 3'b001;
                            pc_s <= 3'b100; //PC <- AR
                        end
                        else begin
                            sct_reset <= 1'b1;
                            state <= FETCH;
                        end
                    end
                    if (dec_op[6]) begin //BSA
                        if (dec_t[4]) begin
                            S <= 3'b111;
                            dr_s <= 3'b100; //DR <- M[AR]
                        end
                        if (dec_t[5]) begin
                            dr_s <= 3'b010; //DR <- DR + 1
                        end
                        else if (dec_t[6]) begin
                            S <= 3'b011;
                            mem_write <= 1'b1; // M[AR] <- DR;
                            if (dr==0) pc_s <= 3'b010; //PC <- PC + 1
                        end
                        else begin
                            sct_reset <= 1'b1;
                            state <= FETCH;
                        end
                    end
                end 
            end
            default: begin 
                    e_s <= 2'b00;
                    pc_s <= 3'b000;
                    ar_s <= 3'b000;
                    ir_s <= 3'b000;
                    ac_s <= 3'b000;
                    dr_s <= 3'b000;
                    tr_s <= 3'b000;
                    outr_s <= 3'b000;
                    sct_reset <= 1'b0;
                    mem_write <= 1'b0;
                    S <= 3'b000;
                end 
        endcase
    end   
end
endmodule
