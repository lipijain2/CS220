module top;

reg clk;
reg [1:0] input_to_present_state;
reg [3:0] present_state;
wire [3:0] incremented_state;
reg [3:0] next_state;
reg [2:0] ROM_microcode [0:15];
reg [3:0] dispatch_rom1 [0:3];
reg [3:0] dispatch_rom2 [0:3];
wire [3:0] a0;
wire [3:0] a1;
wire [3:0] a2;
wire [3:0] a3;
wire [3:0] a4;

state_incrementor inc(present_state,incremented_state);

assign a0 = incremented_state;
assign a1 = dispatch_rom1[input_to_present_state];
assign a2 = dispatch_rom2[input_to_present_state];
assign a3 = 4'b0111;
assign a4 = 4'b0000;

//dispatch rom 1 (dispatch_rom1)
initial begin
  dispatch_rom1[0] = 4'b0100;
  dispatch_rom1[1] = 4'b0101;
  dispatch_rom1[2] = 4'b0110;
  dispatch_rom1[3] = 4'b0110;
end

//dispatch rom 2 (dispatch_rom2)
initial begin
  dispatch_rom2[0] = 4'b1011;
  dispatch_rom2[1] = 4'b1100;
  dispatch_rom2[2] = 4'b1100;
  dispatch_rom2[3] = 4'b1100;
end

//ROM_microcode
initial begin
  ROM_microcode[0] = 3'b000;
  ROM_microcode[1] = 3'b000;
  ROM_microcode[2] = 3'b000;
  ROM_microcode[3] = 3'b001;
  ROM_microcode[4] = 3'b011;
  ROM_microcode[5] = 3'b011;
  ROM_microcode[6] = 3'b011;
  ROM_microcode[7] = 3'b000;
  ROM_microcode[8] = 3'b000;
  ROM_microcode[9] = 3'b000;
  ROM_microcode[10] = 3'b010;
  ROM_microcode[11] = 3'b100;
  ROM_microcode[12] = 3'b100;
  ROM_microcode[13] = 3'bzzz;
  ROM_microcode[14] = 3'bzzz;
  ROM_microcode[15] = 3'bzzz;
end


//mutliplexor
always @ ( present_state, a0, a1, a2, a3, a4 ) begin
  if (ROM_microcode[present_state] == 3'b000) begin
    next_state = a0;
  end
  else if (ROM_microcode[present_state] == 3'b001) begin
    next_state = a1;
  end
  else if (ROM_microcode[present_state] == 3'b010) begin
    next_state = a2;
  end
  else if (ROM_microcode[present_state] == 3'b011) begin
    next_state = a3;
  end
  else if (ROM_microcode[present_state] == 3'b100) begin
    next_state = a4;
  end
end


always @ ( posedge clk ) begin
  $display("time : <%d>, Present_State : %d, Input_to_present_state : %b\n", $time, present_state, input_to_present_state);
  present_state <= #2 next_state;
end


//clock input
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

//input
initial begin
  present_state = 4'b0000; //0
  #8
  input_to_present_state = 2'b00; //1
  #10
  input_to_present_state = 2'b10; //2
  #10
  input_to_present_state = 2'b11; //3
  #10
  input_to_present_state = 2'b01; //5
  #10
  input_to_present_state = 2'b10; //7
  #10
  input_to_present_state = 2'b00; //8
  #10
  input_to_present_state = 2'b11; //9
  #10
  input_to_present_state = 2'b01; //10
  #10
  input_to_present_state = 2'b00; //11
  #10
  input_to_present_state = 2'b10; //0
  #10
  input_to_present_state = 2'b10; //1
  #10
  $finish;
end

endmodule