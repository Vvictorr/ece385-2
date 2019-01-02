module  color_mapper  (input [9:0] DrawX, DrawY,	// Current pixel coordinates
							  input [3:0] tetris_block_data,
											  score_data,
											  O_block_data, 
											  I_vert_block_data, I_horiz_block_data,
											  Z_vert_block_data, Z_horiz_block_data,
											  S_vert_block_data, S_horiz_block_data, 
											  J_up_block_data, J_right_block_data, J_left_block_data, J_down_block_data, 
											  L_up_block_data, L_right_block_data, L_left_block_data, L_down_block_data,
											  T_up_block_data, T_right_block_data, T_left_block_data, T_down_block_data,
											  score_0_digit_data, score_1_digit_data, score_2_digit_data, score_3_digit_data,
											  score_4_digit_data, score_5_digit_data, score_6_digit_data, score_7_digit_data,
											  score_8_digit_data, score_9_digit_data,
							  input choose_O,
									  choose_I_horiz, choose_I_vert,
									  choose_Z_horiz, choose_Z_vert,
									  choose_S_horiz, choose_S_vert, 
									  choose_J_left, choose_J_up, choose_J_right, choose_J_down,
									  choose_L_left, choose_L_up, choose_L_right, choose_L_down,
									  choose_T_left, choose_T_up, choose_T_right, choose_T_down,
							  input [9:0] X_Pos, Y_Pos,														//from block_motion
							  input [5:0] block_size_x, block_size_y, 									//from choose_block
							  input [21:0][10:0][3:0] board,
							  input [15:0] score,																//from board

							  output logic [18:0] address,													//to sprite_ram
							  output logic [7:0] VGA_R, VGA_G, VGA_B 										//VGA RGB output
                      );
							 
//signals draw color
logic grid_on, logo_on, score_on;
logic O_block_on, 
		I_vert_block_on, I_horiz_block_on,
		Z_vert_block_on, Z_horiz_block_on,
		S_vert_block_on, S_horiz_block_on,
		J_left_block_on, J_up_block_on, J_right_block_on, J_down_block_on, 
		L_left_block_on, L_up_block_on, L_right_block_on, L_down_block_on,
		T_left_block_on, T_up_block_on, T_right_block_on, T_down_block_on,
		score_tens_digit_on, score_ones_digit_on;

logic [3:0] score_ones_digit_value;
assign score_ones_digit_value = (score % 10);

logic [3:0] score_tens_digit_value;
assign score_tens_digit_value = (score / 10);

