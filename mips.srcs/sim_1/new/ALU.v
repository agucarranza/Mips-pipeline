`timescale 1ns / 1ps

module ALU (
	input  wire [ 3:0] i_Control   ,
	input  wire [31:0] i_Data_1    ,
	input  wire [31:0] i_Data_2    ,
	output wire        o_Zero      ,
	output wire [31:0] o_ALU_Result
);

	localparam AND              = 4'b0000;
	localparam OR               = 4'b0001;
	localparam ADD              = 4'b0010;
	localparam SUB              = 4'b0110;
	localparam SET_ON_LESS_THAN = 4'b0111;
	localparam NOR              = 4'b1100;

	reg [31:0] tmp;

	assign o_Zero       = (o_ALU_Result == 32'b0);
	assign o_ALU_Result = tmp;


	always @(*) begin : proc_Operation

		case (i_Control)

			AND :
				tmp = i_Data_1 & i_Data_2;

			OR :
				tmp = i_Data_1 | i_Data_2;

			ADD :
				tmp = i_Data_1 + i_Data_2;

			SUB :
				tmp = i_Data_1 - i_Data_2;

			SET_ON_LESS_THAN :
				tmp = i_Data_1 < i_Data_2 ? 32'b1 : 32'b0;

			NOR :
				tmp = ~(i_Data_1 | i_Data_2);

			default : tmp = 32'b0;

		endcase
	end
endmodule