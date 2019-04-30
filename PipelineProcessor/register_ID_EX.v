module register_ID_EX(
    input [3:0] opcode;
	 input [31:0] extended_signal; //Extensor de sinal
	 input [15:0] read_data1;  //saída 1 do bando de regs
	 input [15:0] read_data2;  //saída 2 do bando de regs
	 output [15:0] dataRFOut1; 
	 output [15:0] dataRFOut2;
);
endmodule