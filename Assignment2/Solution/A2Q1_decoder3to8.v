module decode(a,out);
input [2:0] a;
output [7:0] out;
wire [7:0] out;

assign out[7]=a[0]&a[1]&a[2];
assign out[6]=(~a[0])&a[1]&a[2];
assign out[5]=a[0]&(~a[1])&a[2];
assign out[4]=(~a[0])&(~a[1])&a[2];
assign out[3]=a[0]&a[1]&(~a[2]);
assign out[2]=(~a[0])&a[1]&(~a[2]);
assign out[1]=a[0]&(~a[1])&(~a[2]);
assign out[0]=(~a[0])&(~a[1])&(~a[2]);

endmodule
