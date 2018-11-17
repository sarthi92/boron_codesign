
module boron(cipherText,done,plainText,masterKey,enc_dec,start,clk,reset);
output [63:0]cipherText;
output done;
input [63:0]plainText;
input [79:0]masterKey;
input enc_dec,start,clk,reset;
wire keyStart,encStart,decStart,keyDone,encdecDone;
wire [2079:0]key_register;
wire [4:0]roundCount;
wire [79:0]round_key,roundKey;
wire [63:0]roundText,addKeyOut,sBoxEncOut,sBoxDecOut,roundTextEnc,roundTextDec;
wire [3:0]sBoxOutKey,sBoxInKey;

control_unit CU_FSM(keyStart,encStart,decStart,done,keyDone,encdecDone,start,enc_dec,clk,reset);
keygen KGEN_FSM(key_register,roundCount,keyDone,masterKey,round_key,keyStart,clk,reset);
key_generator KGEN(round_key,sBoxOutKey,key_register[2079:2000],sBoxInKey,roundCount);
encoder_decoder ENCDEC_FSM(cipherText,roundKey,encdecDone,plainText,roundText,key_register,encStart,decStart,clk,reset);
add_key ADD_KEY(addKeyOut,cipherText,roundKey);
round_enc ROUND_ENC(roundTextEnc,sBoxEncOut);
round_dec ROUND_DEC(roundTextDec,addKeyOut);
s_box KEY_SBOX(sBoxInKey,sBoxOutKey);
s_box_layer_enc SBOX_LAYER_ENC(sBoxEncOut,addKeyOut);
s_box_layer_dec SBOX_LAYER_DEC(sBoxDecOut,roundTextDec);

assign roundText=enc_dec?roundTextEnc:sBoxDecOut;

endmodule
