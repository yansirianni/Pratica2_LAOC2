
module pipelineProcessor (DataIn, Reset, Clock, Dout, Daddress, W);

input [19:0] DataIn;
input Reset, Clock;
output [19:0] Dout, Daddress;

output reg W;

//==================================================
//                    Estágios
//==================================================

//Estágio 1
instructionFetch IF(); //Carrega instruções da memória 

//Estágio 2
instructionDecode ID(); //Decodifica a instrução e lê os registradores 

//Estágio 3
instructionExecute EX(); //Executa o cálculo se necessário

//Estágio 4
memoryAccess MEM(); //Leitura ou escrita na memória 

//Estágio 5
writeBack WB(); //Escreve o resultado no banco de registradores

//==================================================
//            Registradores de Pipeline
//==================================================

register_IF_ID IF_ID(); 

register_ID_EX ID_EX();

register_EX_MEM EX_MEM();

register_MEM_WB MEM_WB();

//==================================================
//                  Controladores
//==================================================

instructionDecode_Control ID_Control();

instructionExecute_Control EX_Control();

memoryAccess_Control MEM_Control();

writeBack_Control WB_Control();

endmodule
