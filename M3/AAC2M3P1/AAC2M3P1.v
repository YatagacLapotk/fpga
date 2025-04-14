module Comparator2(

 input[1:0] A, B,

 output reg Equals

);       		
                   	          	
// student code here
always @(*) begin
	Equals = A==B;
end

endmodule // Comparator2 




    