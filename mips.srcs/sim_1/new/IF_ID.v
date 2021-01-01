`timescale 1ns / 1ps

module IF_ID (
	input  wire        clk          , // Clock
	input  wire        rst          ,
	input  wire [31:0] i_PC_Address ,
	input  wire [31:0] i_Instruction,
	output wire [31:0] o_PC_Address ,
	output wire [31:0] o_Instruction
);

	reg [31:0] PC_Address ;
	reg [31:0] Instruction;

	always @(posedge clk) begin : proc_Registers
		if(rst) begin
			PC_Address  <= 32'b0;
			Instruction <= 32'b0;
		end else begin
			PC_Address  <= i_PC_Address;
			Instruction <= i_Instruction;
		end
	end

	assign o_Instruction = Instruction;
	assign o_PC_Address  = PC_Address;



endmodule