module s_box(dataOut,dataIn);
output reg [3:0]dataOut;
input [3:0]dataIn;
always @(*)
begin
case(dataIn)
4'h0:dataOut=4'hE;
4'h1:dataOut=4'h4;
4'h2:dataOut=4'hB;
4'h3:dataOut=4'h1;
4'h4:dataOut=4'h7;
4'h5:dataOut=4'h9;
4'h6:dataOut=4'hC;
4'h7:dataOut=4'hA;
4'h8:dataOut=4'hD;
4'h9:dataOut=4'h2;
4'hA:dataOut=4'h0;
4'hB:dataOut=4'hF;
4'hC:dataOut=4'h8;
4'hD:dataOut=4'h5;
4'hE:dataOut=4'h3;
4'hF:dataOut=4'h6;
default:dataOut=4'h0;
endcase
end
endmodule