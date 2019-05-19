module instructionDecode_Control(clock,reset,instruction,WriteAddress,ReadAddressRF1,ReadAddressRF2);
  input clock;
  input reset;
  input [19:0] instruction;
  output reg [3:0] WriteAddress;
  output reg [3:0] ReadAddressRF1;
  output reg [3:0] ReadAddressRF2;

endmodule // instructionDecode_Control