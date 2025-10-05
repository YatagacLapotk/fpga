module ALUs (
    input [3:0] s,
    input [15:0] A,
    input [15:0] B,
    input cin,
    output reg [15:0] F,
    output reg cout
);

    initial begin
        F = 16'h0000;
        cout = 1'b0;
    end
    always @(*) begin
        case (s)
            4'h0:{cout,F}=(cin)?(B+1):({1'b0,B});
            4'h1:{cout,F}=(cin)?(A+B+1):(A+B);
            4'h2:{cout,F}=(cin)?(A-B):(A-B+1);
            4'h3:{cout,F}=(cin)?(B-1):({1'b0,B});
            4'h4:begin F=A&B; cout=0; end
            4'h5:begin F=A|B; cout=0; end
            4'h6:begin F=A^B; cout=0; end
            4'h7:begin F=~A; cout=0; end
            4'h8:{F,cout}= {cout,A};
            4'h9:{cout,F}={A,cout};
            default: begin F=16'h00; cout=0; end
        endcase
        
    end

endmodule
