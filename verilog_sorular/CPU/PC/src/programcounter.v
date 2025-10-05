module top #(
    parameter WIDTH = 6,  // Default PC width is 6 bits
    parameter WAIT_TIME = 135000  // Default wait time is 135000 cycles
)(
    input clk,
    input reset,                // Synchronous reset
    input enable,               // Enable PC increment
    input load,                 // Load new PC value (e.g., for jump)
    input [WIDTH-1:0] pc_in,    // New address (for jump)
    // 'pc' is reset to 0 on reset, loaded with 'pc_in' on load, and incremented by 1 on enable after WAIT_TIME cycles
    output reg [WIDTH-1:0] pc   // Current program counter
);
  reg [23:0] clock_counter;

    always @(posedge clk) begin
        if (reset) begin
            pc <= 0;
            clock_counter <= 0;
        end else if (load) begin
            pc <= pc_in;       // Load new address
        end 
        if (enable) begin
            if (clock_counter == WAIT_TIME) begin
                pc <= pc + 1;      // Increment PC
                clock_counter <= 0; // Reset clock counter
            end else begin
                clock_counter <= clock_counter + 1;
            end
        end
      end
endmodule