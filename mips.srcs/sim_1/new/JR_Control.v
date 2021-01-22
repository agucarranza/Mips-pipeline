module JR_Control (
	input  wire [2:0] i_AluOp        ,
	input  wire [5:0] i_Function_code,
	output wire       o_JR_Control   ,
	output wire       o_JALR_Control
);

	localparam JR    = 6'b001001;
	localparam JALR  = 6'b001000;
	localparam AluOp = 3'b011   ;

	reg JR_Control   = 1'b0;
	reg JALR_Control = 1'b0;

	always @(*) begin : proc_
		casez ({i_AluOp,i_Function_code})

			{AluOp,JR}: begin
				JR_Control   = 1'b1;
				JALR_Control = 1'b0;
			end

			{AluOp,JALR}: begin
				JR_Control   = 1'b1;
				JALR_Control = 1'b1;
			end

			default :
				begin
					JR_Control   = 1'b0;
					JALR_Control = 1'b0;
				end
		endcase

	end

endmodule