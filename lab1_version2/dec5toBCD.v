module dec5toBCD(data_in, out1, out0);
	
	input [4:0] data_in;
	output [3:0] out1, out0;
	
	assign out0 = data_in % 10;
	assign out1 = data_in / 10;
	
endmodule 