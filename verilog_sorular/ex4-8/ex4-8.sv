module mux8 (
    input logic [2:0] s,
    input logic [7:0] d,
    output y
);
assign y = s[2] ?   (s[1] ? (s[0] ? (d[7]):(d[6])):(s[0] ? (d[5]):(d[4])))
                :   (s[1] ? (s[0] ? (d[3]):(d[2])):(s[0] ? (d[1]):(d[0])));
    
endmodule