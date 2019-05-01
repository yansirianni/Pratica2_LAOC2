
module pipelineProcessor (DataIn, Reset, Clock, Dout, Daddress, W);

input [19:0] DataIn;
input Reset, Clock;
output [19:0] Dout, Daddress;

output reg W;

//Estágio 1
instructionFetch IF(); //Carrega instruções da memória 

register_IF_ID IF_ID(); 

//Estágio 2
instructionDecode ID(); //Decodifica a instrução e lê os registradores 

register_ID_EX ID_EX();

//Estágio 3
instructionExecute EX(); //Executa o cálculo se necessário

register_EX_MEM EX_MEM();

//Estágio 4
memoryAccess MEM(); //Leitura ou escrita na memória 

register_MEM_WB MEM_WB();

//Estágio 5
writeBack WB(); //Escreve o resultado no banco de registradores

endmodule