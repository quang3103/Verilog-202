module t_bound_flasher();
	
	wire [15:0]led;
	reg flick, clk;
	
	bound_flasher bf0(.led(led), .flick(flick), .clk(clk));
	
	initial $monitor("%t: clock = %b | flick = %b | led = %b\n", $time, clk, flick, led);
	
	
	initial 
	begin
		clk = 1;
		forever #5 clk = ~clk;
	end 
	
	initial 
	begin
		#25 flick = 1'b1;
		#5 flick = 1'b0;
		//#5 flick = 1'b0;
		//#225 flick = 1'b1;
		//#5 flick = 1'b0;
		#615 flick = 1'b1;
		#5 flick = 1'b0;
		#600 $stop;
	end 
	
endmodule 