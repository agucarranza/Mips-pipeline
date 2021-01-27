`timescale 1ns / 1ps

module Instruction_memory (
	input  wire        i_clk         ,
	input  wire        i_rst         ,
	input  wire [31:0] i_Read_address,
	output wire [31:0] o_Instruction
);

	reg [31:0] memory[0:1023];
	reg [31:0] tmp           ;

	initial begin
		// Relleno del Pipeline
		memory[0] = 32'h00e7_3824;
		memory[1] = 32'h00e7_3824;
		memory[2] = 32'h00e7_3824;
		memory[3] = 32'h00e7_3824;
		memory[4] = 32'h00e7_3824;
		memory[5] = 32'h00e7_3824;
		// memory[6] = 32'h0240_0809; // jalr $1, $18 
		// memory[6] = 32'h0240_0008; // jr   $18
		// memory[6] = 32'h0c00_0014; // jal  14
		// memory[6] = 32'h0800_0014; // j    14
		// memory[6] = 32'h2881_0009; // slti $1, $4, 7/9
		// memory[6] = 32'h3c01_000a; // lui  $1, $7, 85
		// memory[6] = 32'h38e1_0055; // xori $1, $7, 85
		// memory[6] = 32'h3421_0055; // ori  $1, $1, 85
		// memory[6] = 32'h30e1_0037; // andi $1, $7, 55
		// memory[6] = 32'h2041_0037; // addi $1, $2, 55
		// memory[6] = 32'h0062_0827; // nor  $1, $2, $3
		// memory[6] = 32'h0047_0826; // xor  $1, $2, $7
		// memory[6] = 32'h0043_0825; // or   $1, $2, $3
		// memory[6] = 32'h0043_0824; // and  $1, $2, $3
		// memory[6] = 32'h0043_082a; // slt  $1, $2, $3
		// memory[6] = 32'h0065_0823; // subu $1, $3, $5
		// memory[6] = 32'h0065_0823; // subu $1, $3, $5
		// memory[6] = 32'h0065_0821; // addu $1, $3, $5
		// memory[6] = 32'h00a3_0807; // srav $1, $3, $5
		// memory[6] = 32'h00a3_0806; // srlv $1, $3, $5
		// memory[6] = 32'h00a2_0804; // sllv $1, $2, $5
		// memory[6] = 32'h0002_0883; // sra  $1, $2, 2
		// memory[6] = 32'h0002_0882; // srl  $1, $2, 2

		// memory[6] = 32'h0002_08c0; // sll  $1, $2, 3
     	// memory[6] = 32'h8c23_0000; // lw 	OK!
	 	 memory[6] = 32'hac23_0000; // sw 	OK!
	 	// memory[6] = 32'h0043_0820; // add 	OK!
	 	// memory[6] = 32'h1026_0006; // beq --+
								    //		\
								    //		\
		memory[7]  = 32'h00e7_3824; //		\
		memory[8]  = 32'h00e7_3824; //		\			
		memory[9]  = 32'h00e7_3824; // <----+
		memory[10] = 32'h00e7_3824; // <<---
		memory[11] = 32'h00e7_3824;
		memory[12] = 32'h00e7_3824;
		memory[13] = 32'h00e7_3824;
		memory[14] = 32'h00e7_3824;
		memory[15] = 32'h00e7_3824;
		memory[16] = 32'h00e7_3824;
		memory[18] = 32'h00e7_3824;
		memory[19] = 32'h00e7_3824;
		memory[20] = 32'h00e7_3824;
		memory[21] = 32'h00e7_3824;
		memory[22] = 32'h00e7_3824;
	end

//Leer

	always @(posedge i_clk) begin : proc_read
		if (i_rst) begin
			tmp <= 32'b0;
		end else begin
			tmp <= memory[i_Read_address];
		end
	end



//Escribir

	always @(posedge i_clk) begin : proc_write
		if(i_rst) begin
			//	<= 0;
		end else begin
			//	<= ;
		end
	end


	assign o_Instruction = tmp;

endmodule