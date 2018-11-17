module keygen(key_register,roundCount,done,master_key,round_key,start,clk,reset);
output reg [2079:0]key_register;
output reg [4:0]roundCount;
output reg done;
input [79:0]master_key;
input [79:0]round_key;
input start,clk,reset;
reg [79:0]temp_key;
reg ps;
localparam idle=1'd0,busy=1'd1;

always @(negedge clk)
begin
if(reset)
begin
key_register=2080'd0;
roundCount=5'd0;
done=1'd0;
ps=idle;
end
else
begin
case(ps)

idle:
begin
roundCount=5'd0;
done=1'd0;
if(start)
begin
key_register={master_key[79:0],{2000{1'd0}}};
ps=busy;
end
end

busy:
begin
if(roundCount==5'd25)
begin
done=1'd1;
ps=idle;
end
else
begin
temp_key=round_key;
key_register=key_register>>80;
key_register[2079:2000]=temp_key;
roundCount=roundCount+5'd1;
end
end

endcase
end
end

endmodule
