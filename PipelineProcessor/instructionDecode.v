module instructionDecode(clock,reset,instruction,WriteAddress,ReadAddressRF1,ReadAddressRF2);
  input clock;
  input reset;
  input [19:0] instruction;
  output reg [3:0] WriteAddress;
  output reg [3:0] ReadAddressRF1;
  output reg [3:0] ReadAddressRF2;

  always @(posedge clock)
  begin
    case(instruction[19:16])

      4'b1100:  // store
      begin

        ReadAddressRF1 <= instruction[15:12];
        ReadAddressRF2 <= instruction[11:8];     

      end
      
      

      4'b1101:  // load
      begin
        ReadAddressRF1 <= instruction[11:8];
        ReadAddressRF2 <= instruction[7:4];

      end
  
      4'b1011:  // conditional copy
      begin
        ReadAddressRF1 <= instruction[11:8];
        ReadAddressRF2 <= instruction[7:4];
      end


      4'b1111:  // copy input
      begin
        ReadAddressRF2 <= instruction[7:4];
        writeEnableRegAddress <= 1'b1;
        ReadAddressRF1 <= instruction[11:8];

      end

    4'b1110:  // copy
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end

    4'b0000: // sum
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b00;
      controlMux <= 3'b011;
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end

    4'b0001: // OR
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b01;
      controlMux <= 3'b011;
      ReadAddressRF1 <= instruction[11:8];
     ReadAddressRF2 <= instruction[7:4];

    end

    4'b0010: //AND
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b10;
      controlMux <= 3'b011;
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end

    4'b0011: // NOT
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b11;
      controlMux <= 3'b011;
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end
    default:
      begin

        ReadAddressRF1 <= instruction[11:8];
        ReadAddressRF2 <= instruction[7:4];
        
      end
  endcase
  end
  end

endmodule

