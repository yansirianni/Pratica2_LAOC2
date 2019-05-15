module writeBack(instruction,aluRESULTout,memoryReadData,address,writeBackEnable,writeBackAddress_Out,writeBackData_Out);
  input [19:0] instruction;
  input [19:0] aluRESULTout;
  input [19:0] memoryReadData;
  input [19:0] address;
  output writeBackEnable;
  output [19:0] writeBackAddress_Out;
  output [19:0] writeBackData_Out;

  wire [3:0] opcode;
  assign opcode = instruction[19:16];

assign writeBackEnable = opcode == 4'b1100 ? 1'b0 : 1'b1;
assign writeBackData_Out = ((opcode == 4'b1111 || opcode == 4'b1101) ? memoryReadData : aluRESULTout);
assign writeBackAddress_Out = address;
    

endmodule