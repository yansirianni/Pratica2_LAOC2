module register_IF_ID(clock,reset,instruction,instructionPropagation, opA, opB);

  	input clock, reset;
	input [19:0] instruction;
	
	output reg [19:0] instructionPropagation;
	output reg [3:0] opA, opB;

	always @(posedge clock)
	begin
		if (reset) begin
			//instructionPropagation <= 20'b0;
		end else begin
			instructionPropagation <= instruction;
			opA <= instruction[11:8];
			opB <= instruction[7:4];
		end
	end
endmodule