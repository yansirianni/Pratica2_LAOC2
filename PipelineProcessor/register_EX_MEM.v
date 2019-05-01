module register_EX_MEM(clock,reset,opcode,aluZERO,aluRESULT,read_data2,aluZEROout,aluRESULTout,dataRFOut2,opcode_out);

  input clock, reset;
  input [3:0] opcode;
	input aluZERO; //zero da ULA
	input [15:0] aluRESULT; //saida da ULA
	input [15:0] read_data2; //saída 2 do banco de regs
	 
	 /** Verificar a saída da ula para as instruçoes de JUMP, 
	 * referenciada como ula "ADD" no diagrama do figma.
	 **/
	 
	output reg aluZEROout;
	output reg [15:0] aluRESULTout;
	output reg [15:0] dataRFOut2;
	output reg [3:0] opcode_out; //propagacao do opcode para ser usado pelo proximo bloco

	always @(posedge clock) begin
		if (reset) begin
			aluZEROout <= 1'b0;
			aluRESULTout <= 16'b0;
			dataRFOut2 <= 16'b0;
			opcode_out <= 4'b0;
		end else begin
			aluZEROout <= aluZERO;
			aluRESULTout <= aluRESULT;
			dataRFOut2 <= read_data2;
			opcode_out <= opcode;
		end
	end

endmodule