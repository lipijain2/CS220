module eight_bit_comparator(a,b,l_out,e_out,g_out);
input [7:0]a;
input [7:0]b;
output l_out,e_out,g_out;
wire l_out,e_out,g_out;
wire [6:0]int_l;
wire [6:0]int_e;
wire [6:0]int_g;

one_bit_comparator FA0(a[7],b[7],1'b0,1'b1,1'b0,int_l[6],int_e[6],int_g[6]);
one_bit_comparator FA1(a[6],b[6],int_l[6],int_e[6],int_g[6],int_l[5],int_e[5],int_g[5]);
one_bit_comparator FA2(a[5],b[5],int_l[5],int_e[5],int_g[5],int_l[4],int_e[4],int_g[4]);
one_bit_comparator FA3(a[4],b[4],int_l[4],int_e[4],int_g[4],int_l[3],int_e[3],int_g[3]);
one_bit_comparator FA4(a[3],b[3],int_l[3],int_e[3],int_g[3],int_l[2],int_e[2],int_g[2]);
one_bit_comparator FA5(a[2],b[2],int_l[2],int_e[2],int_g[2],int_l[1],int_e[1],int_g[1]);
one_bit_comparator FA6(a[1],b[1],int_l[1],int_e[1],int_g[1],int_l[0],int_e[0],int_g[0]);
one_bit_comparator FA7(a[0],b[0],int_l[0],int_e[0],int_g[0],l_out,e_out,g_out);

endmodule
