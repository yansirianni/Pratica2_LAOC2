module instructionDecode(
  input instruction[19:0];
  output ReadAddressRF1[3:0];
  output reg ReadAddressRF1[3:0];
);
always @(posedge Clock)
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

endmodule