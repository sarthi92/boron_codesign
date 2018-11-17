module key_generator(keyOut,sBoxOut,keyIn,sBoxIn,roundCount);
output reg [79:0]keyOut;
output reg [3:0]sBoxOut;
input [79:0]keyIn;
input [3:0]sBoxIn;
input [4:0]roundCount;

always @(*)
begin
keyOut[79:0]={keyIn[66:0],keyIn[79:67]};
sBoxOut=keyOut[3:0];
keyOut[3:0]=sBoxIn;
keyOut[63:59]=keyOut[63:59]^roundCount;
end

endmodule
