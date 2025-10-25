module cla #(
    parameter WIDTH = 4
) (
    input [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    input carry_in,
    output [WIDTH-1:0] sum,
    output carry_out
);
    wire [WIDTH-1:0] g = a&b; // generate
    wire [WIDTH-1:0] p = a|b; // generate

    assign carry_out = (g[3]|(p[3]&(g[2]|(p[2]&(g[1]|(p[1]&g[0]))))))|
                       ((&p)&carry_in);
    assign sum = a+b+carry_in;
endmodule
