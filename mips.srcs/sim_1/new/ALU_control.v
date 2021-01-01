`timescale 1ns / 1ps

module ALU_control (
	input  wire [1:0] i_ALUOp        ,
	input  wire [5:0] i_Function_code,
	output wire [3:0] o_Operation
);

	reg [3:0] Operation;

	always @(*) begin : proc_truth_table

		casez ({i_ALUOp,i_Function_code})

			// load word
			// store word
			8'b00_?????? : Operation = 4'b0010;

			// branch equal
			8'b01_?????? : Operation = 4'b0110;

			// R-type add
			8'b10_100000 : Operation = 4'b0010;

			// R-type substract
			8'b10_100010 : Operation = 4'b0110;

			// R-type AND
			8'b10_100100 : Operation = 4'b0000;

			// R-type OR
			8'b10_100101 : Operation = 4'b0001;

			// R-type set on less than
			8'b10_101010 : Operation = 4'b0111;

			default : /* default */;
		endcase
	end

	assign o_Operation = Operation;

endmodule