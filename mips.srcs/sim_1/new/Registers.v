`timescale 1ns / 1ps

module Registers (
	input  wire        i_clk            , // Clock
	input  wire        i_rst            ,
	input  wire        i_RegWrite       ,
	input  wire [ 4:0] i_Read_register_1,
	input  wire [ 4:0] i_Read_register_2,
	input  wire [ 4:0] i_Write_register ,
	input  wire [31:0] i_Write_data     ,
	output wire [31:0] o_Read_data_1    ,
	output wire [31:0] o_Read_data_2
);

	reg [31:0] registers  [0:31]; //Array se pone la cantidad, no los bits!!
	reg [31:0] Read_data_1      ;
	reg [31:0] Read_data_2      ;

	initial begin 
		registers[1] = 32'h2;
		registers[2] = 32'h4;
		registers[3] = 32'h6;
		registers[4] = 32'h8;
		registers[5] = 32'h1;
		registers[6] = 32'h2;
		registers[6] = 32'h0;
		registers[7] = 32'h1;

	end


	always @(posedge i_clk) begin : proc_Read
		if(i_rst) begin
			Read_data_1 <= 0;
			Read_data_2 <= 0;
		end else begin
			Read_data_1 <= registers[i_Read_register_1];
			Read_data_2 <= registers[i_Read_register_2];
		end
	end

	assign o_Read_data_1 = Read_data_1;
	assign o_Read_data_2 = Read_data_2;

	always @(posedge i_clk) begin : proc_Write
		if(i_RegWrite) begin
			registers[i_Write_register] <= i_Write_data;
		end
	end

	always @(posedge i_clk) begin 
		$display("Registros:");
		$display("%h",registers[1]);
		$display("%h",registers[2]);
		$display("%h",registers[3]);
		$display("%h",registers[4]);
		$display("%h",registers[5]);
		$display("%h",registers[6]);
	end


endmodule