module writeBack(memoryReadData,address, muxControl, writeBackOut);
  input [19:0] memoryReadData;
  input [19:0] address;
  output [19:0] writeBackOut;
  //output [19:0] writeAdress;

assign writeBackOut = (muxControl) ? memoryReadData : address);
    

endmodule