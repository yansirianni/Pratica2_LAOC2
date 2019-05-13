module memoryAccess(instruction, address, writeData, memOut, addressOut, instructionPropagation);
    input [19:0] address;
    input [19:0] instruction;
    input [19:0] writeData;
    output [19:0] memOut;
    output [19:0] addressOut;
    output [19:0] instructionPropagation; // ainda é necessário?


    //module memory_main (addr, data, wr_en, Clock, q);
    memory_main memory(address,writeData,writeEnable,clock,memOut);
    
    assign addressOut = address;
    assign instructionPropagation = instruction; 
endmodule