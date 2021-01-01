`timescale 1ns / 1ps

module Mux (
	input  wire        i_Control ,
	input  wire [31:0] i_Input_0,
	input  wire [31:0] i_Input_1,
	output wire [31:0] o_Salida
);

	assign o_Salida = i_Control ? i_Input_1 : i_Input_0;

	endmodule