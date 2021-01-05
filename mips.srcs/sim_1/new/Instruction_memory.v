`timescale 1ns / 1ps

module Instruction_memory (
	input  wire        clk           ,
	input  wire [31:0] i_Read_address,
	output wire [31:0] o_Instruction
);

	reg [31:0] memory  [0:1023];
	reg [31:0] temporal      ;

//Leer

	always @(posedge clk) 
	begin
		temporal <= memory[i_Read_address];
	end

//Escribir


	assign o_Instruction = temporal;

endmodule