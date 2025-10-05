module top
(
    input clk,
    input reset,            // Added reset input
    input enable,
    output [5:0] led
);

localparam WAIT_TIME = 5000000;
reg [5:0] ledCounter = 0;
reg [23:0] clockCounter = 0;

always @(posedge clk) begin
    if (~reset) begin
        clockCounter <= 0;
        ledCounter <= 0;
    end else if (~enable) begin
        clockCounter <= clockCounter + 1;
        if (clockCounter == WAIT_TIME) begin
            clockCounter <= 0;
            ledCounter <= ledCounter + 1;
        end
    end
end

assign led = ~ledCounter;
endmodule
