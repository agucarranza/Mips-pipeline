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

     // memory[6] = 32'h8c23_0000; // lw 	OK!
	 	memory[6] = 32'hac23_0000; // sw 	OK!
	 //	memory[6] = 32'h0043_0820; // add 	OK!
	 //	memory[6] = 32'h1026_0006; // beq --+
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
		memory[17] = 32'h00e7_3824;
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