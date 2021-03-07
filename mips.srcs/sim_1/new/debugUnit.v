`timescale 1ns / 1ps

module debugUnit (
	input  wire clk              ,
	input  wire Halt             ,
	input  wire mode             ,
	input  wire cycleChange      ,
	input  wire RegistersAddress ,
	input  wire RegistersData    ,
	input  wire DataMemoryData   ,
	input  wire DataMemoryAddress,
	input  wire ProgCounter      ,
	input  wire UartInput        ,
	input  wire RxDone           ,
	output wire ProgramData      ,
	output wire ProgramAddress   ,
	output wire UartOutput       ,
	output wire TxDone           ,
	output wire TxStart
);

endmodule