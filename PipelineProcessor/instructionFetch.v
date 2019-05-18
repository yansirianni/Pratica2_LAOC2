module instructionFetch(stall, clock,reset,jumpAddress,jumpEnable,Daddress);
	input stall, clock, reset;
	input [19:0] jumpAddress;
	input jumpEnable;
	output [19:0] Daddress;

  PC_reg19 pc1 (stall, (reset ? 20'b0 : jumpAddress), (reset | jumpEnable), 1'b1, clock, Daddress); //Por enquanto sem resolucao de hazards

endmodule

// Registrador do PC
module PC_reg19 (stall, R, L, incr_pc, Clock, Q);
	input [19:0] R;
	input L, incr_pc, Clock, stall;
	output reg [19:0] Q;

	initial
	begin
		Q <= 20'b0;
	end

	always @(posedge Clock)
	if (L)
		Q <= R;
	else
	begin
		if (stall)
			Q <= Q;

		if (incr_pc)
			Q <= Q + 1'b1;
	end
endmodule

/*
module programCounter (regPc,Data,RegWrite,incr_pc, clock);

input clock, incr_pc,RegWrite;
input [15:0] Data;
output [15:0] regPc;

PC_reg15 PC(Data, RegWrite, incr_pc, clock, regPc); 

endmodule
*/

  //==================================================
    //                    Testbench
    //==================================================
/*
module instructionFetch_testbench;
	reg clock,reset;
	reg [15:0] jumpAddress;
	reg jumpEnable;
	wire [15:0] Daddress;
	
   parameter timeDelay = 100;
   
	 PC_reg15 PC_test((reset ? 16'b0 : jumpAddress), (reset | jumpEnable), 1, clock, Daddress);
	 
	initial begin
		clock = 0; reset = 0; jumpEnable = 0; jumpAddress = 0;
		forever begin
		 #50 clock = ~clock;
		end 
	end 
	initial begin
		#(timeDelay) reset = 1;
		#(timeDelay) reset = 0;
		#(timeDelay) jumpEnable = 1; jumpAddress = 16'b0000111100011111;
		#50 jumpEnable = 0;
	end 
	
assign instruction = instructionPropagation;
endmodule // instructionFetch_testbench
*/