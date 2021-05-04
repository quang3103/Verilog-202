module processor(enable, increase, position, flick, out_max, out_min, out_state);
	input [4:0] position;
	input flick;
	
	output reg enable, increase;
	
	output [4:0]out_max, out_min;
	output [1:0]out_state;
	
	reg [4:0] max, min, pre_min, pre_position;
	reg isFlick, isEnd;
	reg [1:0] state, next_state, pre_state;
	
	initial begin
		isFlick = 1'b0;
		increase = 1'b1;
		enable = 1'b0;
		max = 5'd6;
		min = 5'd0;
		pre_min = 5'd0;
		state = 2'b00;
		next_state = 2'b00;
	end
	
	assign out_max = max;
	assign out_min = min;
	assign out_state = state;

	/*always @(posedge flick, posedge isEnd)
	begin
		if (flick == 1'b1)
		begin
			if (enable == 1'b0)
			begin
				enable <= 1'b1;
			end
			else 
			begin
				if ((position == 5'd6) || (position == 5'd11))
				begin
					isFlick <= 1'b1;
				end
				else
				begin
					isFlick <= 1'b0;
				end
			end	
		end
		else if (isEnd == 1'b1)
		begin
			enable <= 1'b0;
		end
		else
		begin
			isFlick <= 1'b0;
		end
	end*/
	
	always @(posedge flick, posedge isEnd)
	begin
		if (flick == 1'b1)
		begin
			if (enable == 1'b0)
			begin
				enable <= 1'b1;
			end
			else 
			begin
				enable <= enable;
			end
		end
		else
		begin
			enable <= 1'b0;
		end
	end
	
	always @(position, flick) 
	begin
		if (flick == 1'b1)
		begin
			isEnd = 1'b0;
			if ((position == 5'd6) || (position == 5'd11))
			begin	
				next_state = pre_state;
				isFlick = 1'b1;
				increase = 1'b0;
			end
			else
			begin
				isFlick = 1'b0;
				increase = increase;
			end
			//-----------------------------------------------
			if (increase == 1'b1)
			begin
				if (position == max)
				begin 
					isFlick = 1'b0;
					increase = 1'b0;
				end 
				else 
				begin
					increase = increase;
				end
			end
			else
			begin
				if (position == min)
				begin
					case (state)
						2'b00: next_state = 2'b01;
						2'b01: next_state = 2'b10;
						2'b10: 
							begin 
								next_state = 2'b00;
								isEnd = 1'b1;
							end
					endcase
					isFlick = 1'b0;
					increase = 1'b1;
				end 
				else 
				begin
					increase = increase;
				end
			end
		end
		else
		begin
			if (increase == 1'b1)
			begin
				if (position == max)
				begin 
					isFlick = 1'b0;
					increase = 1'b0;
				end 
				else 
				begin
					increase = increase;
				end
			end
			else
			begin
				if (position == min)
				begin
					case (state)
						2'b00: next_state = 2'b01;
						2'b01: next_state = 2'b10;
						2'b10: 
							begin 
								next_state = 2'b00;
								isEnd = 1'b1;
							end
					endcase
					isFlick = 1'b0;
					increase = 1'b1;
				end 
				else 
				begin
					increase = increase;
				end
			end
		end
	end
	
	always @(next_state, isFlick)
	begin
		pre_state = state;
		state = next_state;
	end
	
	always @(state)
	begin
		case (state)
			2'b00:
				begin
					max = 5'd6;
					min = 5'd0;
					//pre_min = 5'd0;
				end
			2'b01:
				begin
					max = 5'd11;
					min = 5'd5;
					//pre_min = 5'd0;
				end
			2'b10:
				begin
					max = 5'd16;
					min = 5'd0;
					//pre_min = 5'd5;
				end
		endcase
	end

endmodule