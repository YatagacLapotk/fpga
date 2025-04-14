module mux4 (
    input logic [1:0]s,
    input logic [3:0]d,
    output y
);
assign y = s[1] ? (s[0] ? (d[3]):(d[2]))
                : (s[0] ? (d[1]):(d[0]));
endmodule