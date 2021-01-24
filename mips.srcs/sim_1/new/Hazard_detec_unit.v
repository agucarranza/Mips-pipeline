module Hazard_detec_unit (
	input  wire       i_IDEX_MemRead   ,
	input  wire [4:0] i_IFID_RegisterRs,
	input  wire [4:0] i_IFID_RegisterRt,
	input  wire [4:0] i_IDEX_RegisterRt,
	output wire       o_StallControl   ,
	output wire       o_IFID_Write     ,
	output wire       o_PCWrite
);

endmodule