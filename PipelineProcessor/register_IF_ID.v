module register_IF_ID(clock,reset,opcode,instruction,data_out,opcode_out);

  input clock, reset;
	input [3:0] opcode; //esta redundante de proposito para caso mude a estrutura do instruction
	input [19:0] instruction;
	
	output reg [19:0] data_out;
	output reg [3:0] opcode_out; //propagacao do opcode para ser usado pelo proximo bloco
	output [19:0] instructionPropagation;

	always @(posedge clock)
	begin
		if (reset) begin
			data_out <= 20'b0;
			opcode_out <= 4'b0;
		end else begin
			data_out <= instruction;
			opcode_out <= opcode;
		end
	end
	assign instructionPropagation = instruction;
endmodule