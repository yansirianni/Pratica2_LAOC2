module register_MEM_WB(clock,reset,instruction,aluRESULT,memory_read_data,aluRESULTout,memory_read_data_out,instructionPropagation);
	input [19:0] instruction;
	input clock, reset;
	input [19:0]aluRESULT;
	input [19:0] memory_read_data; //saída da memória
	output reg [19:0] aluRESULTout; //saída da ula
	output reg [19:0] memory_read_data_out;
	output reg [19:0] instructionPropagation;
	
	always @(posedge clock) begin
		if (reset) begin
			aluRESULTout <= 20'b0;
			memory_read_data_out <= 20'b0;
			instructionPropagation <= 20'b0;
		end else begin
			aluRESULTout <= aluRESULT;
			memory_read_data_out <= memory_read_data;
			instructionPropagation = instruction;
		end
	end

endmodule