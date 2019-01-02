module block_motion(input Clk, Reset, frame_clk,
                    input [9:0] DrawX, DrawY,       // Current pixel coordinates
						  input [7:0] keycode,
						  input keypress,
						  input [5:0] block_size_x, block_size_y,
						  input choose_O, 
								  choose_I_horiz, choose_I_vert,
								  choose_Z_horiz, choose_Z_vert,
								  choose_S_horiz, choose_S_vert, 
								  choose_J_left, choose_J_up, choose_J_right, choose_J_down,
								  choose_L_left, choose_L_up, choose_L_right, choose_L_down,
								  choose_T_left, choose_T_up, choose_T_right, choose_T_down,
						  input [21:0][10:0][3:0] board,
						  
						  output at_bottom,
						  output [9:0] X_Pos, Y_Pos		//goes to Color_Mapper to draw sprites
						 );	 
						 
	 //set game parameters
    parameter [9:0] block_X_start = 10'd297;  // Starting position on the X axis
    parameter [9:0] block_Y_start = 10'd135;  // Starting position on the Y axis
    parameter [9:0] X_Min = 10'd270;       // Leftmost point on the X axis
    parameter [9:0] X_Max = 10'd369;     // Rightmost point on the X axis
    parameter [9:0] Y_Min = 10'd135;       // Topmost point on the Y axis
    parameter [9:0] Y_Max = 10'd333;     // Bottommost point on the Y axis
    parameter [9:0] Step_Size = 10'd9;      // Step size on the X axis
    
    //declare registers/signals
	 logic [9:0] block_X_Pos, block_X_Motion, block_Y_Pos, block_Y_Motion;
    logic [9:0] block_X_Pos_in, block_X_Motion_in, block_Y_Pos_in, block_Y_Motion_in;
	 assign X_Pos = block_X_Pos;
	 assign Y_Pos = block_Y_Pos;
	 
	 logic fast_drop; 	//signal to indicate whether normal drop speed or fast drop speed
	 logic move_horiz;	//tells block to move one square left/right
	 
	 logic [15:0] counter_y_in, counter_y;	//used to add delay between drops
	 logic [15:0] counter_x_in, counter_x;	//used to add delay between movements

    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end

    always_ff @ (posedge Clk) begin
        if (Reset || at_bottom) begin
            block_X_Pos <= block_X_start;
            block_Y_Pos <= block_Y_start;
            block_X_Motion <= 10'd0;
            block_Y_Motion <= Step_Size;
				counter_y <= 16'd0;
				counter_x <= 16'd0;
        end
        else begin
            block_X_Pos <= block_X_Pos_in;
            block_Y_Pos <= block_Y_Pos_in;
            block_X_Motion <= block_X_Motion_in;
            block_Y_Motion <= block_Y_Motion_in;
				counter_y <= counter_y_in;
				counter_x <= counter_x_in;
        end
    end
    
    always_comb begin
        block_X_Pos_in = block_X_Pos;
        block_Y_Pos_in = block_Y_Pos;
        block_X_Motion_in = block_X_Motion;
        block_Y_Motion_in = block_Y_Motion;
		  counter_y_in = counter_y;
		  counter_x_in = counter_x;
		  
		  at_bottom = 1'b0;
		  fast_drop = 1'b0;
		  move_horiz = 1'b0;
		  
        if (frame_clk_rising_edge) begin
				//CHECK IF BLOCK REACHED BOTTOM
				if (block_Y_Motion == 10'd0) begin
					at_bottom = 1'b1;
				end
				
				//CHECK IF BLOCK LANDS ON ANOTHER BLOCK (Y DIRECTION)
				//check O
				if (choose_O == 1'b1) begin
					if ((board[((block_Y_Pos - 135)/9) + 2][((block_X_Pos - 270)/9)] != 4'd0) || 
						 (board[((block_Y_Pos - 135)/9) + 2][((block_X_Pos - 270)/9) + 1] != 4'd0))
						 begin
							at_bottom = 1'b1;
						 end
				end
				
				//check I
				else if (choose_I_horiz == 1'b1) begin
					if ((board[((block_Y_Pos - 135)/9) + 1][((block_X_Pos - 270)/9)] != 4'd0) || 
						 (board[((block_Y_Pos - 135)/9) + 1][((block_X_Pos - 270)/9) + 1] != 4'd0) || 
						 (board[((block_Y_Pos - 135)/9) + 1][((block_X_Pos - 270)/9) + 2] != 4'd0) || 
						 (board[((block_Y_Pos - 135)/9) + 1][((block_X_Pos - 270)/9) + 3] != 4'd0)) 
						 begin
							at_bottom = 1'b1;
						 end
				end
				else if (choose_I_vert == 1'b1) begin
					if ((board[((block_Y_Pos - 135)/9) + 4][((block_X_Pos - 270)/9)] != 4'd0)) 
						begin
							at_bottom = 1'b1;
						end
				end
				
				//check Z
				else if (choose_Z_horiz == 1'b1) begin
					if ((board[((block_Y_Pos - 135)/9) + 1][((block_X_Pos - 270)/9)] != 4'd0) || 
						 (board[((block_Y_Pos - 135)/9) + 2][((block_X_Pos - 270)/9) + 1] != 4'd0) || 
						 (board[((block_Y_Pos - 135)/9) + 2][((block_X_Pos - 270)/9) + 2] != 4'd0)) 
						 begin
							at_bottom = 1'b1;
						 end
				end
				else if (choose_Z_vert == 1'b1) begin
					if ((board[((block_Y_Pos - 135)/9) + 3][((block_X_Pos - 270)/9)] != 4'd0) ||
						 (board[((block_Y_Pos - 135)/9) + 2][((block_X_Pos - 270)/9)+1] != 4'd0)) 
						begin
							at_bottom = 1'b1;
						end
				end
				
				//check S
				else if (choose_S_horiz == 1'b1) begin
					if ((board[((block_Y_Pos - 135)/9) + 2][((block_X_Pos - 270)/9)] != 4'd0) || 
						 (board[((block_Y_Pos - 135)/9) + 2][((block_X_Pos - 270)/9) + 1] != 4'd0) || 
						 (board[((block_Y_Pos - 135)/9) + 1][((block_X_Pos - 270)/9) + 2] != 4'd0)) 
						 begin
							at_bottom = 1'b1;
						 end
				end
				else if (choose_S_vert == 1'b1) begin
					if ((board[((block_Y_Pos - 135)/9) + 2][((block_X_Pos - 270)/9)] != 4'd0) ||
						 (board[((block_Y_Pos - 135)/9) + 3][((block_X_Pos - 270)/9)+1] != 4'd0)) 
						begin
							at_bottom = 1'b1;
						end
				end
				
				//check J
				else if(choose_J_up == 1'b1) begin
					if ((board[((block_Y_Pos - 135)/9)+3][((block_X_Pos - 270)/9)] != 4'd0) || 
						 (board[((block_Y_Pos - 135)/9)+3][((block_X_Pos - 270)/9)+1] != 4'd0)) 
						 begin
							 at_bottom = 1'b1;
						 end
				end
				else if(choose_J_down == 1'b1) begin
					if((board[((block_Y_Pos - 135)/9)+3][((block_X_Pos - 270)/9)] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+1][((block_X_Pos - 270)/9)+1] != 4'd0)) 
						begin
							 at_bottom = 1'b1;
						end
				end
				else if(choose_J_left == 1'b1) begin
					if((board[((block_Y_Pos - 135)/9)+1][((block_X_Pos - 270)/9)] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+1][((block_X_Pos - 270)/9)+1] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)+2] != 4'd0)) 
						begin 
							at_bottom = 1'b1;
						end
				end
				else if(choose_J_right == 1'b1) begin
					if((board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)+1] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)+2] != 4'd0)) 
						begin
							 at_bottom = 1'b1;
						end
				end
				
				//check L
				else if(choose_L_up == 1'b1) begin
					if ((board[((block_Y_Pos - 135)/9)+3][((block_X_Pos - 270)/9)] != 4'd0) || 
						 (board[((block_Y_Pos - 135)/9)+3][((block_X_Pos - 270)/9)+1] != 4'd0)) 
						 begin
							 at_bottom = 1'b1;
						 end
				end
				else if(choose_L_down == 1'b1) begin
					if((board[((block_Y_Pos - 135)/9)+3][((block_X_Pos - 270)/9)+1] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+1][((block_X_Pos - 270)/9)] != 4'd0)) 
						begin
							 at_bottom = 1'b1;
						end
				end
				else if(choose_L_left == 1'b1) begin
					if((board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)+1] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)+2] != 4'd0)) 
						begin 
							at_bottom = 1'b1;
						end
				end
				else if(choose_L_right == 1'b1) begin
					if((board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+1][((block_X_Pos - 270)/9)+1] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+1][((block_X_Pos - 270)/9)+2] != 4'd0)) 
						begin
							 at_bottom = 1'b1;
						end
				end
				
				//check T
				else if(choose_T_up == 1'b1) begin
					if ((board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)] != 4'd0) || 
						 (board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)+1] != 4'd0) ||
						 (board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)+2] != 4'd0)) 
						 begin
							 at_bottom = 1'b1;
						 end
				end
				else if(choose_T_down == 1'b1) begin
					if((board[((block_Y_Pos - 135)/9)+1][((block_X_Pos - 270)/9)] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)+1] != 4'd0) ||
						(board[((block_Y_Pos - 135)/9)+1][((block_X_Pos - 270)/9)+2] != 4'd0)) 
						begin
							 at_bottom = 1'b1;
						end
				end
				else if(choose_T_left == 1'b1) begin
					if((board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+3][((block_X_Pos - 270)/9)+1] != 4'd0)) 
						begin 
							at_bottom = 1'b1;
						end
				end
				else if(choose_T_right == 1'b1) begin
					if((board[((block_Y_Pos - 135)/9)+3][((block_X_Pos - 270)/9)] != 4'd0) || 
						(board[((block_Y_Pos - 135)/9)+2][((block_X_Pos - 270)/9)+1] != 4'd0)) 
						begin
							 at_bottom = 1'b1;
						end
				end
				
				// CHECK FOR KEYPRESS; CHECK IF BLOCK RUNS INTO ANOTHER BLOCK (X DIRECTION)
				if (keypress == 1'b1) begin
					unique case (keycode)
						8'h1C : //LEFT (A)
						begin
							if ((block_X_Pos > X_Min) && (move_horiz == 1'b0)) begin
								move_horiz = 1'b1;
								//check O
								if (choose_O == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0))
										block_X_Motion_in = 10'd0;	
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								
								//check I
								else if (choose_I_horiz == 1'b1) begin
									if (board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0)
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_I_vert == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+3][((block_X_Pos-270)/9)-1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);  // 2's complement.  
								end
								
								//check Z
								else if (choose_Z_horiz == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_Z_vert == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)-1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);  // 2's complement.  
								end
								
								//check S
								else if (choose_S_horiz == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_S_vert == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);  // 2's complement.  
								end
								
								//check J
								else if (choose_J_left == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_J_right == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_J_up == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)-1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_J_down == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)-1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								
								//check L
								else if (choose_L_left == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_L_right == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_L_up == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)-1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_L_down == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								
								//check T
								else if (choose_T_left == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_T_right == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)-1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_T_up == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)-1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								else if (choose_T_down == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)-1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = (~(Step_Size) + 1'b1);
								end
								
							end
						end
					
						8'h23 : //RIGHT (D)
						begin
							if (((block_X_Pos + block_size_x) < X_Max) && (move_horiz == 1'b0)) begin
								move_horiz = 1'b1;
								//check O
								if (choose_O == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+2] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								
								//check I
								else if (choose_I_horiz == 1'b1) begin
									if (board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+4] > 4'd0)
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_I_vert == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+1] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)+1] > 4'd0) || (board[((block_Y_Pos-135)/9)+3][((block_X_Pos-270)/9)+1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								
								//check Z
								else if (choose_Z_horiz == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+3] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_Z_vert == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)+1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								
								//check S
								else if (choose_S_horiz == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+3] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+2] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_S_vert == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)+2] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								
								//check J
								else if (choose_J_left == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+3] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+3] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_J_right == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+3] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_J_up == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)+2] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_J_down == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+1] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)+1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								
								//check L
								else if (choose_L_left == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+3] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+3] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_L_right == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+3] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_L_up == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+1] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)+2] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_L_down == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)+2] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								
								//check T
								else if (choose_T_left == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)+2] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_T_right == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+1] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+2][((block_X_Pos-270)/9)+1] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_T_up == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+2] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+3] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
								else if (choose_T_down == 1'b1) begin
									if ((board[((block_Y_Pos-135)/9)][((block_X_Pos-270)/9)+3] > 4'd0) || (board[((block_Y_Pos-135)/9)+1][((block_X_Pos-270)/9)+2] > 4'd0))
										block_X_Motion_in = 10'd0;
									else
										block_X_Motion_in = Step_Size;
								end
							
							end
						end
						
						8'h1b : //DOWN (S)
						begin
							block_Y_Motion_in = Step_Size;
							fast_drop = 1'b1;
						end
						
						default :	//default case
						begin
						end
						
					endcase
				 end
				 
				//CHECK IF BEYOND X BOUNDARY
				if(((block_X_Pos + block_size_x) >= X_Max) && (move_horiz == 1'b0)) begin // check right edge - stop in x direction; don't clear y direction
					block_X_Motion_in = 10'd0;
					move_horiz = 1'b1;
				end	
				else if ((block_X_Pos <= X_Min) && (move_horiz == 1'b0)) begin // check left edge - stop in x direction; don't clear y direction
					block_X_Motion_in = 10'd0;
					move_horiz = 1'b1;
				end
				
				//CHECK IF BEYOND Y BOUNDARY
				if((block_Y_Pos + block_size_y) >= Y_Max) begin // check bottom edge - stop in both x and y direction
					block_X_Motion_in = 10'd0;
					block_Y_Motion_in = 10'd0;
				end
				else if (block_Y_Pos <= Y_Min) begin // check top edge - move by step size in y direction every 1 sec; don't clear x direction
					block_Y_Motion_in = Step_Size;
				end
				
            //UPDATE X BLOCK POSITION
				if ((counter_x_in == 16'd6) && (move_horiz == 1'b1)) begin
					block_X_Pos_in = block_X_Pos + block_X_Motion;
					counter_x_in = 16'd0;
				end
				else if (move_horiz == 1'b1)
					counter_x_in = counter_x + 1;

				//UPDATE Y BLOCK POSITION
				counter_y_in = counter_y + 1;	
				if (counter_y_in == 16'd50) begin	//normal drop
						block_Y_Pos_in = block_Y_Pos + block_Y_Motion;
						counter_y_in = 16'd0;
				end
				else if ((fast_drop == 1'b1) && (counter_y_in == 16'd5)) begin	//fast drop
						block_Y_Pos_in = block_Y_Pos + block_Y_Motion;
						counter_y_in = 16'd0;
				end
		 end	
    end
endmodule
