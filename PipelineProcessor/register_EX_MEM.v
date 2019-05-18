module register_EX_MEM(clock,reset,instruction,dataRFOut1,dataRFOut2,aluZERO,aluRESULT,aluZEROout,aluRESULTout,dataRFOut1_Out,dataRFOut2_Out,instructionPropagation, opDestino);

  	input clock, reset;
  	input [19:0] instruction, dataRFOut1, dataRFOut2;
	input aluZERO; //zero da ULA
	input [19:0] aluRESULT; //saida da ULA
	 
	 /** Verificar a saída da ula para as instruçoes de JUMP, 
	 * referenciada como ula "ADD" no diagrama do figma.
	 **/
	 
	output reg aluZEROout;
	output reg [19:0] aluRESULTout, dataRFOut1_Out, dataRFOut2_Out;
	output reg [19:0] instructionPropagation;
	output reg [3:0]  opDestino;


	always @(posedge clock) begin
		if (reset) begin
			aluZEROout <= 1'b0;
			aluRESULTout <= 20'b0;
			//instructionPropagation <= 20'b0;
		end else begin
			aluZEROout <= aluZERO;
			aluRESULTout <= aluRESULT;
			instructionPropagation <= instruction;
			dataRFOut1_Out <= dataRFOut1;
			dataRFOut2_Out <= dataRFOut2;
			opDestino <= instruction[15:12];
		end
	end

endmodule