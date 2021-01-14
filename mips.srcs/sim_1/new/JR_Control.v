module JR_Control (
	input  wire [2:0] i_AluOp        ,
	input  wire [5:0] i_Function_code,
	output wire       o_JR_Control
);

localparam Opcode = 6'b001000;
localparam AluOp = 3'b???;

	reg JR_Control = 1'b0;

	always @(*) begin : proc_
	casez ({i_AluOp,i_Function_code})

		{AluOp,Opcode}: JR_Control = 1'b1;

		default : JR_Control = 1'b0;
	endcase
	
	end

endmodule