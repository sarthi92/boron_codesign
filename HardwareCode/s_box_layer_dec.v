module s_box_layer_dec(sBoxLayerOut,cipherIn);
output [63:0]sBoxLayerOut;
input [63:0]cipherIn;

s_box_dec s15(sBoxLayerOut[63:60],cipherIn[63:60]);
s_box_dec s14(sBoxLayerOut[59:56],cipherIn[59:56]);
s_box_dec s13(sBoxLayerOut[55:52],cipherIn[55:52]);
s_box_dec s12(sBoxLayerOut[51:48],cipherIn[51:48]);
s_box_dec s11(sBoxLayerOut[47:44],cipherIn[47:44]);
s_box_dec s10(sBoxLayerOut[43:40],cipherIn[43:40]);
s_box_dec s9(sBoxLayerOut[39:36],cipherIn[39:36]);
s_box_dec s8(sBoxLayerOut[35:32],cipherIn[35:32]);
s_box_dec s7(sBoxLayerOut[31:28],cipherIn[31:28]);
s_box_dec s6(sBoxLayerOut[27:24],cipherIn[27:24]);
s_box_dec s5(sBoxLayerOut[23:20],cipherIn[23:20]);
s_box_dec s4(sBoxLayerOut[19:16],cipherIn[19:16]);
s_box_dec s3(sBoxLayerOut[15:12],cipherIn[15:12]);
s_box_dec s2(sBoxLayerOut[11:8],cipherIn[11:8]);
s_box_dec s1(sBoxLayerOut[7:4],cipherIn[7:4]);
s_box_dec s0(sBoxLayerOut[3:0],cipherIn[3:0]);

endmodule
