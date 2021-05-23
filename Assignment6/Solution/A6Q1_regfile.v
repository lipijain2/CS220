module regfile(read1,read2,write1,write_data,instr,shift,clk,data1,data2,done);

input [4:0]read1;
input [4:0]read2;
input [4:0]write1;
input [15:0]write_data;
input [2:0]instr;
input [3:0]shift;
input clk;

output reg signed[15:0]data1;
output reg signed[15:0]data2;
output reg done;

reg [15:0]register[0:31];
reg [4:0]count;

//Used one extra cycle for reporting done 
always @(posedge clk) begin

    if (instr == 3'b000) begin
        count <= count+1;
        done <= 0;
        if(count == 2)begin
            register[write1] <= write_data;
            count <= 0;
            done <= 1;
        end
    end

    if (instr == 3'b001) begin
        count <= count+1;
        done <= 0;
        if(count == 2)begin
            data1 <= register[read1];
            count <= 0;
            done <= 1;
        end
    end

    if (instr == 3'b010) begin
        count <= count+1;
        done <= 0;
        if(count == 2)begin
            data1 <= register[read1];
            data2 <= register[read2];
            count <= 0;
            done <= 1;
        end
    end

    if (instr == 3'b011) begin
        count <= count+1;
        done <= 0;
        if(count == 2)begin
            data1 <= register[read1];
            register[write1] <= write_data;
            count <= 0;
            done <= 1;
        end
    end

    if (instr == 3'b100) begin
        count <= count+1;
        done <= 0;
        if(count == 2)begin
            data1 <= register[read1];
            data2 <= register[read2];
            register[write1] <= write_data;
            count <= 0;
            done <= 1;
        end
    end

    if (instr == 3'b101) begin
        count <= count+1;
        done <= 0;
        if(count == 2)begin
            data1 <= register[read1];
            data2 <= register[read2];
        end
        else if(count == 18)begin
            data1 <= data1+data2;
        end 
        else if(count == 20)begin
            register[write1] <= data1;
            count <= 0;
            done <= 1;
        end
    end

    if (instr == 3'b110) begin
        count <= count+1;
        done <= 0;
        if(count == 2)begin
            data1 <= register[read1];
            data2 <= register[read2];
        end
        else if(count == 18)begin
            data1 <= data1-data2;
        end 
        else if(count == 20)begin
            register[write1] <= data1;
            count <= 0;
            done <= 1;
        end
    end

    if (instr == 3'b111) begin
        count <= count+1;
        done <= 0;
        if(count == 2)begin
            data2 <= register[read1];
        end
        else if(count == 18)begin
            data1 <= (data2 << shift);
        end
        else if(count == 20)begin
            register[write1] <= data1;
            count <= 0;
            done <= 1;
        end
    end
end

initial begin
        count = 0;
        done = 0;
        register[0] = 0;
        register[1] = 0;
        register[2] = 0;
        register[3] = 0;
        register[4] = 0;
        register[5] = 0;
        register[6] = 0;
        register[7] = 0;
        register[8] = 0;
        register[9] = 0;
        register[10] = 0;
        register[11] = 0;
        register[12] = 0;
        register[13] = 0;
        register[14] = 0;
        register[15] = 0;
        register[16] = 0;
        register[17] = 0;
        register[18] = 0;
        register[19] = 0;
        register[20] = 0;
        register[21] = 0;
        register[22] = 0;
        register[23] = 0;
        register[24] = 0;
        register[25] = 0;
        register[26] = 0;
        register[27] = 0;
        register[28] = 0;
        register[29] = 0;
        register[30] = 0;
        register[31] = 0; 
    end
endmodule

