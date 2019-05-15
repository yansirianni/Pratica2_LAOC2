module instructionExecute_Control(instruction, alu_control_out);
    input [19:0] instruction;
    output [1:0] alu_control_out;

    wire [3:0] opcode;
    assign opcode = instruction[19:16];

    assign alu_control_out = (opcode == 4'b0 ? 2'b0 : ( opcode == 4'b0001 ? 2'b01 : ( opcode == 4'b0010 ? 2'b10 : ( opcode == 4'b0011 ? 2'b11 : 2'b0))));

endmodule // instructionExecute_Control