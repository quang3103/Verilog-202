module main(LEDR, LEDG, KEY, CLOCK_50, HEX7, HEX6, HEX5, HEX4);
	input [1:0]KEY;
	input CLOCK_50;
	output [15:0]LEDR;
	output [1:0]LEDG;
	output [6:0] HEX7, HEX6, HEX5, HEX4;
	
	
	wire clock;
	
	clock_div clock_0(.clock50(CLOCK_50), .clock(clock));
	
	bound_flasher bound_flasher_0(.lamp(LEDR[15:0]), .clk(clock), .flick(~KEY[0]));
	
endmodule 