module instructionDecode(
  input clock;
  input reset;
  input [19:0] instruction;
  input [15:0] writeData; //saída do writeBack
  output [3:0] ReadAddressRF1;
  output reg [3:0] ReadAddressRF1;
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

registerFile rf(ReadAddressRF1, ReadAddressRF2, instruction[15:12], DataOutMux[15:0], writeEnableRegisterFile, dataRFOut1, dataRFOut2, Clock, incr_pc);

endmodule

module registerFile (Read1,Read2,WriteReg,WriteData,RegWrite,Data1,Data2,clock, incr_pc);
input [3:0] Read1,Read2,WriteReg;
input [15:0] WriteData;
input RegWrite, clock, incr_pc;
output [15:0] Data1, Data2;

wire [15:0] decOut;
wire [15:0] register [15:0];

decoder dec1(WriteReg, decOut); 

//Modificado para 16 bits

register16bits register1(WriteData, decOut[0]& RegWrite , clock, register[0]);
register16bits register2(WriteData, decOut[1]& RegWrite , clock, register[1]);
register16bits register3(WriteData, decOut[2]& RegWrite , clock, register[2]);
register16bits register4(WriteData, decOut[3]& RegWrite , clock, register[3]);
register16bits register5(WriteData, decOut[4]& RegWrite , clock, register[4]);
register16bits register6(WriteData, decOut[5]& RegWrite , clock, register[5]);
register16bits register7(WriteData, decOut[6]& RegWrite , clock, register[6]);
register16bits register8(WriteData, decOut[7]& RegWrite , clock, register[7]);
register16bits register9(WriteData, decOut[8]& RegWrite , clock, register[8]);
register16bits register10(WriteData, decOut[9]& RegWrite , clock, register[9]);
register16bits register11(WriteData, decOut[10]& RegWrite , clock, register[10]);
register16bits register12(WriteData, decOut[11]& RegWrite , clock, register[11]);
register16bits register13(WriteData, decOut[12]& RegWrite , clock, register[12]);
register16bits register14(WriteData, decOut[13]& RegWrite , clock, register[13]);
register16bits register15(WriteData, decOut[14]& RegWrite , clock, register[14]);
register16bits register16(WriteData, decOut[15]& RegWrite , clock, register[15]);

assign Data1 = register[Read1];
assign Data2 = register[Read2];

endmodule

module decoder #(parameter N = 4) (input [N-1:0] DataIn, output reg [(1<<N)-1:0] DataOut);
    always @ (DataIn)
     begin
       DataOut <= 1 << DataIn;
     end
endmodule