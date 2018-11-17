module round_dec(cipherText,dataIn);
output reg [63:0]cipherText;
input [63:0]dataIn;
integer x;

always @(*)
begin
//add_round_key
cipherText=dataIn;

//xor_operation_dec
cipherText[63:0]={cipherText[63:48]^cipherText[47:32],cipherText[47:32]^cipherText[31:16]^cipherText[15:0],cipherText[63:48]^cipherText[47:32]^cipherText[31:16],cipherText[31:16]^cipherText[15:0]};

//round_permutation_dec
cipherText[63:48]={cipherText[56:48],cipherText[63:57]};
cipherText[47:32]={cipherText[38:32],cipherText[47:39]};
cipherText[31:16]={cipherText[19:16],cipherText[31:20]};
cipherText[15:0]={cipherText[0],cipherText[15:1]};

//block shuffle
cipherText[15:0]={cipherText[7:0],cipherText[15:8]};
cipherText[31:16]={cipherText[23:16],cipherText[31:24]};
cipherText[47:32]={cipherText[39:32],cipherText[47:40]};
cipherText[63:48]={cipherText[55:48],cipherText[63:56]};

end

endmodule
