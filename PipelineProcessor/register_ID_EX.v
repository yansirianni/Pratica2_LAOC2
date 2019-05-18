module register_ID_EX(clock,reset,instruction,read_data1,read_data2,dataRFOut1,dataRFOut2,instructionPropagation,opDestino);

  	input clock, reset;
  	input [19:0] instruction;
	input [19:0] read_data1;  //saída 1 do bando de regs
	input [19:0] read_data2;  //saída 2 do bando de regs
	
	output reg [19:0] dataRFOut1; 
	output reg [19:0] dataRFOut2;
	output reg [19:0] instructionPropagation;
	output reg [3:0] opDestino;
	
	always @(posedge clock) begin
		if (reset) begin
			dataRFOut1 <= 20'b0;
			dataRFOut2 <= 20'b0;
			//instructionPropagation <= 20'b0;
		end else begin
			dataRFOut1 <= read_data1;
			dataRFOut2 <= read_data2;
			instructionPropagation <= instruction;
			opDestino <= instruction[15:12];
		end
	end
endmodule