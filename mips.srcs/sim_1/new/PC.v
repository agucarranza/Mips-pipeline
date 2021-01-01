`timescale 1ns / 1ps

module PC
(
    input wire clk,
    input wire [31:0] i_address,
    output wire [31:0] o_address
);

reg [31:0] ProgCounter;

always @(posedge clk) begin
    ProgCounter <= i_address; 
end

assign ProgCounter = o_address;

endmodule
 