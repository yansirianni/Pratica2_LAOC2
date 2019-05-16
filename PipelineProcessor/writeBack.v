module writeBack(reset,instruction,dataRFOut1,dataRFOut2,aluRESULTout,memoryReadData,address,writeBackEnable,writeBackAddress_Out,writeBackData_Out);
  input reset;
  input [19:0] instruction;
  input [19:0] aluRESULTout, dataRFOut1, dataRFOut2;
  input [19:0] memoryReadData;
  input [3:0] address;
  output writeBackEnable;
  output [3:0] writeBackAddress_Out;
  output [19:0] writeBackData_Out;

  wire [3:0] opcode;
  assign opcode = instruction[19:16];

  assign writeBackEnable = (reset ? 1'b0 : ((opcode == 4'b1100 || (opcode == 4'b1011 && aluRESULTout != 20'b0)) ? 1'b0 : 1'b1));
  assign writeBackData_Out = (reset ? 20'b0 : ((opcode == 4'b1111 || opcode == 4'b1101) ? memoryReadData : (opcode == 4'b1110 ? dataRFOut1 : ((opcode == 4'b1011 && aluRESULTout == 20'b0) ? dataRFOut1 : (aluRESULTout)))));
  assign writeBackAddress_Out = (reset ? 4'b0 : (address));
    

endmodule