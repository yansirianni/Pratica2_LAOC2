module memoryAccess_Control(instruction, writeEnable_Out);

    input [19:0] instruction;
    out writeEnable_Out;

    assign writeEnable_Out = instruction[19:16] == 4'b1100 ? 1 : 0; //If instruction is STORE set 1 in writeEnable_Out
endmodule // memoryAccess_Control