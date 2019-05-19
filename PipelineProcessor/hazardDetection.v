module HazardDetection(
    input reset,
    input[3:0] IF_ID_opcode, ID_EX_opcode, IF_ID_op1, IF_ID_op2, ID_EX_op1, ID_EX_op2,
    input[3:0] ID_EX_dest,
    input[3:0] EX_MEM_dest,
    output hasHazard,
    output IF_ID_Hold);

wire ex_hazard;

assign ex_hazard = ((IF_ID_opcode == 4'b0000) || (IF_ID_opcode == 4'b0001) || (IF_ID_opcode == 4'b000) || (IF_ID_opcode == 4'b0011)) ? 1'b1 : 1'b0; 

assign hasHazard = ex_hazard && (((ID_EX_dest == IF_ID_op1) || (ID_EX_dest == IF_ID_op2)) || ((EX_MEM_dest == IF_ID_op1) || (EX_MEM_dest == IF_ID_op2)));

assign IF_ID_Hold = hasHazard ? 1'b1 : 1'b0;

endmodule