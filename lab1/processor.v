module processor(enable, increase, position, flick);
	input [4:0] position;
	input flick;
	
	output reg enable;
	output reg increase;
	
	reg [4:0] max, min, pre_min;
	reg isFlick, isEnd;
	
	initial begin
		isFlick = 1'b0;
		increase = 1'b1;
		enable = 1'b0;
		max = 5'd6;
		min = 5'd0;
		pre_min = 5'd0;
	end
	
	//assign enable = isWorking & !isEnd;

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
		else 
		begin
			enable <= 1'b0;
		end
	end
	
	always @(position) 
	begin
		if (increase == 1'b1)
		begin
			if (position == max)
			begin 
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
				increase = 1'b1;
			end 
			else 
			begin
				increase = increase;
			end
		end
	end
	
	always @(increase)
	begin
		if (enable == 1'b1)
		begin
			begin
				if (increase == 1'b0)
				begin
					case (max)
						5'd6: max = 5'd11;
						5'd11: max = 5'd16;
						5'd16: max = 5'd6;
						default: max = max;
					endcase
				end
				else
				begin
					case (min)
					5'd0:
						begin
							if (max == 5'd6) 
							begin
								min = 5'd0;
								pre_min = 5'd0;
								isEnd = 1'b1;
							end
							else
							begin
								min = 5'd5;
								pre_min = 5'd0;
								isEnd = 1'b0;
							end
						end
					5'd5:
						begin
							min = 5'd0;
							pre_min = 5'd5;
						end
					default:
						begin
							min = min;
							pre_min = pre_min;
						end
					endcase
				end
			end
		end
		else
		begin
			enable = 1'b0;
			min = 5'd0;
			max = 5'd6;
			pre_min = 5'd0;
		end
	end 
	
	/*always @(position) 
	begin
		if (increase == 1'b1)
		begin
			if (position == max)
			begin
				case (position)
				5'd6:
					begin
						max = 5'd11;
						increase = 1'b0;
					end
				5'd11:
					begin
						max = 5'd16;
						increase = 1'b0;
					end
				5'd16:
					begin
						max = 5'd6;
						increase = 1'b0;
					end
				default:
					begin
						max = max;
						increase = increase;
					end
				endcase
			end
			else 
			begin
				max = max;
				increase = increase;
			end
		end
		else 
		begin
			if (position == min)
			begin
				case (position)
				5'd0:
					begin
						min = 5'd5;
						pre_min = 5'd0;
						increase = 1'b1;
					end
				5'd5:
					begin
						min = 5'd0;
						pre_min = 5'd5;
						increase = 1'b1;
					end
				default:
					begin
						min = min;
						pre_min = pre_min;
						increase = increase;
					end
				endcase
			end
			else 
			begin
				min = min;
				increase = increase;
			end
		end 
	end */
endmodule 