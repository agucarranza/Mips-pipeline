`timescale 1ns / 1ps

module PC
(
    input wire i_clk,
    input wire [31:0] i_address,
    output wire [31:0] o_address
);

reg [31:0] ProgCounter;

always @(posedge i_clk) begin
    ProgCounter <= i_address; 
end

assign o_address = ProgCounter;

endmodule
 