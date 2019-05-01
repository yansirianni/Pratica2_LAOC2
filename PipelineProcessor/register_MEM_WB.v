module register_MEM_WB(
	input clock, reset;
    input [3:0] opcode;
	input [15:0]aluRESULT ;
	input [19:0] memory_read_data; //saída da memória
	output [15:0] aluRESULTout; //saída da ula
	output [19:0] memory_read_data_out; 
);

	always @(posedge clock) begin
		if (reset) begin
			aluRESULTout <= 15'b0;
			memory_read_data_out <= 20'b0;
		end else begin
			aluRESULTout <= aluRESULT;
			memory_read_data_out <= memory_read_data;
		end
	end

endmodule