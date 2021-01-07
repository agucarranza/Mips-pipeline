`timescale 1ns / 1ps
`include "Mux.v" `include "PC.v" `include "Add.v" `include "Instruction_memory.v" `include "IF_ID.v"
`include "Registers.v" `include "Control.v" `include "ID_EX.v"
`include "ALU_control.v" `include "ALU.v" `include "EX_MEM.v"

module MIPS
	(
		input clk, // Clock
		input rst  // Asynchronous reset active low
	);
// Control
wire       PCSrc   ;
wire       RegWrite;
wire       RegDst  ;
wire       ALUSrc  ;
wire [1:0] ALUOp   ;

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
wire [31:0] IDEX_to_Add_PCAddress                           ;
wire [31:0] IDEX_to_ALU_ReadData1                           ;
wire [31:0] IDEX_to_MuxALUSrc_to_EXMEM_ReadData2            ;
wire [ 4:0] IDEX_to_MuxRegDst_rt_0                          ;
wire [ 4:0] IDEX_to_MuxRegDst_rd_1                          ;
wire [31:0] IDEX_to_ALUControl_to_Add_to_MuxALUSrc_Immediate;
wire [31:0] MuxALUSrc_to_ALU_Operand2                       ;
wire        ALU_to_EXMEM_Zero                               ;
wire [ 3:0] ALUControl_to_ALU_Operation                     ;
wire [31:0] Add_to_EXMEM_AddResult                          ;
wire [31:0] ALU_to_EXMEM_ALUResult                          ;
wire [ 4:0] MuxRegDst_to_EXMEM_Result                       ;







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
	.clk          (clk                                             ),
	.rst          (rst                                             ),
	.i_PC_Address (IFID_to_IDEX_PC_Address                         ),
	.i_Read_data_1(Registers_to_IDEX_ReadData1                     ),
	.i_Read_data_2(Registers_to_IDEX_ReadData2                     ),
	.i_Immediate  ({ {16{Instruction[15]}}, Instruction[15:0] }    ), // Sign extension
	.i_rt         (Instruction[20:16]                              ),
	.i_rd         (Instruction[15:11]                              ),
	.i_RegWrite   (ID_RegWrite                                     ),
	.i_MemtoReg   (ID_MemtoReg                                     ),
	.i_Branch     (ID_Branch                                       ),
	.i_MemRead    (ID_MemRead                                      ),
	.i_MemWrite   (ID_MemWrite                                     ),
	.i_RegDst     (ID_RegDst                                       ),
	.i_ALUOp      (ID_ALUOp                                        ),
	.i_ALUSrc     (ID_ALUSrc                                       ),
	.o_PC_Address (IDEX_to_Add_PCAddress                           ),
	.o_Read_data_1(IDEX_to_ALU_ReadData1                           ),
	.o_Read_data_2(IDEX_to_MuxALUSrc_to_EXMEM_ReadData2            ),
	.o_Immediate  (IDEX_to_ALUControl_to_Add_to_MuxALUSrc_Immediate),
	.o_rt         (IDEX_to_MuxRegDst_rt_0                          ),
	.o_rd         (IDEX_to_MuxRegDst_rd_1                          ),
	.o_RegWrite   (EX_RegWrite                                     ),
	.o_MemtoReg   (EX_MemtoReg                                     ),
	.o_Branch     (EX_Branch                                       ),
	.o_MemRead    (EX_MemRead                                      ),
	.o_MemWrite   (EX_MemWrite                                     ),
	.o_RegDst     (RegDst                                          ),
	.o_ALUOp      (ALUOp                                           ),
	.o_ALUSrc     (ALUSrc                                          )
);

// EX

Add i_Add (
	.i_Operand_0 (IDEX_to_Add_PCAddress                                ),
	.i_Operand_1 ((IDEX_to_ALUControl_to_Add_to_MuxALUSrc_Immediate<<2)), // Shift left 2
	.o_Add_result(Add_to_EXMEM_AddResult                               )
);

ALU i_ALU (
	.i_Control   (ALUControl_to_ALU_Operation),
	.i_Data_1    (IDEX_to_ALU_ReadData1      ),
	.i_Data_2    (MuxALUSrc_to_ALU_Operand2  ),
	.o_Zero      (ALU_to_EXMEM_Zero          ),
	.o_ALU_Result(ALU_to_EXMEM_ALUResult     )
);

Mux i_Mux_ALUSrc (
	.i_Control(ALUSrc                                          ),
	.i_Input_0(IDEX_to_MuxALUSrc_to_EXMEM_ReadData2            ),
	.i_Input_1(IDEX_to_ALUControl_to_Add_to_MuxALUSrc_Immediate),
	.o_Salida (MuxALUSrc_to_ALU_Operand2                       )
);

ALU_control i_ALU_control (
	.i_ALUOp        (ALUOp                                                ),
	.i_Function_code(IDEX_to_ALUControl_to_Add_to_MuxALUSrc_Immediate[5:0]),
	.o_Operation    (ALUControl_to_ALU_Operation                          )
);


Mux #(.BUS_SIZE(5)) i_Mux_RegDst (
	.i_Control(RegDst                   ),
	.i_Input_0(IDEX_to_MuxRegDst_rt_0   ),
	.i_Input_1(IDEX_to_MuxRegDst_rd_1   ),
	.o_Salida (MuxRegDst_to_EXMEM_Result)
);

EX_MEM i_EX_MEM (
	.clk               (clk                                 ),
	.rst               (rst                                 ),
	.i_Add_result      (Add_to_EXMEM_AddResult              ),
	.i_Zero            (ALU_to_EXMEM_Zero                   ),
	.i_ALU_result      (ALU_to_EXMEM_ALUResult              ),
	.i_Read_data_2     (IDEX_to_MuxALUSrc_to_EXMEM_ReadData2),
	.i_MuxRegDst_result(MuxRegDst_to_EXMEM_Result           ),
	.i_RegWrite        (EX_RegWrite                         ),
	.i_MemtoReg        (EX_MemtoReg                         ),
	.i_Branch          (EX_Branch                           ),
	.i_MemRead         (EX_MemRead                          ),
	.i_MemWrite        (EX_MemWrite                         ),
	.o_Add_result      (o_Add_result                        ), // Completar
	.o_Zero            (o_Zero                              ), // Completar
	.o_ALU_result      (o_ALU_result                        ), // Completar
	.o_Read_data_2     (o_Read_data_2                       ), // Completar
	.o_MuxRegDst_result(o_MuxRegDst_result                  ), // Completar
	.o_RegWrite        (o_RegWrite                          ), // Completar
	.o_MemtoReg        (o_MemtoReg                          ), // Completar
	.o_Branch          (o_Branch                            ), // Completar
	.o_MemRead         (o_MemRead                           ), // Completar
	.o_MemWrite        (o_MemWrite                          ) // Completar
);




endmodule