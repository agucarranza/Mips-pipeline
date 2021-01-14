module Data_memory (
	input  wire        i_clk       , // Clock
	input  wire        i_rst       , // Asynchronous reset active low
	input  wire [31:0] i_Address   ,
	input  wire [31:0] i_Write_data,
	input  wire        i_MemWrite  ,
	input  wire        i_MemRead   ,
	input  wire [1:0]  i_Long      ,
	output wire [31:0] o_Read_data
);

	reg [31:0] registers[0:1023];
	reg [31:0] tmp_read         ;

	initial begin 
		registers[1] = 32'h0000_0001;
		registers[2] = 32'h0000_0003;
		registers[3] = 32'h0000_0005;
		registers[4] = 32'h0000_0009;
		registers[5] = 32'h0000_000F;
		registers[6] = 32'h0000_0002;
	end


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

	always @(posedge i_clk) begin 
		$display("Memoria de datos");
		$display("%h",registers[1]);
		$display("%h",registers[2]);
		$display("%h",registers[3]);
		$display("%h",registers[4]);
		$display("%h",registers[5]);
		$display("%h",registers[6]);
	end
endmodule


// TODO: Falta resolver los tamaños!!!!!