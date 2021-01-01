`timescale 1ns / 1ps

module Control (
	// INPUT
	input  wire [5:0] i_Op      ,
	// EX
	output wire       o_RegDst  ,
	output wire [1:0] o_ALUOp   ,
	output wire       o_ALUSrc  ,
	// MEM
	output wire       o_Branch  ,
	output wire       o_MemRead ,
	output wire       o_MemWrite,
	// WB
	output wire       o_RegWrite,
	output wire       o_MemtoReg
);

	localparam R_format = 6'b000000;
	localparam lw       = 6'b100011;
	localparam sw       = 6'b101011;
	localparam beq      = 6'b000100;


	reg       RegDst  ;
	reg [1:0] ALUOp   ;
	reg       ALUSrc  ;
	reg       Branch  ;
	reg       MemRead ;
	reg       MemWrite;
	reg       RegWrite;
	reg       MemtoReg;


	always @(*) begin : proc_Op

		casez (i_Op)

			R_format :
				begin
					RegDst   = 1'b1;
					ALUOp    = 2'b10;
					ALUSrc   = 1'b0;
					Branch   = 1'b0;
					MemRead  = 1'b0;
					MemWrite = 1'b0;
					RegWrite = 1'b1;
					MemtoReg = 1'b0;
				end

			lw :
				begin
					RegDst   = 1'b0;
					ALUOp    = 2'b00;
					ALUSrc   = 1'b1;
					Branch   = 1'b0;
					MemRead  = 1'b1;
					MemWrite = 1'b0;
					RegWrite = 1'b1;
					MemtoReg = 1'b1;
				end
			sw :
				begin
					RegDst   = 1'b?;
					ALUOp    = 2'b00;
					ALUSrc   = 1'b1;
					Branch   = 1'b0;
					MemRead  = 1'b0;
					MemWrite = 1'b1;
					RegWrite = 1'b0;
					MemtoReg = 1'b?;
				end
			beq :
				begin
					RegDst   = 1'b?;
					ALUOp    = 2'b01;
					ALUSrc   = 1'b0;
					Branch   = 1'b1;
					MemRead  = 1'b0;
					MemWrite = 1'b0;
					RegWrite = 1'b0;
					MemtoReg = 1'b?;
				end

			default :

				begin
					RegDst   = 1'b0;
					ALUOp    = 2'b00;
					ALUSrc   = 1'b0;
					Branch   = 1'b0;
					MemRead  = 1'b0;
					MemWrite = 1'b0;
					RegWrite = 1'b0;
					MemtoReg = 1'b0;
				end
		endcase

	end

	assign o_RegDst   = RegDst  ;
	assign o_ALUOp    = ALUOp   ;
	assign o_ALUSrc   = ALUSrc  ;
	assign o_Branch   = Branch  ;
	assign o_MemRead  = MemRead ;
	assign o_MemWrite = MemWrite;
	assign o_RegWrite = RegWrite;
	assign o_MemtoReg = MemtoReg;


endmodule