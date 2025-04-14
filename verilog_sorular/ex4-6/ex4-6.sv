/*
a= AB’C’ + A’BD + AD’ + A’C + BC + B’D’
b = A’C’D’ + A’CD + AC’D + B’C’ + B’D’
c = A’C’ + A’D + C’D + A’B + AB’
d = A’B’D’ + B’CD + BC’D + BCD’ + AC’
e = B’D’ + CD’ + AC + AB
f = A’BC’ + C’D’ + BD’ + AB’ + AC
g = A’BC’ + B’C + CD’ + AB’ + AD
*/
module sevensegment (
  input logic A, B, C, D,
  output a,b,c,d,e,f,g  
);
    wire An = ~A;    
    wire Bn = ~B;    
    wire Cn = ~C;    
    wire Dn = ~D;
    assign a = (A&Bn&Cn)|(An&B&D)|(A&Dn)|(An&C)|(B&C)|(Bn&Dn);   
    assign b = (An&Cn&Dn)|(An&C&D)|(A&Cn&D)|(Bn&Cn)|(Bn&Dn);
    assign c = (An&Cn)|(An&D)|(Cn&D)|(An&B)|(A&Bn);
    assign d = (An&Bn&Dn)|(Bn&C&D)|(B&Cn&D)|(B&C&Dn)|(A&Cn);
    assign e = (Bn&Dn)|(C&Dn)|(A&C)|(A&B);
    assign f = (An&B&Cn)|(Cn&Dn)|(B&Dn)|(A&Bn)|(A&C);
    assign g = (An&B&Cn)|(Bn&C)|(C&Dn)|(A&Bn)|(A&D);


endmodule