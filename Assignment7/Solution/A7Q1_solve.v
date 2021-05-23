module solve(clk,R[3:0],J[3:0],I[3:0],cnt3[3:0],cnt4[3:0],cnt5[3:0],cnt6[3:0]);

input clk;

output [3:0] R;
output [3:0] I;
output [3:0] J;
output [3:0] cnt3;
output [3:0] cnt4;
output [3:0] cnt5;
output [3:0] cnt6;
reg [31:0] ins [0:7];
reg [3:0] R=0;
reg [3:0] I=0;
reg [3:0] J=0;
reg [3:0] cnt3=0;
reg [3:0] cnt4=0;
reg [3:0] cnt5=0;
reg [3:0] cnt6=0;
reg [2:0] program_counter=0;


always @(posedge clk) begin
		if(ins[program_counter][31:26]==6'b000000)begin
			R<=R+1;
			if(ins[program_counter][15:11]==5'b00011)begin
				cnt3<=cnt3+1;
			end
			else if(ins[program_counter][15:11]==5'b00100)begin
				cnt4<=cnt4+1;
			end
			else if(ins[program_counter][15:11]==5'b00101)begin
				cnt5<=cnt5+1;
			end
			else if(ins[program_counter][15:11]==5'b00110)begin
				cnt6<=cnt6+1;
			end
		end
		else if(ins[program_counter][31:26]==6'b000010 || ins[program_counter][31:26]==6'b000011)begin
			J<=J+1;
		end
		else begin
			I<=I+1;
			if(ins[program_counter][20:16]==5'b00011)begin
				cnt3<=cnt3+1;
			end
			else if(ins[program_counter][20:16]==5'b00100)begin
				cnt4<=cnt4+1;
			end
			else if(ins[program_counter][20:16]==5'b00101)begin
				cnt5<=cnt5+1;
			end
			else if(ins[program_counter][20:16]==5'b00110)begin
				cnt6<=cnt6+1;
			end
		end
		program_counter<=program_counter+1;
	end
	initial begin
		ins[0]=32'b00100000000001000011010001010110;
		ins[1]=32'b00100000000001011111111111111111;
		ins[2]=32'b00000000101001000011000000100000;
		ins[3]=32'b00100000000000110000000000000111;
		ins[4]=32'b00000000110000110011000000000100;
		ins[5]=32'b00000000000000110001100001000010;
		ins[6]=32'b10001100100001011001101010111100;
		ins[7]=32'b00001000000100100011010001010110;
		
	end
endmodule

