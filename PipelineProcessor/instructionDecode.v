module instructionDecode();

    case(instruction[19:16])

    4'b1101:  // load
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      writeEnableRegAddress <= 1'b1;
      controlMux <= 3'b001;  // Endereco de qual registrador em que esta' o endereco da memoria (00 ou 01)
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end
    4'b1100:  // store
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      ReadAddressRF1 <= instruction[15:12];
      ReadAddressRF2 <= instruction[11:8];

      writeEnableRegAddress <= 1'b1;
      controlMux <= 3'b000;  // seleciona o endereco da memoria onde o dado sera escrito  (00 ou 01)
      writeEnableRegDout <= 1'b0;


    end
    4'b1011:  // conditional copy
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end


    4'b1111:  // copy input
    begin
      incr_pc  <= 1'b1;
      writeEnableRegInstruction <= 1'b0;
      controlMux <= 3'b100;
      //ReadAddressRF2 <= 4'b1111;
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
  endcase
  
endmodule