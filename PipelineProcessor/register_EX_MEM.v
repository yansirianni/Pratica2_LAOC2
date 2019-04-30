module register_EX_MEM(
    input [3:0] opcode;
	 input [1:0] aluZERO ; //zero da ULA
	 input [15:0] aluRESULT ; //saida da ULA
	 input [15:0] read_data2 ; //saída 2 do bando de regs
	 
	 /** Verificar a saída da ula para as instruçoes de JUMP, 
	 * referenciada como ula "ADD" no diagrama do figma.
	 **/
	 
	 output [1:0] aluZEROout ;
	 output [15:0] aluRESULTout ;
	 output [15:0] dataRFOut2 ;
);

endmodule