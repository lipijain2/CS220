module fsm(in, clk, out);

input in;
input clk;
output out;
reg out;
reg [1:0] state;

always @(posedge clk)
begin
                if(state==2'b00)begin
                        if(in==0)begin
                                state<=#2 2'b01;
			        out<=#2 1;
                        end
                        else if(in==1)begin
                                state<=#2 2'b10;
				out<=#2 1;
                        end
                end
                else if(state==2'b01)begin
                        if(in==0)begin
                                state<=#2 2'b11;
                                out<=#2 0;
                        end
                        else if(in==1)begin
                                state<=#2 2'b10;
				out<=#2 1;
                        end
                end
                else if(state==2'b10)begin
                        if(in==0)begin
                                state<=#2 2'b01;
				out<=#2 1;
                        end
                        else if(in==1)begin
                                state<=#2 2'b11;
                                out<=#2 0;
                        end
		end
		else begin
			out<=#2 0;
		end
end


initial
begin
	state=2'b00;
	out=1;
end
endmodule
