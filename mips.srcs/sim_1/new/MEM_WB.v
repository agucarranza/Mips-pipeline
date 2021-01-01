`timescale 1ns / 1ps

module MEM_WB (
	input              clk        , // Clock
	input              rst        , // Asynchronous reset active low
	// Registers - IN
	input  wire [31:0] i_Address  ,
	input  wire [31:0] i_Read_data,
	// WB - Control - IN
	input  wire        i_RegWrite ,
	input  wire        i_MemtoReg ,
	// Registers - OUT
	output wire [31:0] o_Address  ,
	output wire [31:0] o_Read_data,
	// WB - Control - OUT
	output wire        o_RegWrite ,
	output wire        o_MemtoReg
);
	// Registers
	reg [31:0] Address  ;
	reg [31:0] Read_data;
	// Control
	reg RegWrite;
	reg MemtoReg;

	always @(posedge clk) begin : proc_registers
		if(rst) begin
			Address   <= 32'b0;
			Read_data <= 32'b0;
		end else begin
			Address   <= i_Address;
			Read_data <= i_Read_data;

			RegWrite <= i_RegWrite   ;
			MemtoReg <= i_MemtoReg   ;
		end
	end
	// Registers
	assign o_Address   = Address  ;
	assign o_Read_data = Read_data;
	// Control
	assign o_RegWrite = RegWrite   ;
	assign o_MemtoReg = MemtoReg   ;

endmodule : MEM_WB

