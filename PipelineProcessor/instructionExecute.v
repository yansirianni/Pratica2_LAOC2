module instructionExecute(instruction,control,opA,opB,result,ulaZero,dataRFOut1,dataRFOut2,instructionPropagation);
  
	input	[1:0] control;
	input [19:0] instruction;
	input	[19:0] opA;// opB; //Seguindo o design do figma, sem sign extensor. ULA recebe direto o rfReadData2, sem mux para opB.
	input [19:0] opB; // sa�da "Read data 2" do banco de registradores.
	output [19:0] dataRFOut1, dataRFOut2, instructionPropagation;

	output [19:0] result;
	output ulaZero;
    
	ula ex_ula(control,opA,opB,result,ulaZero);

	assign dataRFOut1 = opA;//Isso eh necessario para usar no store
	assign dataRFOut2 = opB;//Isso eh necessario para usar no store
	assign instructionPropagation = instruction;

endmodule

module ula(control,opA,opB,result,ulaZero);
  
	input	[1:0] control;
	input	[19:0] opA, opB;
	output reg [19:0] result;
	output reg ulaZero;

always @(opA, opB, control ) //ULA
begin
 	ulaZero <= (opA == opB);
	case (control)
	  2'b00: 		result <= opA + opB;
	  2'b01: 		result <= opA | opB;
	  2'b10: 		result <= opA & opB;
	  2'b11: 		result <= ~(opA);
	  endcase
end
endmodule