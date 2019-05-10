module instructionDecode(clock,reset,instruction,ReadAddressRF1,ReadAddressRF2);
  input clock;
  input reset;
  input [19:0] instruction;
  output [3:0] ReadAddressRF1;
  output [3:0] ReadAddressRF2;

    //Verifica se o OPcode é 1100, (STORE) e faz atribuições.
    
   assign ReadAddressRF1 = ((instruction[19:16]==4'b1100) ? instruction[15:12] : instruction[11:8]); //Tratamento de ReadAdresses diferenciado para Store.
   assign ReadAddressRF2 = ((instruction[19:16]==4'b1100) ? instruction[11:8]  : instruction[7:4]);

endmodule
