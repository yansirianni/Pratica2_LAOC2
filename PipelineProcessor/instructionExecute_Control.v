module instructionExecute_Control(opcode, alu_control_out);
    input [3:0] opcode,
    output [1:0] alu_control_out;

    assign alu_control_out = (opcode == 4'b0 ? 2'b0 : ( opcode == 4'b0001 ? 2'b01 : ( opcode == 4'b0010 ? 2'b10 : ( opcode == 4'b0011 ? 2'b11))));

endmodule // instructionExecute_Control