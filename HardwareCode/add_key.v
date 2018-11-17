module add_key(addKeyOut,roundText,roundKey);
output [63:0]addKeyOut;
input [63:0]roundText;
input [79:0]roundKey;

assign addKeyOut=roundText^roundKey[63:0];

endmodule