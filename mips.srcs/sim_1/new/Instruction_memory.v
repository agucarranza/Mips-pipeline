`timescale 1ns / 1ps

module Instruction_memory (
	input  wire        i_clk         ,
	input  wire        i_rst         ,
	input  wire [31:0] i_Read_address,
	output wire [31:0] o_Instruction
);

	reg [31:0] memory[0:1023];
	reg [31:0] tmp           ;

//Leer

	always @(posedge i_clk) begin : proc_read
		if (i_rst) begin
			tmp <= 32'b0;
		end else begin
			tmp <= memory[i_Read_address];
		end
	end



//Escribir

	always @(posedge i_clk) begin : proc_write
		if(i_rst) begin
		//	<= 0;
		end else begin
		//	<= ;
		end
	end


	assign o_Instruction = tmp;

endmodule