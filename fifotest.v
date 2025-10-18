module tb;
reg wr;
reg rd,rst,clk;
reg[15:0]data_in;

wire[15:0]data_out;
wire empty,full;
syn_fifo instant_dut(.wr(wr),.rd(rd),.rst(rst),.clk(clk),.data_in(data_in),.data_out(data_out),.empty(empty),.full(full));
always #5 clk=~clk;
initial begin
	$monitor("data_in=%0b,data_out=%0b",data_in,data_out);

#10;	wr=0;rd=0;rst=1;clk=0;data_in=0;
end
initial begin//write
	@(posedge clk)rst=0;wr=1;
	@(posedge clk)data_in=16'h1234;
	@(posedge clk)data_in=16'h3455;
	@(posedge clk)data_in=16'h1f34;
	@(posedge clk)data_in=16'hf234;
	@(posedge clk)data_in=16'h12ff;					@(posedge clk)data_in=16'haa34;
		@(posedge clk)wr=0;//read block
		@(posedge clk)rd=1;
		#200;
		$stop;
	end
	endmodule






