module register_EX_MEM(instruction,clock,reset,opcode,aluZERO,aluRESULT,read_data2,aluZEROout,aluRESULTout,dataRFOut2,opcode_out,instructionPropagation);

  input clock, reset;
  input [3:0] opcode;
  input [19:0] instruction;
	input aluZERO; //zero da ULA
	input [19:0] aluRESULT; //saida da ULA
	input [15:0] read_data2; //saída 2 do banco de regs
	 
	 /** Verificar a saída da ula para as instruçoes de JUMP, 
	 * referenciada como ula "ADD" no diagrama do figma.
	 **/
	 
	output reg aluZEROout;
	output reg [19:0] aluRESULTout;
	output reg [19:0] dataRFOut2;
	output reg [3:0] opcode_out; //propagacao do opcode para ser usado pelo proximo bloco
	output [19:0] instructionPropagation;
	always @(posedge clock) begin
		if (reset) begin
			aluZEROout <= 1'b0;
			aluRESULTout <= 20'b0;
			dataRFOut2 <= 20'b0;
			opcode_out <= 4'b0;
		end else begin
			aluZEROout <= aluZERO;
			aluRESULTout <= aluRESULT;
			dataRFOut2 <= read_data2;
			opcode_out <= opcode;
		end
	end
	
assign instructionPropagation = instruction;
endmodule