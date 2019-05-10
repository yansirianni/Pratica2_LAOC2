module memoryAccess(instruction, address, out);
    input [19:0] address;
    output [19:0] out;
    output [19:0] instructionPropagation;

    assign out = address;
    
    assign instructionPropagation = instruction; 
endmodule