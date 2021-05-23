module encode(a,out);
input [7:0] a;
output [2:0] out;
wire [2:0] out;

assign out[2]=a[4]|a[5]|a[6]|a[7];
assign out[1]=a[2]|a[3]|a[6]|a[7];
assign out[0]=a[1]|a[3]|a[5]|a[7];

endmodule;

