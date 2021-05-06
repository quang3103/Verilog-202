module t_bound_flasher();
	
	wire [15:0]led;
	wire [4:0] max, min;
	wire [1:0]isFlick;
	reg flick, clk;
	
	bound_flasher bf0(.lamp(led), .flick(flick), .clk(clk));
	
	initial $monitor("%t: clock = %b | flick = %b | led = %b\n", $time, clk, flick, led);
		
	initial 
	begin
		clk = 1;
		forever #5 clk = ~clk;
	end 
	
	initial 
	begin
		//flick at 10 when go from 5 to 15
		/*#25 flick = 1'b1;
		#5 flick = 1'b0;
		#345 flick = 1'b1;
		#2 flick = 1'b0;
		#798 $stop;*/
		
		//no flick at all, and finish
		/*#25 flick = 1'b1;
		#5 flick = 1'b0;
		#800 $stop;*/
		
		//no flick at first time, finish and than start again
		#25 flick = 1'b1;
		#5 flick = 1'b0;
		#805 flick = 1'b1;
		#2 flick = 1'b0;
		#800 $stop;
		
	end 
	
endmodule 