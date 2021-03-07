`timescale 1ns / 1ps

module debugUnit (
	input  wire i_clk              ,
	input  wire i_Halt             ,
	input  wire i_mode             ,
	input  wire i_cycleChange      ,
	input  wire i_RegistersAddress ,
	input  wire i_RegistersData    ,
	input  wire i_DataMemoryData   ,
	input  wire i_DataMemoryAddress,
	input  wire i_ProgCounter      ,
	input  wire i_UartInput        ,
	input  wire i_RxDone           ,
	output wire o_ProgramData      ,
	output wire o_ProgramAddress   ,
	output wire o_UartOutput       ,
	output wire o_TxDone           ,
	output wire o_TxStart
);

endmodule