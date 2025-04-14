module minorty (
    input  a,b,c,
    output y
);

assign y = (~a&(~b|~c))|(~b&~c);
    
endmodule