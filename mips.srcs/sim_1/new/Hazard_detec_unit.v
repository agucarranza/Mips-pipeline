module Hazard_detec_unit (
	input  wire       i_IDEX_MemRead   ,
	input  wire [4:0] i_IFID_RegisterRs,
	input  wire [4:0] i_IFID_RegisterRt,
	input  wire [4:0] i_IDEX_RegisterRt,
	output wire       o_StallControl   ,
	output wire       o_IFID_Write     ,
	output wire       o_PCWrite
);

	reg StallControl;
	reg IFID_Write  ;
	reg PCWrite     ;

	always @(*) begin : proc_ID_Hazard_Detection

		if (i_IDEX_MemRead && (
				(i_IDEX_RegisterRt == i_IFID_RegisterRs) ||
				(i_IDEX_RegisterRt == i_IFID_RegisterRt)))
		begin : stall
			StallControl = 1'b0;
			IFID_Write   = 1'b0;
			PCWrite      = 1'b0;

		end else begin : no_stall
			StallControl = 1'b1;
			IFID_Write   = 1'b1;
			PCWrite      = 1'b1;

		end

	end : proc_ID_Hazard_Detection

	assign o_StallControl = StallControl;
	assign o_IFID_Write   = IFID_Write;
	assign o_PCWrite      = PCWrite;
endmodule