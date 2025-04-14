module func2(
    input a, 
    input b, 
    input c,
    output y
);
    assign k1 = ~c;
    assign k2 = c;
    assign k3 = 1;
    assign k4 = 0;
    mux4 mux4_u(
        .s({a,b}),
        .d({k1,k2,k3,k4}),
        .y(y)
    );
endmodule