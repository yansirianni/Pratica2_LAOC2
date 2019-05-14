module register_EX_MEM(clock,reset,instruction,aluZERO,aluRESULT,aluZEROout,aluRESULTout,instructionPropagation);

  	input clock, reset;
  	input [19:0] instruction;
	input aluZERO; //zero da ULA
	input [19:0] aluRESULT; //saida da ULA
	 
	 /** Verificar a saída da ula para as instruçoes de JUMP, 
	 * referenciada como ula "ADD" no diagrama do figma.
	 **/
	 
	output reg aluZEROout;
	output reg [19:0] aluRESULTout;
	output reg [19:0] instructionPropagation;


	always @(posedge clock) begin
		if (reset) begin
			aluZEROout <= 1'b0;
			aluRESULTout <= 20'b0;
			instructionPropagation <= 20'b0;
		end else begin
			aluZEROout <= aluZERO;
			aluRESULTout <= aluRESULT;
			instructionPropagation <= instruction;
		end
	end

endmodule