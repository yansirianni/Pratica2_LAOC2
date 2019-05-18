/*
(((ID_EX_Rd == IF_ID_Rs || ID_EX_Rd == IF_ID_Rt) && (ID_EX_RegWrite == 1'b1)) || ((EX_MEM_Rd == IF_ID_Rs || EX_MEM_Rd == IF_ID_Rt) && (EX_MEM_RegWrite == 1'b1)))) begin
			PCWrite <= 1'b0;
			ID_EX_CtrlFlush <= 1'b1;
			IF_ID_Flush <= 1'b0;
			IF_ID_Hold <= 1'b1;
*/

module HazardDetection(
    input reset,
    input[3:0] IF_ID_op1, IF_ID_op2,
    input[3:0] ID_EX_dest,
    output hasHazard);

wire ex_hazard;

assign ex_hazard = (reset ? 1'b0 : (dest[19:16] == 4'b0)? ((op1 == dest[11:8]) || (op2 == dest[7:6])) : 1'b0);

assign hasHazard = ex_hazard;

endmodule