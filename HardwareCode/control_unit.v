module control_unit(keyStart,encStart,decStart,done,keyDone,encdecDone,start,enc_dec,clk,reset);
output reg keyStart,encStart,decStart,done;
input keyDone,encdecDone,start,enc_dec,clk,reset;
localparam idle=2'd0,keygen=2'd1,enc=2'd2,dec=2'd3;
reg [1:0]ps;

always @(posedge clk)
begin
if(reset)
begin
keyStart=1'd0;
encStart=1'd0;
decStart=1'd0;
done=1'd0;
ps=idle;
end
else
begin
case(ps)

idle:
begin
keyStart=1'd0;
encStart=1'd0;
decStart=1'd0;
done=1'd0;
if(start==1'd1)
begin
keyStart=1'd1;
ps=keygen;
end
end

keygen:
begin
keyStart=1'd0;
if(keyDone==1'd1 && enc_dec)
begin
encStart=1'd1;
ps=enc;
end
else if(keyDone==1'd1 && !enc_dec)
begin
decStart=1'd1;
ps=dec;
end
end

enc:
begin
encStart=1'd0;
if(encdecDone==1'd1)
begin
done=1'd1;
ps=idle;
end
end

dec:
begin
decStart=1'd0;
if(encdecDone==1'd1)
begin
done=1'd1;
ps=idle;
end
end

endcase
end
end

endmodule