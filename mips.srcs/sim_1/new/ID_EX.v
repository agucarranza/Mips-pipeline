`timescale 1ns / 1ps

module ID_EX (
	input  wire        clk          , // Clock
	input  wire        rst          ,
	// Registers - IN
	input  wire [31:0] i_PC_Address ,
	input  wire [31:0] i_Read_data_1,
	input  wire [31:0] i_Read_data_2,
	input  wire [31:0] i_Immediate  ,
	input  wire [ 4:0] i_rt         ,
	input  wire [ 4:0] i_rd         ,
	// WB - Control - IN
	input  wire        i_RegWrite   ,
	input  wire        i_MemtoReg   ,
	// M - Control - IN
	input  wire        i_Branch     ,
	input  wire        i_MemRead    ,
	input  wire        i_MemWrite   ,
	// EX - Control - IN
	input  wire        i_RegDst     ,
	input  wire [ 1:0] i_ALUOp      ,
	input  wire        i_ALUSrc     ,
	// Registers - OUT
	output wire [31:0] o_PC_Address ,
	output wire [31:0] o_Read_data_1,
	output wire [31:0] o_Read_data_2,
	output wire [31:0] o_Immediate  ,
	output wire [ 4:0] o_rt         ,
	output wire [ 4:0] o_rd         ,
	// WB - Control - OUT
	output wire        o_RegWrite   ,
	output wire        o_MemtoReg   ,
	// M - Control - OUT
	output wire        o_Branch     ,
	output wire        o_MemRead    ,
	output wire        o_MemWrite   ,
	// EX - Control - OUT
	output wire        o_RegDst     ,
	output wire [ 1:0] o_ALUOp      ,
	output wire        o_ALUSrc
);

	reg [31:0] PC_Address ;
	reg [31:0] Read_data_1;
	reg [31:0] Read_data_2;
	reg [31:0] Immediate  ;
	reg [ 4:0] rt         ;
	reg [ 4:0] rd         ;
	reg        RegWrite   ;
	reg        MemtoReg   ;
	reg        Branch     ;
	reg        MemRead    ;
	reg        MemWrite   ;
	reg        RegDst     ;
	reg [ 1:0] ALUOp      ;
	reg        ALUSrc     ;

	always @(posedge clk) begin : proc_Registers
		if(rst) begin
			PC_Address  <= 32'b0;
			Read_data_1 <= 32'b0;
			Read_data_2 <= 32'b0;
			Immediate   <= 32'b0;
			rt          <= 5'b0;
			rd          <= 5'b0;

		end else begin
			// Registers
			PC_Address  <= i_PC_Address ;
			Read_data_1 <= i_Read_data_1;
			Read_data_2 <= i_Read_data_2;
			Immediate   <= i_Immediate  ;
			rt          <= i_rt;
			rd          <= i_rd;

			// Control
			RegWrite <= i_RegWrite   ;
			MemtoReg <= i_MemtoReg   ;

			Branch   <= i_Branch     ;
			MemRead  <= i_MemRead    ;
			MemWrite <= i_MemWrite   ;

			RegDst <= i_RegDst     ;
			ALUOp  <= i_ALUOp      ;
			ALUSrc <= i_ALUSrc     ;
		end
	end
	// Registers
	assign o_PC_Address  = PC_Address;
	assign o_Read_data_1 = Read_data_1;
	assign o_Read_data_2 = Read_data_2;
	assign o_Immediate   = Immediate;
	assign o_rt          = rt;
	assign o_rd          = rd;
	// Control
	assign o_RegWrite = RegWrite   ;
	assign o_MemtoReg = MemtoReg   ;

	assign o_Branch   = Branch     ;
	assign o_MemRead  = MemRead    ;
	assign o_MemWrite = MemWrite   ;

	assign o_RegDst = RegDst     ;
	assign o_ALUOp  = ALUOp      ;
	assign o_ALUSrc = ALUSrc     ;

endmodule : ID_EX



