module board(input Clk, Reset,
             input at_bottom, // from block motion
				 input choose_O, 
						 choose_I_horiz, choose_I_vert,
						 choose_Z_horiz, choose_Z_vert,
						 choose_S_horiz, choose_S_vert, 
						 choose_J_left, choose_J_up, choose_J_right, choose_J_down,
						 choose_L_left, choose_L_up, choose_L_right, choose_L_down,
						 choose_T_left, choose_T_up, choose_T_right, choose_T_down,
				 input [9:0] X_Pos, Y_Pos, //from block_motion
				 
				 output [15:0] score,
				 output [21:0][10:0][3:0] board //to color mapper
             );

always_ff @(posedge Clk) begin
	if (Reset) begin
		for (integer i = 0; i < 22; i = i + 1) begin
			for (integer j = 0; j < 11; j = j + 1) begin
				board[i][j] <= 4'd0;
			end
		end
		score <= 16'd0;
	end

	//check if block hit bottom of board
	else if (at_bottom) begin
		//paint O
		if (choose_O == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd2;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd2;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd2;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd2;
		end
		
		//paint I
		else if (choose_I_horiz == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd1;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd1;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+2] <= 4'd1;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+3] <= 4'd1;
		end
		else if (choose_I_vert == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd1;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd1;
			board[((Y_Pos-135)/9)+2][((X_Pos-270)/9)] <= 4'd1;
			board[((Y_Pos-135)/9)+3][((X_Pos-270)/9)] <= 4'd1;
		end
		
		//paint Z
		else if (choose_Z_horiz == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd3;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd3;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd3;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+2] <= 4'd3;
		end
		else if (choose_Z_vert == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd3;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd3;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd3;
			board[((Y_Pos-135)/9)+2][((X_Pos-270)/9)] <= 4'd3;
		end
		
		//paint S
		else if (choose_S_horiz == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd5;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+2] <= 4'd5;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd5;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd5;
		end
		else if (choose_S_vert == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd5;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd5;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd5;
			board[((Y_Pos-135)/9)+2][((X_Pos-270)/9)+1] <= 4'd5;
		end
		
		//paint J
		else if (choose_J_up == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd6;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd6;
			board[((Y_Pos-135)/9)+2][((X_Pos-270)/9)+1] <= 4'd6;
			board[((Y_Pos-135)/9)+2][((X_Pos-270)/9)] <= 4'd6;
		end
		else if (choose_J_down == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd6;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd6;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd6;
			board[((Y_Pos-135)/9)+2][((X_Pos-270)/9)] <= 4'd6;
		end
		else if (choose_J_left == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd6;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd6;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+2] <= 4'd6;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+2] <= 4'd6;
		end
		else if (choose_J_right == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd6;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd6;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd6;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+2] <= 4'd6;
		end
	
	//paint L
		else if (choose_L_up == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd4;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd4;
			board[((Y_Pos-135)/9)+2][((X_Pos-270)/9)] <= 4'd4;
			board[((Y_Pos-135)/9)+2][((X_Pos-270)/9)+1] <= 4'd4;
		end
		else if (choose_L_down == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd4;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd4;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd4;
			board[((Y_Pos-135)/9)+2][((X_Pos-270)/9)+1] <= 4'd4;
		end
		else if (choose_L_left == 1'b1) begin
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd4;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd4;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+2] <= 4'd4;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+2] <= 4'd4;
		end
		else if (choose_L_right == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd4;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd4;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+2] <= 4'd4;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd4;
		end
		
	//paint T
		else if (choose_T_up == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd7;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd7;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd7;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+2] <= 4'd7;
		end
		else if (choose_T_down == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd7;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd7;
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+2] <= 4'd7;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd7;
		end
		else if (choose_T_left == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)+1] <= 4'd7;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd7;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd7;
			board[((Y_Pos-135)/9)+2][((X_Pos-270)/9)+1] <= 4'd7;
		end
		else if (choose_T_right == 1'b1) begin
			board[((Y_Pos-135)/9)][((X_Pos-270)/9)] <= 4'd7;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)] <= 4'd7;
			board[((Y_Pos-135)/9)+2][((X_Pos-270)/9)] <= 4'd7;
			board[((Y_Pos-135)/9)+1][((X_Pos-270)/9)+1] <= 4'd7;
		end
	end
	
	//check if lines needs to be cleared, then shift rows down : NEED TO ADD MORE
	if ((board[21][0] != 4'd0) && (board[21][1] != 4'd0) && (board[21][2] != 4'd0) && (board[21][3] != 4'd0) &&
		 (board[21][4] != 4'd0) && (board[21][5] != 4'd0) && (board[21][6] != 4'd0) && (board[21][7] != 4'd0) &&
		 (board[21][8] != 4'd0) && (board[21][9] != 4'd0) && (board[21][10] != 4'd0)) 
		 begin
			 board[21] <= board[20];
			 board[20] <= board[19];
			 board[19] <= board[18];
			 board[18] <= board[17];
			 board[17] <= board[16];
			 board[16] <= board[15];
			 board[15] <= board[14];
			 board[14] <= board[13];
			 board[13] <= board[12];
			 board[12] <= board[11];
			 board[11] <= board[10];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
	else if ((board[20][0] != 4'd0) && (board[20][1] != 4'd0) && (board[20][2] != 4'd0) && (board[20][3] != 4'd0) &&
		 (board[20][4] != 4'd0) && (board[20][5] != 4'd0) && (board[20][6] != 4'd0) && (board[20][7] != 4'd0) &&
		 (board[20][8] != 4'd0) && (board[20][9] != 4'd0) && (board[20][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[19];
			 board[19] <= board[18];
			 board[18] <= board[17];
			 board[17] <= board[16];
			 board[16] <= board[15];
			 board[15] <= board[14];
			 board[14] <= board[13];
			 board[13] <= board[12];
			 board[12] <= board[11];
			 board[11] <= board[10];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
	else if ((board[19][0] != 4'd0) && (board[19][1] != 4'd0) && (board[19][2] != 4'd0) && (board[19][3] != 4'd0) &&
		 (board[19][4] != 4'd0) && (board[19][5] != 4'd0) && (board[19][6] != 4'd0) && (board[19][7] != 4'd0) &&
		 (board[19][8] != 4'd0) && (board[19][9] != 4'd0) && (board[19][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[18];
			 board[18] <= board[17];
			 board[17] <= board[16];
			 board[16] <= board[15];
			 board[15] <= board[14];
			 board[14] <= board[13];
			 board[13] <= board[12];
			 board[12] <= board[11];
			 board[11] <= board[10];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
	
	else if ((board[18][0] != 4'd0) && (board[18][1] != 4'd0) && (board[18][2] != 4'd0) && (board[18][3] != 4'd0) &&
		 (board[18][4] != 4'd0) && (board[18][5] != 4'd0) && (board[18][6] != 4'd0) && (board[18][7] != 4'd0) &&
		 (board[18][8] != 4'd0) && (board[18][9] != 4'd0) && (board[18][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[17];
			 board[17] <= board[16];
			 board[16] <= board[15];
			 board[15] <= board[14];
			 board[14] <= board[13];
			 board[13] <= board[12];
			 board[12] <= board[11];
			 board[11] <= board[10];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
	
	else if ((board[17][0] != 4'd0) && (board[17][1] != 4'd0) && (board[17][2] != 4'd0) && (board[17][3] != 4'd0) &&
		 (board[17][4] != 4'd0) && (board[17][5] != 4'd0) && (board[17][6] != 4'd0) && (board[17][7] != 4'd0) &&
		 (board[17][8] != 4'd0) && (board[17][9] != 4'd0) && (board[17][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[16];
			 board[16] <= board[15];
			 board[15] <= board[14];
			 board[14] <= board[13];
			 board[13] <= board[12];
			 board[12] <= board[11];
			 board[11] <= board[10];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
		 else if ((board[16][0] != 4'd0) && (board[16][1] != 4'd0) && (board[16][2] != 4'd0) && (board[16][3] != 4'd0) &&
		 (board[16][4] != 4'd0) && (board[16][5] != 4'd0) && (board[16][6] != 4'd0) && (board[16][7] != 4'd0) &&
		 (board[16][8] != 4'd0) && (board[16][9] != 4'd0) && (board[16][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[17];
			 board[16] <= board[15];
			 board[15] <= board[14];
			 board[14] <= board[13];
			 board[13] <= board[12];
			 board[12] <= board[11];
			 board[11] <= board[10];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		
		else if ((board[15][0] != 4'd0) && (board[15][1] != 4'd0) && (board[15][2] != 4'd0) && (board[15][3] != 4'd0) &&
		 (board[15][4] != 4'd0) && (board[15][5] != 4'd0) && (board[15][6] != 4'd0) && (board[15][7] != 4'd0) &&
		 (board[15][8] != 4'd0) && (board[15][9] != 4'd0) && (board[15][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[17];
			 board[16] <= board[16];
			 board[15] <= board[14];
			 board[14] <= board[13];
			 board[13] <= board[12];
			 board[12] <= board[11];
			 board[11] <= board[10];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
		 else if ((board[14][0] != 4'd0) && (board[14][1] != 4'd0) && (board[14][2] != 4'd0) && (board[14][3] != 4'd0) &&
		 (board[14][4] != 4'd0) && (board[14][5] != 4'd0) && (board[14][6] != 4'd0) && (board[14][7] != 4'd0) &&
		 (board[14][8] != 4'd0) && (board[14][9] != 4'd0) && (board[14][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[17];
			 board[16] <= board[16];
			 board[15] <= board[15];
			 board[14] <= board[13];
			 board[13] <= board[12];
			 board[12] <= board[11];
			 board[11] <= board[10];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
		 else if ((board[13][0] != 4'd0) && (board[13][1] != 4'd0) && (board[13][2] != 4'd0) && (board[13][3] != 4'd0) &&
		 (board[13][4] != 4'd0) && (board[13][5] != 4'd0) && (board[13][6] != 4'd0) && (board[13][7] != 4'd0) &&
		 (board[13][8] != 4'd0) && (board[13][9] != 4'd0) && (board[13][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[17];
			 board[16] <= board[16];
			 board[15] <= board[15];
			 board[14] <= board[14];
			 board[13] <= board[12];
			 board[12] <= board[11];
			 board[11] <= board[10];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
		 else if ((board[12][0] != 4'd0) && (board[12][1] != 4'd0) && (board[12][2] != 4'd0) && (board[12][3] != 4'd0) &&
		 (board[12][4] != 4'd0) && (board[12][5] != 4'd0) && (board[12][6] != 4'd0) && (board[12][7] != 4'd0) &&
		 (board[12][8] != 4'd0) && (board[12][9] != 4'd0) && (board[12][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[17];
			 board[16] <= board[16];
			 board[15] <= board[15];
			 board[14] <= board[14];
			 board[13] <= board[13];
			 board[12] <= board[11];
			 board[11] <= board[10];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
		 else if ((board[11][0] != 4'd0) && (board[11][1] != 4'd0) && (board[11][2] != 4'd0) && (board[11][3] != 4'd0) &&
		 (board[11][4] != 4'd0) && (board[11][5] != 4'd0) && (board[11][6] != 4'd0) && (board[11][7] != 4'd0) &&
		 (board[11][8] != 4'd0) && (board[11][9] != 4'd0) && (board[11][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[17];
			 board[16] <= board[16];
			 board[15] <= board[15];
			 board[14] <= board[14];
			 board[13] <= board[13];
			 board[12] <= board[12];
			 board[11] <= board[10];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
		 else if ((board[10][0] != 4'd0) && (board[10][1] != 4'd0) && (board[10][2] != 4'd0) && (board[10][3] != 4'd0) &&
		 (board[10][4] != 4'd0) && (board[10][5] != 4'd0) && (board[10][6] != 4'd0) && (board[10][7] != 4'd0) &&
		 (board[10][8] != 4'd0) && (board[10][9] != 4'd0) && (board[10][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[17];
			 board[16] <= board[16];
			 board[15] <= board[15];
			 board[14] <= board[14];
			 board[13] <= board[13];
			 board[12] <= board[12];
			 board[11] <= board[11];
			 board[10] <= board[9];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
		 else if ((board[9][0] != 4'd0) && (board[9][1] != 4'd0) && (board[9][2] != 4'd0) && (board[9][3] != 4'd0) &&
		 (board[9][4] != 4'd0) && (board[9][5] != 4'd0) && (board[9][6] != 4'd0) && (board[9][7] != 4'd0) &&
		 (board[9][8] != 4'd0) && (board[9][9] != 4'd0) && (board[9][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[17];
			 board[16] <= board[16];
			 board[15] <= board[15];
			 board[14] <= board[14];
			 board[13] <= board[13];
			 board[12] <= board[12];
			 board[11] <= board[11];
			 board[10] <= board[10];
			 board[9] <= board[8];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
		 else if ((board[8][0] != 4'd0) && (board[8][1] != 4'd0) && (board[8][2] != 4'd0) && (board[8][3] != 4'd0) &&
		 (board[8][4] != 4'd0) && (board[8][5] != 4'd0) && (board[8][6] != 4'd0) && (board[8][7] != 4'd0) &&
		 (board[8][8] != 4'd0) && (board[8][9] != 4'd0) && (board[8][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[17];
			 board[16] <= board[16];
			 board[15] <= board[15];
			 board[14] <= board[14];
			 board[13] <= board[13];
			 board[12] <= board[12];
			 board[11] <= board[11];
			 board[10] <= board[10];
			 board[9] <= board[9];
			 board[8] <= board[7];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
		 else if ((board[7][0] != 4'd0) && (board[7][1] != 4'd0) && (board[7][2] != 4'd0) && (board[7][3] != 4'd0) &&
		 (board[7][4] != 4'd0) && (board[7][5] != 4'd0) && (board[7][6] != 4'd0) && (board[7][7] != 4'd0) &&
		 (board[7][8] != 4'd0) && (board[7][9] != 4'd0) && (board[7][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[17];
			 board[16] <= board[16];
			 board[15] <= board[15];
			 board[14] <= board[14];
			 board[13] <= board[13];
			 board[12] <= board[12];
			 board[11] <= board[11];
			 board[10] <= board[10];
			 board[9] <= board[9];
			 board[8] <= board[8];
			 board[7] <= board[6];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
		 
		 else if ((board[6][0] != 4'd0) && (board[6][1] != 4'd0) && (board[6][2] != 4'd0) && (board[6][3] != 4'd0) &&
		 (board[6][4] != 4'd0) && (board[6][5] != 4'd0) && (board[6][6] != 4'd0) && (board[6][7] != 4'd0) &&
		 (board[6][8] != 4'd0) && (board[6][9] != 4'd0) && (board[6][10] != 4'd0)) 
		 begin
			 board[21] <= board[21];
			 board[20] <= board[20];
			 board[19] <= board[19];
			 board[18] <= board[18];
			 board[17] <= board[17];
			 board[16] <= board[16];
			 board[15] <= board[15];
			 board[14] <= board[14];
			 board[13] <= board[13];
			 board[12] <= board[12];
			 board[11] <= board[11];
			 board[10] <= board[10];
			 board[9] <= board[9];
			 board[8] <= board[8];
			 board[7] <= board[7];
			 board[6] <= board[5];
			 board[5] <= board[4];
			 board[4] <= board[3];
			 board[3] <= board[2];
			 board[2] <= board[1];
			 board[1] <= board[0];
			 board[0] <= 0;
			 
			 score <= score + 1;
		 end
	
	
end

endmodule

