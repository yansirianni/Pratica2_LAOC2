module writeBack(memoryReadData,ulaResult, muxControl, writeBackOut);
  input [19:0] memoryReadData;
  input [19:0] ulaResult;
  output [19:0] writeBackOut;
  //output [19:0] writeAdress;

assign writeBackOut = (muxControl) ? memoryReadData : ulaResult);
    

endmodule