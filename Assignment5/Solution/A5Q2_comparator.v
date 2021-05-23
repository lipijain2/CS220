module comparator(w,y,out);
input [2:0] w;
input [2:0] y;
output wire [2:0] out;
 
wire [2:0]out1;
wire [2:0]out2;
 
assign out1=(w[0]&1)?y:w;
assign out2=(w[1]^y[1])?((w[1]&1)?y:w):out1;
assign out=(w[2]^y[2])?((w[2]&1)?y:w):out2;


endmodule
