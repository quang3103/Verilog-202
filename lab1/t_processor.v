module t_processor();
	
	wire enable, increase;
	reg [4:0]position;
	reg flick;
	
	processor pc0 (.enable(enable), .increase(increase), .position(position), .flick(flick));
	
	initial $monitor("%t: enable =  %b | increase = %b | position = %d | flick = %b\n", $time, enable, increase, position, flick);
	
	initial begin
		#1 flick = 1'b1; 
		#5 position = 5'd0;
		#5 position = 5'd1;
		#5 position = 5'd2;
		#5 position = 5'd3;
		#5 position = 5'd4;
		#10 position = 5'd5;
		#20 position = 5'd6;
		#5 position = 5'd7;
		#5 $stop;
	end 
endmodule 