module syn_fifo(input wr,rd,rst,clk,input[15:0]data_in,
output reg[15:0]data_out,output empty,full);

integer fifo_count=0;
reg[5:0]rdptr;
reg[5:0]wrptr;
reg[15:0]fifo_mem[0:31];
//write operation
always @(posedge clk,posedge rst)
begin
	if(rst)
	begin
		wrptr<=0;
	end
	 else if (wr==1 && fifo_count!=31)
begin
	fifo_mem[wrptr]<=data_in;
	wrptr<=wrptr+1;
	fifo_count<=fifo_count+1;
end
else
wrptr<=wrptr;
end
//read block
always@(posedge clk,posedge rst)
begin
	if(rst)
	begin
		rdptr<=0;
		data_out<=16'dz;
	end
	else if(rd==1 && fifo_count!=0)
	begin
		data_out<=fifo_mem[rdptr];
		rdptr<=rdptr+1;
		fifo_count<=fifo_count-1;
	end
	else
		rdptr<=rdptr;
end
assign full=(fifo_count==31)?1:0;
assign empty=(fifo_count==0)?1:0;
endmodule
