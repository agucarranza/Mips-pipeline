`timescale 1ns / 1ps

module PC (
	input  wire        i_clk    ,
	input  wire        i_rst    ,
	input  wire [31:0] i_address,
	output wire [31:0] o_address
);

	reg [31:0] ProgCounter;

	initial begin
		ProgCounter = 32'b0;
	end

	always @(posedge i_clk) begin
		if (i_rst) begin
			ProgCounter <= 32'b0;
		end else begin
			ProgCounter <= i_address;
		end
	end

	assign o_address = ProgCounter;

endmodule
