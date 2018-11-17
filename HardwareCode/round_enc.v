module round_enc(cipherText,dataIn);
output reg [63:0]cipherText;
input [63:0]dataIn;
integer x;

always @(*)
begin
//add_round_key and s_box_layer
cipherText=dataIn;

//block shuffle
cipherText[15:0]={cipherText[7:0],cipherText[15:8]};
cipherText[31:16]={cipherText[23:16],cipherText[31:24]};
cipherText[47:32]={cipherText[39:32],cipherText[47:40]};
cipherText[63:48]={cipherText[55:48],cipherText[63:56]};

//round_permutation
cipherText[63:48]={cipherText[54:48],cipherText[63:55]};
cipherText[47:32]={cipherText[40:32],cipherText[47:41]};
cipherText[31:16]={cipherText[27:16],cipherText[31:28]};
cipherText[15:0]={cipherText[14:0],cipherText[15]};

//xor_operation
cipherText[63:0]={cipherText[63:48]^cipherText[47:32]^cipherText[15:0],cipherText[47:32]^cipherText[15:0],cipherText[63:48]^cipherText[31:16],cipherText[63:48]^cipherText[31:16]^cipherText[15:0]};
end

endmodule
