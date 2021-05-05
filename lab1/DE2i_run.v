module DE2i_run(LEDR, LEDG, KEY, CLOCK_50);
	input [1:0]KEY;
	input CLOCK_50;
	output [15:0]LEDR;
	output [1:0]LEDG;
	
	wire clock1s;
	wire max, min, isFlick;
	
	assign LEDG[1:0] = {2{clock1s}};
	
	clock_div clk1(.clock50(CLOCK_50), .clock(clock1s));
	bound_flasher(.led(LEDR), .flick(~KEY[0]), .clk(clock1s), .max(max), .min(min), .isFlick(isFlick));
	
endmodule 