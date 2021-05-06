module BCD_to_HEX(data_in, data_out);
	
	input [3:0] data_in;
	output [6:0] data_out;
	
	assign data_out = (data_in == 4'b0000) ? (7'b100_0000) :
							(data_in == 4'b0001) ? (7'b111_1001) :
							(data_in == 4'b0010) ? (7'b010_0100) :
							(data_in == 4'b0011) ? (7'b011_0000) :
							(data_in == 4'b0100) ? (7'b001_1001) :
							(data_in == 4'b0101) ? (7'b001_0010) :
							(data_in == 4'b0110) ? (7'b000_0010) :
							(data_in == 4'b0111) ? (7'b111_1000) :
							(data_in == 4'b1000) ? (7'b000_0000) :
							(data_in == 4'b1001) ? (7'b001_0000) : (7'b111_1111);
	
endmodule  