`timescale 1ns / 1ps

module EX_MEM (
	input              clk          , // Clock
	input              rst          , // Asynchronous reset active low
	// Registers - IN
	input  wire [31:0] i_Add_result ,
	input  wire        i_Zero       ,
	input  wire [31:0] i_ALU_result ,
	input  wire [31:0] i_Read_data_2,
	// WB - Control - IN
	input  wire        i_RegWrite   ,
	input  wire        i_MemtoReg   ,
	// M - Control - IN
	input  wire        i_Branch     ,
	input  wire        i_MemRead    ,
	input  wire        i_MemWrite   ,
	// Registers - OUT
	output wire [31:0] o_Add_result ,
	output wire        o_Zero       ,
	output wire [31:0] o_ALU_result ,
	output wire [31:0] o_Read_data_2,
	// WB - Control - OUT
	output wire        o_RegWrite   ,
	output wire        o_MemtoReg   ,
	// M - Control - OUT
	output wire        o_Branch     ,
	output wire        o_MemRead    ,
	output wire        o_MemWrite
);
	// Registers
	reg [31:0] Add_result ;
	reg        Zero       ;
	reg [31:0] ALU_result ;
	reg [31:0] Read_data_2;
	// Control
	reg RegWrite;
	reg MemtoReg;
	reg Branch  ;
	reg MemRead ;
	reg MemWrite;

	always @(posedge clk) begin : proc_Registers
		if(rst) begin
			Add_result  <= 32'b0;
			Zero        <= 1'b0;
			ALU_result  <= 32'b0;
			Read_data_2 <= 32'b0;

		end else begin
			// Registers
			Add_result  <= i_Add_result ;
			Zero        <= i_Zero       ;
			ALU_result  <= i_ALU_result ;
			Read_data_2 <= i_Read_data_2;
			// Control
			RegWrite <= i_RegWrite   ;
			MemtoReg <= i_MemtoReg   ;

			Branch   <= i_Branch     ;
			MemRead  <= i_MemRead    ;
			MemWrite <= i_MemWrite   ;
			end
	end


	// Registers
	assign o_Add_result  = Add_result ;
	assign o_Zero        = Zero       ;
	assign o_ALU_result  = ALU_result ;
	assign o_Read_data_2 = Read_data_2;
	// Control
	assign o_RegWrite = RegWrite   ;
	assign o_MemtoReg = MemtoReg   ;

	assign o_Branch   = Branch     ;
	assign o_MemRead  = MemRead    ;
	assign o_MemWrite = MemWrite   ;

endmodule : EX_MEM