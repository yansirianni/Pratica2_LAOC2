module register_MEM_WB(
    input [3:0] opcode;
	 input [15:0]aluRESULT ;
	 input [19:0] memory_read_data; //saída da memória
	 output [15:0] aluRESULTout; //saída da ula
	 output [19:0] memory_read_data_out; 
);

endmodule