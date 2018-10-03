//acts as sub-toplevel file; everything relating to data goes here;
//instantiate PC, Address_ALU, BUS_MUX, MAR, MDR, IR, reg_file, ALU, CC, and testbench modules
module datapath(input logic Clk, Reset,
					 input logic [15:0] S,
					 input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
					 input logic GatePC, GateMDR, GateALU, GateMARMUX,
					 input logic [1:0] PCMUX,
					 input logic [15:0] MDR_In;
					 
					 output logic [15:0] PC, MAR, MDR
					);
					
 logic [15:0] reg_bus; //contains 16-bit value going into CPU bus
 
 PC_module PC_mod(.Clk(Clk), .Reset(Reset), .S(S), .Load(LD_PC), .PCMUX, 
						.PC(PC));
						 
 MAR_module MAR_mod(.Clk(Clk), .Reset(Reset), .Load(LD_MAR), .reg_bus(reg_bus)
						  .MAR(MAR));
 
 MDR_module MDR_mod(.Clk(Clk), .Reset(Reset), .MDR_In(MDR_In), .Load(LD_MDR), 
 
 BUS_MUX BUS_mod(.GatePC, .GateMDR, .GateALU, .GateMARMUX,
				  .MAR_bus(), .MDR_bus(), .PC_bus(PC), .ALU_bus(),
				  .reg_bus(reg_bus));