module memoryAccess_Control(instruction, writeEnable_Out, address_Control_Out);

    input [19:0] instruction;
    output writeEnable_Out;
    output [1:0] address_Control_Out;

    assign writeEnable_Out = instruction[19:16] == 4'b1100 ? 1'b1 : 1'b0; //If instruction is STORE set 1 in writeEnable_Out
    assign address_Control_Out = instruction[19:16] == 4'b1111 ? 2'b01 : (instruction[19:16] == 4'b1100 ? 2'b10 : (2'b0)); //If instruction is COPY INPUT set 1 in address_Control_Out

endmodule // memoryAccess_Control