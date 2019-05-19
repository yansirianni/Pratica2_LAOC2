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
		if (stall)
			Q <= Q;

		else if (incr_pc)
			Q <= Q + 1'b1;	
endmodule