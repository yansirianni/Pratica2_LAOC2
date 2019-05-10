module instructionDecode_Control(clock,reset,instruction,WriteAddress,ReadAddressRF1,ReadAddressRF2);
  input clock;
  input reset;
  input [19:0] instruction;
  output reg [3:0] WriteAddress;
  output reg [3:0] ReadAddressRF1;
  output reg [3:0] ReadAddressRF2;

/*  always @(posedge clock)
  begin
    case(instruction[19:16])

      4'b1100:  // store
      begin

        ReadAddressRF1 <= instruction[15:12];
        ReadAddressRF2 <= instruction[11:8];     

      end

    default:
      begin

        ReadAddressRF1 <= instruction[11:8];
        ReadAddressRF2 <= instruction[7:4];

      end
    endcase
  end  
*/

    ReadAddressRF1 = ((instruction[19:16]==4'b1100) ? instruction[15:12] : instruction[11:8]); //Tratamento de ReadAdresses diferenciado para Store.
    ReadAddressRF2 = ((instruction[19:16]==4'b1100) ? instruction[11:8]  : instruction[7:4]);

endmodule
endmodule // instructionDecode_Control