module Data_memory (
	input  wire        i_clk       , // Clock
	input  wire        i_rst       , // Asynchronous reset active low
	input  wire [31:0] i_Address   ,
	input  wire [31:0] i_Write_data,
	input  wire        i_MemWrite  ,
	input  wire        i_MemRead   ,
	input  wire [ 1:0] i_Long      ,
	output wire [31:0] o_Read_data
);

	reg [31:0] registers[1023:0];
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
				case(i_Long)
					2'b00 : tmp_read <= { 24'b0 ,tmp_read[ 7:0] };
					2'b01 : tmp_read <= { 16'b0 ,tmp_read[15:0] };
					2'b11 : tmp_read <= tmp_read;

					default : tmp_read <= tmp_read;
				endcase // i_Long
			end
		end
	end

	always @(posedge i_clk) begin : proc_
		if(i_MemWrite) begin

			tmp_write <= registers[i_Address];
			case (i_Long)

				2'b00 : tmp_write <= { tmp_write[31:8], i_Write_data[7:0] };
				2'b01 : tmp_write <= { tmp_write[31:16], i_Write_data[15:0] };
				2'b11 : tmp_write <= i_Write_data;

				default : tmp_write <= i_Write_data;
			endcase

			registers[i_Address] <= tmp_write;
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