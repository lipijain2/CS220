module top;
reg [4:0]read1[0:25];
reg [4:0]read2[0:25];
reg [4:0]write1[0:25];
reg [15:0]write_data[0:25];
reg [2:0]instr[0:25];
reg [3:0]shift[0:25];
reg [5:0]i=0;
reg clk;

wire signed [15:0]data1;
wire signed [15:0]data2;
wire done;

regfile R1(read1[i],read2[i],write1[i],write_data[i],instr[i],shift[i],clk,data1,data2,done);

always @(posedge clk) begin
	if (done == 1) begin
		if(instr[i] == 3'b001)begin;
			$display("Time:%d, Address : %d, Value = %d", $time, read1[i], data1);
		end
		else if(instr[i] == 3'b010)begin
			$display("Time:%d, Address1 : %d, Value1 = %d, Address2 : %d, Value2 = %d", $time, read1[i], data1, read2[i], data2);
	    end
		else if(instr[i] == 3'b011) begin
			$display("Time:%d, Address : %d, Value = %d", $time, read1[i], data1);
		end
		else if(instr[i] == 3'b100)begin
			$display("Time:%d, Address1 : %d, Value1 = %d, Address2 : %d, Value2 = %d", $time, read1[i], data1, read2[i], data2);
	    end
		else if(instr[i] == 3'b101)begin
			$display("Time:%d, Address Written : %d, Value : %d", $time, write1[i], data1);
		end
		else if(instr[i] == 3'b110)begin
			$display("Time:%d, Address Written : %d, Value : %d", $time, write1[i], data1);
		end
		else if(instr[i] == 3'b111)begin
			$display("Time:%d, Address Written : %d, Value : %d", $time, write1[i], data1);
		end
		i <= i + 1;
	end
	if(i == 9)$finish;
end


initial begin
    #7;
        instr[0] = 3'b000; write1[0] = 1; write_data[0] = 17;
        instr[1] = 3'b011; read1[1] = 1; write1[1] = 2; write_data[1] = -9;
        instr[2] = 3'b100; read1[2] = 1; read2[2] = 2; write1[2] = 3; write_data[2] = 65;
        instr[3] = 3'b010; read1[3] = 2; read2[3] = 3;
        instr[4] = 3'b111; read1[4] = 3; write1[4] = 5; shift[4] = 3;
        instr[5] = 3'b101; read1[5] = 1; read2[5] = 2; write1[5] = 4;
        instr[6] = 3'b111; read1[6] = 4; write1[6] = 4; shift[6] = 9;
        instr[7] = 3'b110; read1[7] = 5; read2[7] = 4; write1[7] = 6;
        instr[8] = 3'b001; read1[8] = 6;
end

initial begin
	#5
	forever begin
		clk=0;
		#5
		clk=1;
		#5
		clk=0;
	end
end
endmodule

