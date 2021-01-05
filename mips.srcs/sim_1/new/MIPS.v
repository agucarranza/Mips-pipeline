`timescale 1ns / 1ps
`include "Mux" `include "PC" `include "Add" `include "Instruction_memory" `include "IF_ID"
`include "Registers" `include "Control" `include "ID_EX"

module MIPS

	(
		input clk, // Clock
		input rst  // Asynchronous reset active low
	);

// IF Instruction Fetch

wire        Control  ;
wire [31:0] i_Input_0;
wire [31:0] i_Input_1;
wire [31:0] o_Salida ;
Mux i_Mux_IF (
	.i_Control(Control  ),
	.i_Input_0(i_Input_0),
	.i_Input_1(i_Input_1),
	.o_Salida (o_Salida )
);

wire [31:0] i_address;
wire [31:0] o_address;
PC i_PC (
	.clk      (clk      ),
	.i_address(i_address),
	.o_address(o_address)
);

wire [31:0] i_Operand_0 ;
wire [31:0] i_Operand_1 ;
wire [31:0] o_Add_result;
Add i_Add_PC (
	.i_Operand_0 (i_Operand_0 ),
	.i_Operand_1 (i_Operand_1 ),
	.o_Add_result(o_Add_result)
);

wire [31:0] i_Read_address;
wire [31:0] o_Instruction ;
Instruction_memory i_Instruction_memory (
	.clk           (clk           ),
	.i_Read_address(i_Read_address),
	.o_Instruction (o_Instruction )
);

// END IF 

wire [31:0] i_PC_Address ;
wire [31:0] i_Instruction;
wire [31:0] o_PC_Address ;
IF_ID i_IF_ID (
	.clk          (clk          ),
	.rst          (rst          ),
	.i_PC_Address (i_PC_Address ),
	.i_Instruction(i_Instruction),
	.o_PC_Address (o_PC_Address ),
	.o_Instruction(o_Instruction)
);

// ID Instruction Decode


	wire i_clk;
	wire i_rst;
	wire i_RegWrite;
	wire [4:0] i_Read_register_1;
	wire [4:0] i_Read_register_2;
	wire [4:0] i_Write_register;
	wire [31:0] i_Write_data;
	wire [31:0] o_Read_data_1;
	wire [31:0] o_Read_data_2;
Registers i_Registers (
	.i_clk            (i_clk            ),
	.i_rst            (i_rst            ),
	.i_RegWrite       (i_RegWrite       ),
	.i_Read_register_1(i_Read_register_1),
	.i_Read_register_2(i_Read_register_2),
	.i_Write_register (i_Write_register ),
	.i_Write_data     (i_Write_data     ),
	.o_Read_data_1    (o_Read_data_1    ),
	.o_Read_data_2    (o_Read_data_2    )
);


	wire [5:0] i_Op;
	wire o_RegDst;
	wire [1:0] o_ALUOp;
	wire o_ALUSrc;
	wire o_Branch;
	wire o_MemRead;
	wire o_MemWrite;
	wire o_RegWrite;
	wire o_MemtoReg;
Control i_Control (
	.i_Op      (i_Op      ),
	.o_RegDst  (o_RegDst  ),
	.o_ALUOp   (o_ALUOp   ),
	.o_ALUSrc  (o_ALUSrc  ),
	.o_Branch  (o_Branch  ),
	.o_MemRead (o_MemRead ),
	.o_MemWrite(o_MemWrite),
	.o_RegWrite(o_RegWrite),
	.o_MemtoReg(o_MemtoReg)
);


	wire [31:0] i_Read_data_1;
	wire [31:0] i_Read_data_2;
	wire [31:0] i_Immediate;
	wire [4:0] i_rt;
	wire [4:0] i_rd;
	wire i_MemtoReg;
	wire i_Branch;
	wire i_MemRead;
	wire i_MemWrite;
	wire i_RegDst;
	wire [1:0] i_ALUOp;
	wire i_ALUSrc;
	wire [31:0] o_Immediate;
	wire [4:0] o_rt;
	wire [4:0] o_rd;
ID_EX i_ID_EX (
	.clk          (clk          ),
	.rst          (rst          ),
	.i_PC_Address (i_PC_Address ),
	.i_Read_data_1(i_Read_data_1),
	.i_Read_data_2(i_Read_data_2),
	.i_Immediate  (i_Immediate  ),
	.i_rt         (i_rt         ),
	.i_rd         (i_rd         ),
	.i_RegWrite   (i_RegWrite   ),
	.i_MemtoReg   (i_MemtoReg   ),
	.i_Branch     (i_Branch     ),
	.i_MemRead    (i_MemRead    ),
	.i_MemWrite   (i_MemWrite   ),
	.i_RegDst     (i_RegDst     ),
	.i_ALUOp      (i_ALUOp      ),
	.i_ALUSrc     (i_ALUSrc     ),
	.o_PC_Address (o_PC_Address ),
	.o_Read_data_1(o_Read_data_1),
	.o_Read_data_2(o_Read_data_2),
	.o_Immediate  (o_Immediate  ),
	.o_rt         (o_rt         ),
	.o_rd         (o_rd         ),
	.o_RegWrite   (o_RegWrite   ),
	.o_MemtoReg   (o_MemtoReg   ),
	.o_Branch     (o_Branch     ),
	.o_MemRead    (o_MemRead    ),
	.o_MemWrite   (o_MemWrite   ),
	.o_RegDst     (o_RegDst     ),
	.o_ALUOp      (o_ALUOp      ),
	.o_ALUSrc     (o_ALUSrc     )
);


Add i_Add_Branch (
	.i_Operand_0(i_Operand_0), 
	.i_Operand_1(i_Operand_1), 
	.o_Add_result(o_Add_result));


	wire [31:0] i_Data_1;
	wire [31:0] i_Data_2;
	wire o_Zero;
	wire [31:0] o_ALU_Result;
	wire i_Control;
ALU i_ALU (
	.i_Control   (i_Control   ), // TODO: Check connection ! Signal/port not matching : Expecting logic [3:0]  -- Found logic 
	.i_Data_1    (i_Data_1    ),
	.i_Data_2    (i_Data_2    ),
	.o_Zero      (o_Zero      ),
	.o_ALU_Result(o_ALU_Result)
);



Mux i_Mux_ALUSrc (
	.i_Control(i_Control), 
	.i_Input_0(i_Input_0), 
	.i_Input_1(i_Input_1), 
	.o_Salida(o_Salida)
	);

	wire [5:0] i_Function_code;
	wire [3:0] o_Operation;
ALU_control i_ALU_control (
	.i_ALUOp(i_ALUOp), 
	.i_Function_code(i_Function_code), 
	.o_Operation(o_Operation)
	);

Mux i_Mux_RegDst (
	.i_Control(i_Control), 
	.i_Input_0(i_Input_0), 
	.i_Input_1(i_Input_1), 
	.o_Salida(o_Salida)
	);


	wire [31:0] i_Add_result;
	wire i_Zero;
	wire [31:0] i_ALU_result;
	wire [31:0] o_ALU_result;
EX_MEM i_EX_MEM (
	.clk          (clk          ),
	.rst          (rst          ),
	.i_Add_result (i_Add_result ),
	.i_Zero       (i_Zero       ),
	.i_ALU_result (i_ALU_result ),
	.i_Read_data_2(i_Read_data_2),
	.i_RegWrite   (i_RegWrite   ),
	.i_MemtoReg   (i_MemtoReg   ),
	.i_Branch     (i_Branch     ),
	.i_MemRead    (i_MemRead    ),
	.i_MemWrite   (i_MemWrite   ),
	.o_Add_result (o_Add_result ),
	.o_Zero       (o_Zero       ),
	.o_ALU_result (o_ALU_result ),
	.o_Read_data_2(o_Read_data_2),
	.o_RegWrite   (o_RegWrite   ),
	.o_MemtoReg   (o_MemtoReg   ),
	.o_Branch     (o_Branch     ),
	.o_MemRead    (o_MemRead    ),
	.o_MemWrite   (o_MemWrite   )
);

// MEM

//TODO: FALTA HACER LA MEMORIA DE DATOS


	wire [31:0] i_Address;
	wire [31:0] o_Address;
MEM_WB i_MEM_WB (
	.clk        (clk          ),
	.rst        (rst          ),
	.i_Address  (i_Address    ),
	.i_Read_data(i_Read_data_1),
	.i_RegWrite (i_RegWrite   ),
	.i_MemtoReg (i_MemtoReg   ),
	.o_Address  (o_Address    ),
	.o_Read_data(o_Read_data_2),
	.o_RegWrite (o_RegWrite   ),
	.o_MemtoReg (o_MemtoReg   )
);

Mux i_Mux_MemtoReg (
	.i_Control(i_Control), 
	.i_Input_0(i_Input_0), 
	.i_Input_1(i_Input_1), 
	.o_Salida(o_Salida)
	);

endmodule