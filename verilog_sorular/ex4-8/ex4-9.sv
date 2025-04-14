module func (
    input a, b, c,
    output y
);
    wire [7:0] mux_inputs;

    // Define the truth table for y = ab + bc + abc
    assign mux_inputs[0] = 0; // 000
    assign mux_inputs[1] = 0; // 001
    assign mux_inputs[2] = 0; // 010
    assign mux_inputs[3] = 1; // 011
    assign mux_inputs[4] = 0; // 100
    assign mux_inputs[5] = 1; // 101
    assign mux_inputs[6] = 1; // 110
    assign mux_inputs[7] = 1; // 111

    // Instantiate the 8:1 multiplexer
    mux8 u_mux8 (
        .s({a, b, c}),
        .d(mux_inputs),
        .y(y)
    );
endmodule