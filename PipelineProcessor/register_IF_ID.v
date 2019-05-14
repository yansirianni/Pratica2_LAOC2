module register_IF_ID(clock,reset,instruction,instructionPropagation);

  	input clock, reset;
	input [19:0] instruction;
	
	output reg [19:0] instructionPropagation;

	always @(posedge clock)
	begin
		if (reset) begin
			instructionPropagation <= 20'b0;
		end else begin
			opcode_out <= opcode;
		end
	end
endmodule