//draw sprites//
always_comb begin
	O_block_on = 1'b0;
	
	I_vert_block_on = 1'b0;
	I_horiz_block_on = 1'b0;
	
	Z_vert_block_on = 1'b0;
	Z_horiz_block_on = 1'b0;
	
	S_vert_block_on = 1'b0;
	S_horiz_block_on = 1'b0;
	
	J_left_block_on = 1'b0;
	J_up_block_on = 1'b0;
	J_right_block_on = 1'b0;
	J_down_block_on = 1'b0;
	
	L_left_block_on = 1'b0;
	L_up_block_on = 1'b0;
	L_right_block_on = 1'b0;
	L_down_block_on = 1'b0;
	
	T_left_block_on = 1'b0;
	T_up_block_on = 1'b0;
	T_right_block_on = 1'b0;
	T_down_block_on = 1'b0;
	
	grid_on = 1'b0;
	logo_on = 1'b0;
	score_on = 1'b0;
	address = 19'd0;

	score_tens_digit_on = 1'b0;
	score_ones_digit_on = 1'b0;
	
	//draw active block
	if (DrawX >= X_Pos && DrawX < (X_Pos + block_size_x) && 
		 DrawY >= Y_Pos && DrawY < (Y_Pos + block_size_y)) begin
		//DRAW O
		if (choose_O == 1'd1) begin						//draw O block
			O_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		//DRAW I
		else if (choose_I_horiz == 1'd1) begin			//draw I horizontal block
			I_horiz_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		else if (choose_I_vert == 1'b1) begin			//draw I vertical block		
			I_vert_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		//DRAW Z
		else if (choose_Z_horiz == 1'd1) begin			//draw Z horizontal block
			Z_horiz_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		else if (choose_Z_vert == 1'b1) begin			//draw Z vertical block		
			Z_vert_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		//DRAW S
		else if (choose_S_horiz == 1'd1) begin			//draw S horizontal block
			S_horiz_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		else if (choose_S_vert == 1'b1) begin			//draw S vertical block		
			S_vert_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		//DRAW J
		else if (choose_J_left == 1'b1) begin			//draw J left
			J_left_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		else if (choose_J_up == 1'b1) begin				//draw J up
			J_up_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		else if (choose_J_right == 1'b1) begin			//draw J right
			J_right_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		else if (choose_J_down == 1'b1) begin			//draw J down	
			J_down_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		//DRAW L
		else if (choose_L_left == 1'b1) begin			//draw L left
			L_left_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		else if (choose_L_up == 1'b1) begin				//draw L up
			L_up_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		else if (choose_L_right == 1'b1) begin			//draw L right
			L_right_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		else if (choose_L_down == 1'b1) begin			//draw L down	
			L_down_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		//DRAW T
		else if (choose_T_left == 1'b1) begin			//draw T left
			T_left_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		else if (choose_T_up == 1'b1) begin				//draw T up
			T_up_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		else if (choose_T_right == 1'b1) begin			//draw T right
			T_right_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
		else if (choose_T_down == 1'b1) begin			//draw T down	
			T_down_block_on = 1'b1;
			address = ((DrawX - X_Pos) + (DrawY - Y_Pos) * block_size_x);
		end
		
	end	
	
	//draw grid
	if ((((DrawX % 9) == 0) || ((DrawY % 9) == 0)) && ((DrawX >= 270) && (DrawX <= 369)) && ((DrawY >= 135) && (DrawY <= 333)))	
	begin
		grid_on = 1'b1;
	end
	
	//draw logo
	if ((DrawX >= 260) && (DrawX < 385) && (DrawY >= 70) && (DrawY < 120))
		begin
			logo_on = 1'b1;
			address = ((DrawX - 260) + (DrawY - 70) * 125);
		end
		
	//draw score
	if ((DrawX >= 400) && (DrawX < 440) && (DrawY >= 135) && (DrawY < 150))
		begin
			score_on = 1'b1;
			address = ((DrawX - 400) + (DrawY - 135) * 40);
		end
	
	//draw score tens digit
	if ((DrawX >= 410) && (DrawX < 418) && (DrawY >= 155) && (DrawY < 170)) 
		begin
			score_tens_digit_on = 1'b1;
			address = ((DrawX - 410) + (DrawY - 155) * 8);
		end

	//draw score ones digit
    if ((DrawX >= 421) && (DrawX < 429) && (DrawY >= 155) && (DrawY < 170))
		begin
			score_ones_digit_on = 1'b1;
			address = ((DrawX - 421) + (DrawY - 155) * 8);
		end
	
end

	
//get colors//
logic [3:0] sprite_color;
logic [3:0] decided_color;
logic [7:0] Red, Green, Blue;

assign VGA_R = Red;
assign VGA_G = Green;
assign VGA_B = Blue;
colors colors_inst(.decided_color,
						 .DrawX,
						 
						 .Red, .Green, .Blue);

//assign colors to pixels//
always_comb begin
	//COLOR GRID
	if (grid_on == 1'b1)		//grid declared first to draw over all blocks
		sprite_color = 4'd10;
		
	//COLOR LOGO
	else if (logo_on == 1'b1)		
		sprite_color = tetris_block_data;
		
	//COLOR SCORE TEXT
	else if (score_on == 1'b1)		
		sprite_color = score_data;

	//COLOR SCORE TENS DIGIT
	else if (score_tens_digit_on == 1'b1) begin
		case (score_tens_digit_value)
			4'd0: begin
				sprite_color = score_0_digit_data;
			end

			4'd1: begin
				sprite_color = score_1_digit_data;
			end

			4'd2: begin
				sprite_color = score_2_digit_data;
			end

			4'd3: begin
				sprite_color = score_3_digit_data;
			end

			4'd4: begin
				sprite_color = score_4_digit_data;
			end

			4'd5: begin
				sprite_color = score_5_digit_data;
			end

			4'd6: begin
				sprite_color = score_6_digit_data;
			end

			4'd7: begin
				sprite_color = score_7_digit_data;
			end

			4'd8: begin
				sprite_color = score_8_digit_data;
			end

			4'd9: begin
				sprite_color = score_9_digit_data;
			end

			default: begin
				sprite_color = 4'd8;
			end
		endcase
	end

	//COLOR SCORE ONES DIGIT
	else if (score_ones_digit_on == 1'b1) begin
		case (score_ones_digit_value)
			4'd0: begin
				sprite_color = score_0_digit_data;
			end

			4'd1: begin
				sprite_color = score_1_digit_data;
			end

			4'd2: begin
				sprite_color = score_2_digit_data;
			end

			4'd3: begin
				sprite_color = score_3_digit_data;
			end

			4'd4: begin
				sprite_color = score_4_digit_data;
			end

			4'd5: begin
				sprite_color = score_5_digit_data;
			end

			4'd6: begin
				sprite_color = score_6_digit_data;
			end

			4'd7: begin
				sprite_color = score_7_digit_data;
			end

			4'd8: begin
				sprite_color = score_8_digit_data;
			end

			4'd9: begin
				sprite_color = score_9_digit_data;
			end

			default: begin
				sprite_color = 4'd8;
			end
		endcase
	end
	
	//COLOR O
	else if (O_block_on == 1'b1)
		sprite_color = O_block_data;
	
	//COLOR I
	else if (I_horiz_block_on == 1'b1)
		sprite_color = I_horiz_block_data;
	else if (I_vert_block_on == 1'b1)
		sprite_color = I_vert_block_data;
		
	//COLOR Z
	else if (Z_horiz_block_on == 1'b1)
		sprite_color = Z_horiz_block_data;
	else if (Z_vert_block_on == 1'b1)
		sprite_color = Z_vert_block_data;
		
	//COLOR S
	else if (S_horiz_block_on == 1'b1)
		sprite_color = S_horiz_block_data;
	else if (S_vert_block_on == 1'b1)
		sprite_color = S_vert_block_data;
	
	//COLOR J
	else if (J_left_block_on == 1'b1)
		sprite_color = J_left_block_data;	
	else if (J_up_block_on == 1'b1)
		sprite_color = J_up_block_data;
	else if (J_right_block_on == 1'b1)
		sprite_color = J_right_block_data;
	else if (J_down_block_on == 1'b1)
		sprite_color = J_down_block_data;	
	
	//COLOR L
	else if (L_left_block_on == 1'b1)
		sprite_color = L_left_block_data;	
	else if (L_up_block_on == 1'b1)
		sprite_color = L_up_block_data;
	else if (L_right_block_on == 1'b1)
		sprite_color = L_right_block_data;
	else if (L_down_block_on == 1'b1)
		sprite_color = L_down_block_data;
		
	//COLOR T
	else if (T_left_block_on == 1'b1)
		sprite_color = T_left_block_data;	
	else if (T_up_block_on == 1'b1)
		sprite_color = T_up_block_data;
	else if (T_right_block_on == 1'b1)
		sprite_color = T_right_block_data;
	else if (T_down_block_on == 1'b1)
		sprite_color = T_down_block_data;
		
	//COLOR BOARD STATE	
	else if (((DrawX >= 270) && (DrawX <= 369)) && ((DrawY >= 135) && (DrawY <= 333)))  
		sprite_color = board[((DrawY-135)/9)][((DrawX-270)/9)];
	
	//COLOR BACKGROUND
	else 
		sprite_color = 4'd8;
	
	if (((sprite_color == 4'd0) || (sprite_color == 4'd9)) && ((DrawX >= 270) && (DrawX <= 369)) && ((DrawY >= 135) && (DrawY <= 333))) begin
		decided_color = board[((DrawY-135)/9)][((DrawX-270)/9)];
	end
	else begin
		decided_color = sprite_color;
	end
end

endmodule
