module top;
reg[1:0]direction;
reg[1:0]steps;
reg clk;

wire [4:0] x;
wire [4:0] y;

grid MM(direction,steps,clk,x,y);


initial
begin
 forever begin
  clk=0;
  #5
  clk=1;
  #5
  clk=0;
 end
end

initial 
begin
 #3
 direction=0; steps=1;
 #5
 $display("Time=%d direction=%d steps=%d (x,y)=(%d,%d)",$time,direction,steps,x,y);
 #5
 direction=2; steps=3;
 #5
 $display("Time=%d direction=%d steps=%d (x,y)=(%d,%d)",$time,direction,steps,x,y);
 #5
 direction=1; steps=3;
 #5
 $display("Time=%d direction=%d steps=%d (x,y)=(%d,%d)",$time,direction,steps,x,y);
 #5
 direction=3;steps=2;
 #5
 $display("Time=%d direction=%d steps=%d (x,y)=(%d,%d)",$time,direction,steps,x,y);
 #5
 direction=0;steps=3;
 #5
 $display("Time=%d direction=%d steps=%d (x,y)=(%d,%d)",$time,direction,steps,x,y);
 #5
 direction=0; steps=1;
 #5
 $display("Time=%d direction=%d steps=%d (x,y)=(%d,%d)",$time,direction,steps,x,y);
 #5
 direction=2; steps=3;
 #5
 $display("Time=%d direction=%d steps=%d (x,y)=(%d,%d)",$time,direction,steps,x,y);
 #5
 direction=0; steps=3;
 #5
 $display("Time=%d direction=%d steps=%d (x,y)=(%d,%d)",$time,direction,steps,x,y);
 #5
 direction=1;steps=2;
 #5
 $display("Time=%d direction=%d steps=%d (x,y)=(%d,%d)",$time,direction,steps,x,y);
 #5
 direction=2;steps=3;
 #5
 $display("Time=%d direction=%d steps=%d (x,y)=(%d,%d)",$time,direction,steps,x,y);
 #5
 $finish;
end

endmodule
