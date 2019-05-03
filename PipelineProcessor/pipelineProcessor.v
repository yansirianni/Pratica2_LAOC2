module pipelineProcessor (DataIn, Reset, Clock, Dout, Daddress, W);

    input [19:0] DataIn;
    input Reset, Clock;
    output [19:0] Dout, Daddress;

    output reg W;

    wire jumpEnable; // Habilita do jump no PC
    wire [19:0] IF_ID_DataOut;
    wire [3:0] IF_OpcodeOut;

    wire [3:0] ReadAddressRF1, ReadAddressRF2;
    wire [3:0] ID_OpcodeOut;
    wire [31:0] extended_signal;

    wire [1:0] ALU_Control; // Controle da alu que esta dentro de instructionExecute
    wire [15:0] EX_dataRFOut1, EX_dataRFOut2; // Saidas guardadas pelo registrador ID_EX
    wire [15:0] EX_Out; // Resultado do instructionExecute


    //==================================================
    //                    Estágios
    //==================================================

    //Estágio 1
    instructionFetch IF(Clock, Reset, jumpAddress, jumpEnable, Daddress); //Carrega instruções da memória 

    //Estágio 2
    instructionDecode ID(IF_ID_DataOut,ReadAddressRF1,ReadAddressRF2); //Decodifica a instrução e lê os registradores 

    //Estágio 3
    //module instructionExecute(input	[1:0] control;input	[15:0]  opA, opB;output	reg [15:0]  result;);
    instructionExecute EX(ALU_Control, EX_dataRFOut1, EX_dataRFOut2, EX_Out); //Executa o cálculo se necessário

    //Estágio 4
    memoryAccess MEM(); //Leitura ou escrita na memória 

    //Estágio 5
    writeBack WB(); //Escreve o resultado no banco de registradores

    //==================================================
    //            Registradores de Pipeline
    //==================================================

    register_IF_ID IF_ID(Clock, Reset, DataIn[19:16], DataIn, IF_ID_DataOut, IF_OpcodeOut); 

    register_ID_EX ID_EX(Clock,Reset,IF_OpcodeOut,extended_signal,read_data1,read_data2,EX_dataRFOut1,EX_dataRFOut2,ID_OpcodeOut);

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