module instructionDecode(instruction,clock,reset,ReadAddressRF1,ReadAddressRF2,instructionPropagation);
  input clock;
  input reset;
  input [19:0] instruction;
  output [3:0] ReadAddressRF1;
  output [3:0] ReadAddressRF2;
  output [19:0] instructionPropagation;

    //Verifica se o OPcode é 1100, (STORE) e faz atribuições.
    
   assign ReadAddressRF1 = ((instruction[19:16]==4'b1100) ? instruction[15:12] : instruction[11:8]); //Tratamento de ReadAdresses diferenciado para Store.
   assign ReadAddressRF2 = ((instruction[19:16]==4'b1100) ? instruction[11:8]  : instruction[7:4]);
   
   assign instructionPropagation = instruction;
endmodule

//==================================================
    //                    Testbench
    //==================================================


module instructionDecode_testbench;
  reg clock, reset;
  reg [19:0] instruction;
  wire [3:0] ReadAddressRF1;
  wire [3:0] ReadAddressRF2;
  wire [19:0] instructionPropagation;
   parameter timeDelay = 100;
	 instructionDecode instructionDecode_test(instruction,clock,reset,ReadAddressRF1,ReadAddressRF2,instructionPropagation);
	 initial begin //RESETING EVERYTHING
	   instruction = 0 ; ReadAddressRF1 = 0 ; ReadAddressRF2 = 0 ; instructionPropagation = 0 ;
		  clock = 0; reset = 0;
      forever begin
		    #50 clock = ~clock;
		  end
	  end 
	initial begin
  //STORE DO DADO DO REGISTRADOR 1111 E PARA O REGISTRADOR 0000
  #(timeDelay) instruction = 20'b11000000111100000000; //Saídas esperadas: ReadAddressRF1 = 0000 ; ReadAddressRF2 = 1111
  //COPY ... WHATEVER...
  #(timeDelay) instruction = 20'b11100000111100000000; //Saídas esperadas: ReadAddressRF1 = 1111 ; ReadAddressRF2 = 0000
	end 
