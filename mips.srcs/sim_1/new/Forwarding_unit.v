module Forwarding_unit (
	input  wire [31:0] IDEX_RegisterRs ,
	input  wire [31:0] IDEX_RegisterRt ,
	input  wire [31:0] EXMEM_RegWrite  ,
	input  wire [31:0] EXMEM_RegisterRd,
	input  wire [31:0] MEMWB_RegisterRd,
	input  wire [31:0] MEMWB_RegWrite  ,
	output wire [ 1:0] ForwardA        ,
	output wire [ 1:0] ForwardB
);

always @(*) begin : proc_forward

end

endmodule