module memoryAccess(instruction, address, writeData, writeEnable, writeEnable_Out, writeData_Out, address_Out, instructionPropagation);
    input [19:0] instruction;
    input [19:0] address;
    input [19:0] writeData;
    input writeEnable;

    output writeEnable_Out;
    output [19:0] writeData_Out;
    output [19:0] address_Out;
    output [19:0] instructionPropagation;
   
    assign address_Out = address;
    assign instructionPropagation = instruction;
    assign writeEnable_Out = writeEnable;
    assign writeData_Out = writeData;
endmodule