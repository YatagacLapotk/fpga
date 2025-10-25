//baud kontrolcüsü
// giriş saatinin frekansına göre çıkışa bir sinyal verilecek
//o da kontrol çıkışı olacak
//şimdi tang nanonun saat frekansı 27Mhz 
//bu da demektir ki 0.037 us
//baudrate'imizi 9600 olarak seçmek istiyoruz
//bu da 0.10427ms ediyor
//bunu birbirine eşitlemek içinse 281.54 sayısını buluyoruz 
// yani saatimizi bu kadar sayarsak buna ulaşırız.


module baudgenerator (
    input clk,
    output reg ctrl
);
    reg [16:0] baud_num;
    always @(posedge clk) begin
        if(baud_num==281) begin
            ctrl<=~ctrl;
            baud_num<=0;
        end
        baud_num+=1;
    end
endmodule

module Transmitter (
    input [7:0] data_in,
    input start,
    input clk,
    output reg data_out,
    output reg busy
);
always @(posedge clk) begin
    
end
    
endmodule

module Reciever (
    input data_in,
    input clk,
    output [7:0] data,
    output data_ready
);
    
endmodule


module RS232_2 (
    input clk
);


//BAUD GENERATOR
parameter ClkFrequency = 27000000; 
parameter Baud = 9600;
parameter BaudGeneratorAccWidth = 16;
parameter BaudGeneratorInc = ((Baud<<(BaudGeneratorAccWidth-4))+(ClkFrequency>>5))/(ClkFrequency>>4);

reg [BaudGeneratorAccWidth:0] BaudGeneratorAcc;
always @(posedge clk) begin 
  BaudGeneratorAcc <= BaudGeneratorAcc[BaudGeneratorAccWidth-1:0] + BaudGeneratorInc;
end

wire BaudTick = BaudGeneratorAcc[BaudGeneratorAccWidth];
reg [3:0] state;

// the state machine starts when "TxD_start" is asserted, but advances when "BaudTick" is asserted (115200 times a second)
always @(posedge clk)
case(state)
  4'b0000: if(TxD_start) state <= 4'b0100;
  4'b0100: if(BaudTick) state <= 4'b1000; // start
  4'b1000: if(BaudTick) state <= 4'b1001; // bit 0
  4'b1001: if(BaudTick) state <= 4'b1010; // bit 1
  4'b1010: if(BaudTick) state <= 4'b1011; // bit 2
  4'b1011: if(BaudTick) state <= 4'b1100; // bit 3
  4'b1100: if(BaudTick) state <= 4'b1101; // bit 4
  4'b1101: if(BaudTick) state <= 4'b1110; // bit 5
  4'b1110: if(BaudTick) state <= 4'b1111; // bit 6
  4'b1111: if(BaudTick) state <= 4'b0001; // bit 7
  4'b0001: if(BaudTick) state <= 4'b0010; // stop1
  4'b0010: if(BaudTick) state <= 4'b0000; // stop2
  default: if(BaudTick) state <= 4'b0000;
endcase

reg muxbit;

always @(state[2:0])
case(state[2:0])
  0: muxbit <= TxD_data[0];
  1: muxbit <= TxD_data[1];
  2: muxbit <= TxD_data[2];
  3: muxbit <= TxD_data[3];
  4: muxbit <= TxD_data[4];
  5: muxbit <= TxD_data[5];
  6: muxbit <= TxD_data[6];
  7: muxbit <= TxD_data[7];
endcase

// combine start, data, and stop bits together
assign TxD = (state<4) | (state[3] & muxbit);
    
endmodule