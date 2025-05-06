module truth_t (
    input A,B,C,
    output Y1,Y2,Y3
);
    assign Y1 = (A|~B)&C;
    assign Y2 = ~A;
    assign Y3 = ~A| ~B&(~C|~D)|(B&D);
    
endmodule