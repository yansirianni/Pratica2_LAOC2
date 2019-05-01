module register_ID_EX(
	input clock, reset;
    input [3:0] opcode;
	input [31:0] extended_signal; //Extensor de sinal
	input [15:0] read_data1;  //saída 1 do bando de regs
	input [15:0] read_data2;  //saída 2 do bando de regs
	output [15:0] dataRFOut1; 
	output [15:0] dataRFOut2;
	output [3:0] opcode_out; //propagacao do opcode para ser usado pelo proximo bloco
);

	always @(posedge clock) begin
		if (reset) begin
			dataRFOut1 <= 16'b0;
			dataRFOut2 <= 16'b0
			opcode_out <= 4'b0;
		end else begin
			dataRFOut1 <= read_data1;
			dataRFOut2 <= dataRFOut2;
			opcode_out <= opcode;
		end
	end
endmodule