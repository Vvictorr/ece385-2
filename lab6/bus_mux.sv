//FPGA does not support internal tristate buffer so need 5 to 1 MUX to select which signal drives the CPU bus
module BUS_MUX(input logic GatePC, GateMDR, GateALU, GateMARMUX,
					input logic [15:0] MAR_bus, MDR_bus, PC_bus, ALU_bus
				   output logic [15:0] reg_bus;
				  );
			
			
 logic [3:0] bus_sel = {GatePC, GateMDR, GateALU, GateMARMUX};
 
 always_comb begin //might need reg_bus = 0 default case
	 case (bus_sel)
		4'b0000 :		//default case when no gate signal is high
			begin
				reg_bus = 16'bXXXXXXXXXXXXXXXX; //CHECK WITH TA - high impedance
			end
		4'b0001 :		//gate signal MAR is high
			begin
				reg_bus = MAR_bus;
			end
		4'b0010 :		//gate signal ALU is high
			begin
				reg_bus = ALU_bus;
			end
		4'b0100 :		//gate signal MDR is high
			begin
				reg_bus = MDR_bus;
			end
		4'b1000 :		//gate signal PC is high
			begin
				reg_bus = PC_bus;
			end
	 endcase
 end
 
endmodule
