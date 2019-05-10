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
