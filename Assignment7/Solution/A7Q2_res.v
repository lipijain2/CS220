module res(clk,result_val,flag);

	input clk;
	output [7:0]result_val;
	output flag;
	reg [31:0]ins_memory[0:6];
	reg [2:0]present_state;
	reg [7:0]register[0:31];
	reg [4:0]srcreg_index1;
	reg [4:0]srcreg_index2;
	reg [4:0]destreg_index;
	reg [7:0]src_reg1;
	reg [7:0]src_reg2;
	reg [2:0]program_counter;
	reg [2:0]MAX_ProgramCounter;
	reg [31:0]ins_read;
	reg [7:0]immediate;
	reg [5:0]opcode;
	reg [5:0]ins_function;
	reg [7:0]result;
	reg [7:0]result_val;
	reg INVALID;
	reg flag=0;

	initial begin
		INVALID<=0;
		register[0]=0;
		register[1]=0;
		register[2]=0;
		register[3]=0;
		register[4]=0;
		register[5]=0;
		register[6]=0;
		register[7]=0;
		register[8]=0;
		register[9]=0;
		register[10]=0;
		register[11]=0;
		register[12]=0;
		register[13]=0;
		register[14]=0;
		register[15]=0;
		register[16]=0;
		register[17]=0;
		register[18]=0;
		register[19]=0;
		register[20]=0;
		register[21]=0;
		register[22]=0;
		register[23]=0;
		register[24]=0;
		register[25]=0;
		register[26]=0;
		register[27]=0;
		register[28]=0;
		register[29]=0;
		register[30]=0;
		register[31]=0;
		
		ins_memory[0]=32'b00100100000000010000000000101101;     
		ins_memory[1]=32'b00100100000000101111111111101100;
		ins_memory[2]=32'b00100100000000111111111111000100;
		ins_memory[3]=32'b00100100000001000000000000011110;
		ins_memory[4]=32'b00000000001000100010100000100001;     
		ins_memory[5]=32'b00000000011001000011000000100001;
		ins_memory[6]=32'b00000000101001100010100000100011;

		MAX_ProgramCounter=3'b111;
		present_state=3'b000;
		program_counter=3'b000;
	end
	always @(posedge clk) begin
		if(present_state==3'b000)begin
			ins_read <= ins_memory[program_counter];
			program_counter <= program_counter+1;
			present_state <= 3'b001;
		end
		else if(present_state==3'b001)begin
			if(ins_read[31:26]==6'b000000)begin
				opcode[5:0]=ins_read[31:26];
				srcreg_index1<=ins_read[25:21];
				srcreg_index2<=ins_read[20:16];
				destreg_index<=ins_read[15:11];
				ins_function<=ins_read[5:0];
			end
			else begin
				opcode[5:0]=ins_read[31:26];
				srcreg_index1<=ins_read[25:21];
				destreg_index<=ins_read[20:16];
				immediate<=ins_read[7:0];
			end
			present_state <= 3'b010;
		end
		else if(present_state==3'b010)begin
			src_reg1 <= register[srcreg_index1];
			src_reg2 <= register[srcreg_index2];
			present_state <= 3'b011;
		end
		else if(present_state==3'b011)begin
			if(opcode[5:0]==6'b000000)begin
				if(ins_function==6'b100001)begin
					INVALID<=0;
					result <= src_reg1 + src_reg2;
				end
				else if(ins_function==6'b100011)begin
					INVALID<=0;
					result <= src_reg1 - src_reg2;
				end
				else begin
					INVALID<=1;
				end
			end
			else if(opcode[5:0]==6'b001001) begin
				INVALID<=0;
				result <= src_reg1 + immediate;
			end
			else begin
				INVALID<=1;
			end
			present_state <= 3'b100;
		end
		else if(present_state == 3'b100)begin
			if(INVALID==1'b0 && destreg_index!=5'b00000) begin
				register[destreg_index] <= result;
			end
			if(program_counter < MAX_ProgramCounter) begin
				present_state <= 3'b000;
			end
			else begin
				present_state <= 3'b101;
			end
		end
		else if(present_state==3'b101)begin
			present_state<=3'b101;
			result_val <= register[5];
			flag<=1;
		end
	end
endmodule
