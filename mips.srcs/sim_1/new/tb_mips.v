`timescale 1ns / 1ps
//`include "MIPS.v"


module tb_mips;

reg clk;
reg rst;

initial begin
	rst = 1'b1;
	clk = 1'b1;

/* verilator lint_off STMTDLY */	
	#60
/* verilator lint_on STMTDLY */
		rst = 1'b0;
end

always #10 clk = ~clk;

MIPS i_MIPS (
	.clk(clk),
	.rst(rst)
);

endmodule