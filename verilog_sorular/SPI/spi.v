module spi_master #(
    parameter WIDTH = 8,
    parameter FREQUENCY = 1350000
) (
    input clk,
    input cpol,
    input cpha,
    input miso,
    input start,
    input [WIDTH-1:0] data_in,
    output reg sclk,
    output mosi,
    output finish,
    output ss,
    output [WIDTH-1:0] data_out 
    ); 

    wire sclk_neg;
    wire sclk_pos;




    reg [31:0] m_clk;
    always @(posedge clk) begin
        if (~ss) begin 
            m_clk+=1;
            if (m_clk==FREQUENCY) begin
                sclk=~sclk;
                m_clk=0;
            end
        end
    end

    initial begin
        sclk = cpol;
    end
    reg sclk_a;
    reg sclk_b;
    always @(posedge clk) begin
        if(~ss)begin 
            sclk_a <= sclk;
            sclk_b <= sclk_a;
        end 
    end
    
    assign sclk_neg = ~sclk_a&sclk_b;
    assign sclk_pos = sclk_a&~sclk_b;

    always @(*) begin
        case (cpha)
            1'b0: sclk = sclk_pos; 
            1'b1: sclk = sclk_neg; 
            default: 
        endcase
    end




endmodule

module spi_slave #(
    parameter WIDTH = 8
) (
   input miso,
   output sclk,
   output mosi,
   output ss 
);
    
endmodule
