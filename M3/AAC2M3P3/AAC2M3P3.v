
module find_errors                           // line 1
  (input  [3:0]a,                             // line 2
  output reg [3:0]b,                             // line 3
  input  [5:0]c);                               // line 4
                                             // line 5
  wire [0:3]aw;                              // line 6
  wire [3:0]bw;                              // line 7
  reg [5:0]creg                              // line 8
always @(*) begin                                        // line 9
  assign aw = a;                             // line 10
  assign b = bw;                             // line 11
  assign creg = c;                           // line 12
always @(*) begin                            // line 13                                       // line 14
    if (creg = 4'hF)   //creg is all 1s     // line 15 
       bw <= aw;                             // line 16  
    else                                     // line 17
     bw <= '0101';                           // line 18   
    end;                                     // line 19
  end process;                               // line 20  
endmodule                                          // line 21   

    