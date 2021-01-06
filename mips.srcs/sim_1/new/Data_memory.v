module Data_memory (
	input  wire        i_clk       , // Clock
	input  wire        i_rst       , // Asynchronous reset active low
	input  wire [31:0] i_Address   ,
	input  wire [31:0] i_Write_data,
	input  wire        i_MemWrite  ,
	input  wire        i_MemRead   ,
	output wire [31:0] o_Read_data
);

	reg [31:0] registers[0:1023];
	reg [31:0] tmp_read         ;
	reg [31:0] tmp_write        ;


	always @(posedge i_clk) begin : proc_read
		if(i_rst) begin
			tmp_read <= 32'b0;
		end else begin
			if (i_MemRead) begin : read_flag
				tmp_read <= registers[i_Address] ;
			end//else
		end//if
	end//always

	always @(posedge i_clk) begin : proc_
		if(i_MemWrite) begin
			registers[i_Address] <= i_Write_data;
		end
	end

	assign o_Read_data = tmp_read;





endmodule