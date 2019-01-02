//chooses what color for pixel is output
//uses color palette
module colors(input [3:0] decided_color,
				  input [9:0] DrawX,
				  output [7:0] Red, Green, Blue
				  );
				  
//total # colors being used: 12
//need 4-bit select signal (color_sel)
//cyan, blue, orange, yellow, green, purple, red, black, white, grey, gradient, transparent

 always_comb begin
	case (decided_color)
		4'd0 :	//black (board color)
		begin	
			Red = 8'h18;
			Green = 8'h18;
			Blue = 8'h18;
		end
		
		4'd1 :	//cyan
		begin	
			Red = 8'h1e;
			Green = 8'hff;
			Blue = 8'hff;
		end
		
		4'd2 :	//yellow
		begin	
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'h38;
		end
		
		4'd3 :	//red
		begin	
			Red = 8'hff;
			Green = 8'h2c;
			Blue = 8'h60;
		end
		
		4'd4 :	//orange
		begin	
			Red = 8'hff;
			Green = 8'h82;
			Blue = 8'h38;
		end
		
		4'd5 :	//green
		begin	
			Red = 8'h60;
			Green = 8'hff;
			Blue = 8'h60;
		end
		
		4'd6 :	//blue
		begin	
			Red = 8'h3e;
			Green = 8'h80;
			Blue = 8'hff;
		end
		
		4'd7 :	//purple
		begin	
			Red = 8'ha5;
			Green = 8'h32;
			Blue = 8'ha5;
		end
		
		4'd8 :	//default is gradient (for background)
		begin	
			Red = 8'h5f - DrawX[9:3];
			Green = 8'h2f;
			Blue = 8'h4f;;
		end
		
		4'd9 :	//transparent; NOTE: CHANGE TO WHATEVER BOARD BACKGROUND COLOR IS
		begin	
			Red = 8'h18;
			Green = 8'h18;
			Blue = 8'h18;
		end
		
		4'd10 :	//grey (for grid lines)
		begin	
			Red = 8'hd3;
			Green = 8'hd3;
			Blue = 8'hd3;
		end
		
		default :	//white
		begin	
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'hff;
		end
		
	endcase
 end
endmodule
