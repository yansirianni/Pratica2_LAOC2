
module pipelineProcessor (DataIn, Reset, Clock, Dout, Daddress, W);

input [19:0] DataIn;
input Reset, Clock;
output [19:0] Dout, Daddress;

output reg W;

instructionFetch IF(); //Estágio 1

register_IF_ID IF_ID(); 

instructionDecode ID(); //Estágio 2

register_ID_EX ID_EX();

instructionExecute EX(); //Estágio 3

register_EX_MEM EX_MEM();

memoryAccess MEM(); //Estágio 4

register_MEM_WB MEM_WB();

writeBack WB(); //Estágio 5

endmodule
