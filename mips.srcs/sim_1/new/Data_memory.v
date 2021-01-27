module Data_memory (
	input  wire        i_clk       , // Clock
	input  wire        i_rst       , // Asynchronous reset active low
	input  wire [31:0] i_Address   ,
	input  wire [31:0] i_Write_data,
	input  wire        i_MemWrite  ,
	input  wire        i_MemRead   ,
	input  wire [ 1:0] i_Long      ,
	input  wire        i_MemSign   ,
	output wire [31:0] o_Read_data
);

	reg [31:0] registers[0:1023];
	
	reg [31:0] tmp_read         ;
	reg [31:0] tmp_write        ;


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
				tmp_read <= registers[i_Address];
			end
		end
	end

	wire [23:0] extension24 = (i_MemSign) ? {24{tmp_read[ 7]}} : 24'b0; 
	wire [15:0] extension16 = (i_MemSign) ? {16{tmp_read[15]}} : 16'b0;

	assign o_Read_data = (i_Long == 2'b00) ? { extension24 ,tmp_read[ 7:0] } :
						 (i_Long == 2'b01) ? { extension16 ,tmp_read[15:0] } :
						 tmp_read;


	wire [31:0] writing_reg = registers[i_Address]                    ;
	wire [31:0] v_byte      = {writing_reg[31: 8], i_Write_data[ 7:0]};
	wire [31:0] v_hw        = {writing_reg[31:16], i_Write_data[15:0]};


	always @(posedge i_clk) begin : proc_write
		if(i_MemWrite) begin

			case (i_Long)

				2'b00 : registers[i_Address] <= v_byte;
				2'b01 : registers[i_Address] <= v_hw;
				2'b11 : registers[i_Address] <= i_Write_data;

				default : registers[i_Address] <= i_Write_data;
			endcase
		end
	end


	always @(posedge i_clk) begin
		$display("Memoria de datos");
		$display("%h, %h, %h, %h, %h, %h",
			registers[1],
			registers[2],
			registers[3],
			registers[4],
			registers[5],
			registers[6]);
		$display("");
	end

endmodule