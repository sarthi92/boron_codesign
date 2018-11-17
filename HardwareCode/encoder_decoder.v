module encoder_decoder(cipherText,roundKey,done,plainText,roundText,key_register,encStart,decStart,clk,reset);
output reg [63:0]cipherText;
output reg [79:0]roundKey;
output reg done;
input [63:0]plainText,roundText;
input [2079:0]key_register;
input encStart,decStart,clk,reset;
localparam idle=2'd0,enc=2'd1,dec=2'd2;
reg [4:0]round;
reg [1:0]ps;

always @(negedge clk)
begin
if(reset)
begin
cipherText=64'd0;
roundKey=80'd0;
done=1'd0;
round=5'd0;
ps=idle;
end
else
begin
case(ps)

idle:
begin
done=1'd0;
round=5'd0;
if(encStart)
begin
cipherText=plainText;
roundKey=key_register[79:0];
ps=enc;
end
else if(decStart)
begin
cipherText=plainText;
roundKey=key_register[2079:2000];
ps=dec;
end
end

enc:
begin
cipherText=roundText;
round=round+5'd1;
if(round==5'd25)
begin
cipherText=cipherText^key_register[2079:2000];
done=1'd1;
ps=idle;
end
else
roundKey=key_register[80*round+79-:80];
end

dec:
begin
cipherText=roundText;
round=round+5'd1;
if(round==5'd25)
begin
cipherText=cipherText^key_register[79:0];
done=1'd1;
ps=idle;
end
else
roundKey=key_register[80*(5'd25-round)+79-:80];
end

endcase
end
end


endmodule
