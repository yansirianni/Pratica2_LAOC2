module instructionFetch(clock,reset,jumpAddress,jumpEnable,Daddress);
	input clock, reset;
	input [15:0] jumpAddress;
	input jumpEnable;
	output [15:0] Daddress;

  PC_reg15 pc1 ((reset ? 16'b0 : jumpAddress), (reset | jumpEnable), 1, clock, Daddress); //Por enquanto sem resolucao de hazards

endmodule

// Registrador do PC
module PC_reg15 (R, L, incr_pc, Clock, Q);
input [15:0] R;
input L, incr_pc, Clock;
output reg [15:0] Q;

initial
begin
  Q <= 16'b0;
end

always @(posedge Clock)
if (L)
	Q <= R;
else
	if (incr_pc)
		Q <= Q + 1'b1;
endmodule

/*
module instructionFetch_testbench(
	reg clock,reset;
	reg [15:0] jumpAddress;
	reg jumpEnable;
	reg [15:0] Daddress;
);

	parameter timeps = 50;

endmodule // instructionFetch_testbench
*/
/*
module programCounter (regPc,Data,RegWrite,incr_pc, clock);

input clock, incr_pc,RegWrite;
input [15:0] Data;
output [15:0] regPc;

PC_reg15 PC(Data, RegWrite, incr_pc, clock, regPc); 

endmodule
*/