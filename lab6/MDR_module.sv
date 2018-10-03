//MDR takes in 16-bit DATA from SRAM (or switches)
module MDR_module(input logic Clk, Reset, Load,
						input logic [15:0] MDR_In,
						output logic [15:0] MDR
					  );
						 
 always_ff @(posedge Clk) begin
	if (Reset) begin
		MDR <= 16'd0;
	end
	else if (Load) begin
		MDR <= MDR_In;
	end 
 end

