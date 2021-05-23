module read(clk, rn, input_valid, result, orow, output_valid);

input [3:0] rn;

input clk;
input input_valid;
output output_valid;
output [3:0] orow;
output [31:0] result;
reg output_valid,two_cycles_delay_var,one_cycle_delay_var,initially;
reg [31:0] r [15:0];
reg [31:0] result;
reg [3:0] orow;

always @ ( posedge clk ) begin

  
  if(two_cycles_delay_var==1) begin
    result<=r[orow];
    two_cycles_delay_var<=0;
    output_valid<=1;
    orow<=rn;
    output_valid<=#3 0;
  end

  else if(one_cycle_delay_var==1) begin
    if(initially==1) begin
    $display("time:%d, No row is open",$time);
    initially=0;
    end

    two_cycles_delay_var<=1;
    one_cycle_delay_var<=0;
    output_valid<=0;
    orow<=rn;
  end
  
  else if (input_valid == 1) begin
    if (rn==orow) begin
        $display("time:%d, Case#3 (Open row no. is the same as input row no.",$time);
        output_valid <= 1;
        output_valid<=#3 0;
        result<=r[orow];
        orow=rn;
        
    end
    else begin
        $display("time:%d, Case#1 (Input row no. and open row no. are different)",$time);
        output_valid <= 0;
        one_cycle_delay_var<=1;
        orow<= rn;
    end
  end

  
end

initial begin
  one_cycle_delay_var=1;
  two_cycles_delay_var=0;
  output_valid=0;
  initially=1;
  r[0] = 0;
  r[1] = 1;
  r[2] = 2;
  r[3] = 3;
  r[4] = 4;
  r[5] = 5;
  r[6] = 6;
  r[7] = 7;
  r[8] = 8;
  r[9] = 9;
  r[10] = 10;
  r[11] = 11;
  r[12] = 12;
  r[13] = 13;
  r[14] = 14;
  r[15] = 15;
end




endmodule