module instructionExecute(instruction,control,opA,opB,result,ulaZero,instructionPropagation);
  
	input	[1:0] control;
	input [19:0] instruction;
	input	[19:0] opA;// opB; //Seguindo o design do figma, sem sign extensor. ULA recebe direto o rfReadData2, sem mux para opB.
	input [19:0] opB; // sa�da "Read data 2" do banco de registradores.
	output [19:0] instructionPropagation;

	output [19:0] result;
	output ulaZero;
    
	ula ex_ula(control,opA,opB,result,ulaZero);

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

  //==================================================
    //                    Testbench
    //==================================================

/*
module instructionExecute_testbench;
	//reg clock,reset;
	reg [19:0] opA;
	reg [19:0] opB;
	reg [1:0] control;
	wire [19:0] result;
	wire ulaZero;
	
   parameter timeDelay = 100;
   
	 ula ex_ula_test(control,opA,opB,result,ulaZero);
	 initial begin
	   opA = 0 ; opB = 0 ; control = 0 ;
  /*	
	**	clock = 0; reset = 0;
	**  forever begin
	**	  #50 clock = ~clock;
	**	 end
  
	end 
	initial begin
		#(timeDelay) control = 2'b00; //Testando "soma" - Resposta Esperada: result = 20'b00000000000000000010(20'd2) // aluZero = 1'b1(true);
		 opA = 20'b00000000000000000001; opB = 20'b00000000000000000001;
		 
		#(timeDelay) control = 2'b01; //Testando "or" - Resposta Esperada: result = 20'b11111111110000000011(20'd65.283) // aluZero = 1'b0(false);
		 opA = 20'b11111111110000000000; opB = 20'b00000000000000000011;
		 
		#(timeDelay) control = 2'b10; //Testando "and" - Resposta Esperada: result = 20'b00000000000000000101(20'd5) // aluZero = 1'b0(false);
		 opA = 20'b0000001000000101; opB = 20'b00000000000000001111;
		 
		#(timeDelay) control = 2'b11; //Testando "not" - Resposta Esperada: result = 20'b00000000001111111111(20'd255) // aluZero = 1'b0(false);
		 opA = 20'b11111111110000000000; opB = 16'b0; 
	end 
	*/