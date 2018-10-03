//PC is 16-bit register that holds ADDRESS
module PC_module(input logic Clk, Reset, Load,
					  input logic [15:0] S, //ASK TA WHEN TO SET SWITCHES
					  input logic [1:0] PCMUX,
					  output logic [15:0] PC
					 );
					 
 logic [15:0] PC_next;

 always_ff @(posedge Clk) begin
	if (Reset) begin
		PC <= 16'd0;
	end
	else if (Load) begin
		PC <= PC_next;
	end 
 end
 
 always_comb begin //probably need to add default case PC_next = 0
	 case (PCMUX)		
		2'b00 :			//select PC + 1
			begin
				PC_next = PC + 1;
			end
		2'b01 :			//select value from bus (switches or SRAM)
			begin
				PC_next = S;
			end
		2'b10 :			//select output of address adder
			begin
				//fill in week 2
			end
	endcase
 end

endmodule 