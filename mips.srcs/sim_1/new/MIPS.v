`timescale 1ns / 1ps
`include "Mux.v" `include "PC.v" `include "Add.v" `include "Instruction_memory.v" `include "IF_ID.v"
`include "Registers.v" `include "Control.v" `include "ID_EX.v"

module MIPS
	(
		input clk, // Clock
		input rst  // Asynchronous reset active low
	);
// Control
wire       PCSrc      ;
wire       RegWrite   ;
wire       RegDst   ;
wire       ID_RegDst  ;
wire [1:0] ID_ALUOp   ;
wire       ID_ALUSrc  ;
wire       ID_Branch  ;
wire       ID_MemRead ;
wire       ID_MemWrite;
wire       ID_RegWrite;
wire       ID_MemtoReg;
wire       EX_Branch  ;
wire       EX_MemRead ;
wire       EX_MemWrite;
wire       EX_RegWrite;
wire       EX_MemtoReg;
// Data
wire [31:0] PC_to_AddPC_to_InstMem       ;
wire [31:0] MuxPCSrc_to_PC               ;
wire [31:0] InstMem_to_IFID              ; // Salida Memoria de Instrucciones
wire [31:0] AddPC_to_MuxPCSrc_to_IFID    ; // Salida AddPC
wire [31:0] EX_MEM_Add_result_to_MuxPCSrc;
// ID
wire [31:0] Instruction                       ;
wire [ 4:0] MEM_WB_to_Registers_WriteRegister ;
wire [31:0] MuxMemtoReg_to_Registers_WriteData;
wire [31:0] IFID_to_IDEX_PC_Address           ;
wire [31:0] Registers_to_IDEX_ReadData1       ;
wire [31:0] Registers_to_IDEX_ReadData2       ;
// EX
wire [31:0] IDEX_to_EXMEM_PCAddress;



Mux i_MuxPCSrc (
	.i_Control(PCSrc                        ),
	.i_Input_0(AddPC_to_MuxPCSrc_to_IFID    ),
	.i_Input_1(EX_MEM_Add_result_to_MuxPCSrc),
	.o_Salida (MuxPCSrc_to_PC               )
);

PC i_PC (
	.i_clk    (clk                   ),
	.i_address(MuxPCSrc_to_PC        ),
	.o_address(PC_to_AddPC_to_InstMem)
);

Add i_AddPC (
	.i_Operand_0 (PC_to_AddPC_to_InstMem   ),
	.i_Operand_1 (32'd4                    ),
	.o_Add_result(AddPC_to_MuxPCSrc_to_IFID)
);

Instruction_memory i_Instruction_memory (
	.i_clk         (clk                   ),
	.i_rst         (rst                   ),
	.i_Read_address(PC_to_AddPC_to_InstMem),
	.o_Instruction (InstMem_to_IFID       )
);

IF_ID i_IF_ID (
	.clk          (clk                      ),
	.rst          (rst                      ),
	.i_PC_Address (AddPC_to_MuxPCSrc_to_IFID),
	.i_Instruction(InstMem_to_IFID          ),
	.o_PC_Address (IFID_to_IDEX_PC_Address  ),
	.o_Instruction(Instruction              )
);

Registers i_Registers (
	.i_clk            (clk                               ),
	.i_rst            (rst                               ),
	.i_RegWrite       (RegWrite                          ),
	.i_Read_register_1(Instruction[25:21]                ),
	.i_Read_register_2(Instruction[20:16]                ),
	.i_Write_register (MEM_WB_to_Registers_WriteRegister ),
	.i_Write_data     (MuxMemtoReg_to_Registers_WriteData),
	.o_Read_data_1    (Registers_to_IDEX_ReadData1       ),
	.o_Read_data_2    (Registers_to_IDEX_ReadData2       )
);

Control i_Control (
	.i_Op      (Instruction[31:26]),
	.o_RegDst  (ID_RegDst         ),
	.o_ALUOp   (ID_ALUOp          ),
	.o_ALUSrc  (ID_ALUSrc         ),
	.o_Branch  (ID_Branch         ),
	.o_MemRead (ID_MemRead        ),
	.o_MemWrite(ID_MemWrite       ),
	.o_RegWrite(ID_RegWrite       ),
	.o_MemtoReg(ID_MemtoReg       )
);

ID_EX i_ID_EX (
	.clk          (clk                                         ),
	.rst          (rst                                         ),
	.i_PC_Address (IFID_to_IDEX_PC_Address                     ),
	.i_Read_data_1(Registers_to_IDEX_ReadData1                 ),
	.i_Read_data_2(Registers_to_IDEX_ReadData2                 ),
	.i_Immediate  ({ {16{Instruction[15]}}, Instruction[15:0] }), // Sign extension
	.i_rt         (Instruction[20:16]                          ),
	.i_rd         (Instruction[15:11]                          ),
	.i_RegWrite   (ID_RegWrite                                 ),
	.i_MemtoReg   (ID_MemtoReg                                 ),
	.i_Branch     (ID_Branch                                   ),
	.i_MemRead    (ID_MemRead                                  ),
	.i_MemWrite   (ID_MemWrite                                 ),
	.i_RegDst     (ID_RegDst                                   ),
	.i_ALUOp      (ID_ALUOp                                    ),
	.i_ALUSrc     (ID_ALUSrc                                   ),
	.o_PC_Address (o_PC_Address                                ),
	.o_Read_data_1(o_Read_data_1                               ),
	.o_Read_data_2(o_Read_data_2                               ),
	.o_Immediate  (o_Immediate                                 ),
	.o_rt         (o_rt                                        ),
	.o_rd         (o_rd                                        ),
	.o_RegWrite   (o_RegWrite                                  ),
	.o_MemtoReg   (o_MemtoReg                                  ),
	.o_Branch     (o_Branch                                    ),
	.o_MemRead    (o_MemRead                                   ),
	.o_MemWrite   (o_MemWrite                                  ),
	.o_RegDst     (o_RegDst                                    ),
	.o_ALUOp      (o_ALUOp                                     ),
	.o_ALUSrc     (o_ALUSrc                                    )
);

// EX

Add i_Add (
	.i_Operand_0 (Id ),
	.i_Operand_1 (i_Operand_1 ),
	.o_Add_result(o_Add_result)
);

ALU i_ALU (
	.i_Control   (i_Control   ),
	.i_Data_1    (i_Data_1    ),
	.i_Data_2    (i_Data_2    ),
	.o_Zero      (o_Zero      ),
	.o_ALU_Result(o_ALU_Result)
);

Mux i_Mux (
	.i_Control(i_Chhhontrol), 
	.i_Input_0(i_Input_0), 
	.i_Input_1(i_Input_1), 
	.o_Salida(o_Salida)
	);
	
ALU_control i_ALU_control (
	.i_ALUOp(i_ALUOp), 
	.i_Function_code(i_Function_code), 
	.o_Operation(o_Operation)
	);

	
Mux #(.BUS_SIZE(5)) i_Mux (
	.i_Control(i_Control), 
	.i_Input_0(i_Input_0), 
	.i_Input_1(i_Input_1), 
	.o_Salida(o_Salida));






endmodule