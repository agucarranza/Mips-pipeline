`timescale 1ns / 1ps

module PC (
	input  wire        i_clk    ,
	input  wire        i_rst    ,
	input  wire        i_Stall  ,
	input  wire        i_Halt   ,
	input  wire [31:0] i_address,
	output wire [31:0] o_address
);

	reg [31:0] ProgCounter;

	
	always @(negedge i_clk) begin
		if (i_rst) 
			ProgCounter <= 32'b0;
		else if (i_Halt)
			ProgCounter <= ProgCounter;
		else if (~i_Stall)
			ProgCounter <= i_address;		
	end

	assign o_address = ProgCounter;

	always @(negedge i_clk) begin 
		$display("PC: %h",ProgCounter);
	end

endmodule
