module instructionExecute(control,opA,opB,rfReadData2,result,ulaZero);
  
    input	[1:0] control;
    input	[15:0]  opA, opB; //Seguindo o design do figma, sem sign extensor. ULA recebe direto o rfReadData2, sem mux para opB.
    input [15:0] rfReadData2; // saída "Read data 2" do banco de registradores.
    output	reg [15:0]  result;
    output reg [1:0] ulaZero;
    
ula ex_ula(control,opA,rfReadData2,result,ulaZero);

endmodule

module ula(control,opA,opB,result,ulaZero);
  
    input	[1:0] control;
    input	[15:0]  opA, opB;
    output	reg [15:0]  result;
    output reg [1:0] ulaZero;

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


module instructionExecute_testbench;
	//reg clock,reset;
	reg [15:0] opA;
	reg [15:0] opB;
	reg [1:0] control;
	wire [15:0] result;
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
  */
	end 
	initial begin
		#(timeDelay) control = 2'b00; //Testando "soma" - Resposta Esperada: result = 16'b0000000000000010(16'd2) // aluZero = 1'b1(true);
		 opA = 16'b0000000000000001; opB = 16'b0000000000000001;
		 
		#(timeDelay) control = 2'b01; //Testando "or" - Resposta Esperada: result = 16'1111111100000011(16'd65.283) // aluZero = 1'b0(false);
		 opA = 16'b1111111100000000; opB = 16'b0000000000000011;
		 
		#(timeDelay) control = 2'b10; //Testando "and" - Resposta Esperada: result = 16'16'b0000000000000101(16'd5) // aluZero = 1'b0(false);
		 opA = 16'b0000001000000101; opB = 16'b0000000000001111;
		 
		#(timeDelay) control = 2'b11; //Testando "not" - Resposta Esperada: result = 16'b0000000011111111(16'd255) // aluZero = 1'b0(false);
		 opA = 16'b1111111100000000; opB = 16'b0; 
	end 

endmodule // instructionExecute_testbench
