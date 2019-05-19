module pipelineProcessor (DataIn, DataIn_Mem, Reset, Clock, MEM_WriteData_Out, MEM_Address_Out, Daddress, MEM_WriteEnable_Out);

    input [19:0] DataIn, DataIn_Mem;
    input Reset, Clock;
    output [19:0] MEM_WriteData_Out, Daddress;
    output [19:0] MEM_Address_Out;
    output MEM_WriteEnable_Out;

    wire [19:0] dataRFOut1, dataRFOut2;

    wire [3:0] WB_AddressReg;
    wire [15:0] DataOutMux;
    
    wire [19:0] JumpAddress;
    wire JumpEnable; // Habilita do jump no PC e é usado para resetar PC dentro do instructionFetch
    wire [19:0] IF_ID_Instruction_Out;

    wire [3:0] ID_ReadAddressRF1_Out, ID_ReadAddressRF2_Out;
    wire [19:0] ID_Instruction_Out;
    wire [19:0] ID_EX_Instruction_Out, ID_EX_dataRFOut1, ID_EX_dataRFOut2;

    wire [1:0] ALU_Control; // Controle da alu que esta dentro de instructionExecute

    wire [19:0] EX_dataRFOut1, EX_dataRFOut2; // Saidas guardadas pelo registrador ID_EX
    wire [19:0] EX_Alu_Out; // Resultado do instructionExecute
    wire [19:0] EX_Instruction_Out;
    wire EX_AluZero_Out; // Saida zero da ALU
    wire EX_MEM_AluZero_Out; // Saida zero do registrador
    wire [19:0] EX_MEM_AluResult_Out, EX_MEM_Instruction_Out, EX_MEM_WriteData_Out, EX_MEM_dataRFOut1_Out, EX_MEM_dataRFOut2_Out;

    wire [1:0] MEM_Address_Control;
    wire MEM_WriteEnable_Control;
    wire [19:0] MEM_Instruction_Out;
    wire [19:0] MEM_WB_AluResult_Out, MEM_WB_MemoryRead_Out, MEM_WB_Instruction_Out, MEM_WB_dataRFOut1_Out, MEM_WB_dataRFOut2_Out;

    wire WB_WriteEnable_Out;
    wire [3:0] WB_Address_Out;
    wire [19:0] WB_Data_Out;

    wire [3:0] IF_ID_opA, IF_ID_opB, ID_EX_opDestino,  EX_MEM_opDestino;
    wire stall;


    //==================================================
    //                    Estágios
    //==================================================

    //Estágio 1
    //module instructionFetch(clock,reset,jumpAddress,jumpEnable,Daddress);
    instructionFetch IF(stall, Clock, Reset, JumpAddress, JumpEnable, Daddress); //Carrega instruções da memória 

    //Estágio 2
    //module instructionDecode(instruction,ReadAddressRF1,ReadAddressRF2,instructionPropagation);
    instructionDecode ID(IF_ID_Instruction_Out, ID_ReadAddressRF1_Out, ID_ReadAddressRF2_Out, ID_Instruction_Out); //Decodifica a instrução e lê os registradores 

    //Estágio 3
    //module instructionExecute(instruction,control,opA,opB,result,ulaZero,dataRFOut1,dataRFOut2,instructionPropagation);
    instructionExecute EX(ID_EX_Instruction_Out, ALU_Control, ID_EX_dataRFOut1, ID_EX_dataRFOut2, EX_Alu_Out, EX_AluZero_Out, EX_dataRFOut1, EX_dataRFOut2, EX_Instruction_Out); //Executa o cálculo se necessário

    //Estágio 4
    //module memoryAccess(instruction, address, writeData, writeEnable, writeEnable_Out, writeData_Out, address_Out, instructionPropagation);
    memoryAccess MEM(EX_MEM_Instruction_Out, (MEM_Address_Control == 2'b0 ? EX_MEM_AluResult_Out : (MEM_Address_Control == 2'b01 ? EX_MEM_Instruction_Out[11:0] : (EX_MEM_dataRFOut2_Out))), EX_MEM_dataRFOut1_Out, MEM_WriteEnable_Control, MEM_WriteEnable_Out, MEM_WriteData_Out, MEM_Address_Out, MEM_Instruction_Out); //Leitura ou escrita na memória 

    //Estágio 5
    //module writeBack(reset,instruction,dataRFOut1,dataRFOut2,aluRESULTout,memoryReadData,address,writeBackEnable,writeBackAddress_Out,writeBackData_Out);
    writeBack WB(Reset, MEM_WB_Instruction_Out, MEM_WB_dataRFOut1_Out, MEM_WB_dataRFOut2_Out, MEM_WB_AluResult_Out, MEM_WB_MemoryRead_Out, MEM_WB_Instruction_Out[15:12], WB_WriteEnable_Out, WB_Address_Out, WB_Data_Out); //Escreve o resultado no banco de registradores

    //==================================================
    //            Registradores de Pipeline
    //==================================================

    //module register_IF_ID(clock,reset,instruction,instructionPropagation, opA, opB);
    register_IF_ID IF_ID(Clock, Reset, DataIn, IF_ID_Instruction_Out, IF_ID_opA, IF_ID_opB); 

    //module register_ID_EX(clock,reset,instruction,read_data1,read_data2,dataRFOut1,dataRFOut2,instructionPropagation,opDestino);
    register_ID_EX ID_EX(Clock,Reset,ID_Instruction_Out,dataRFOut1,dataRFOut2,ID_EX_dataRFOut1,ID_EX_dataRFOut2,ID_EX_Instruction_Out, ID_EX_opDestino);
    
    //module register_EX_MEM(clock,reset,instruction,dataRFOut1,dataRFOut2,aluZERO,aluRESULT,aluZEROout,aluRESULTout,dataRFOut1_Out,dataRFOut2_Out,instructionPropagation, opDestino);
    register_EX_MEM EX_MEM(Clock, Reset, EX_Instruction_Out, EX_dataRFOut1, EX_dataRFOut2, EX_AluZero_Out, EX_Alu_Out, EX_MEM_AluZero_Out, EX_MEM_AluResult_Out, EX_MEM_dataRFOut1_Out, EX_MEM_dataRFOut2_Out, EX_MEM_Instruction_Out, EX_MEM_opDestino);

    //module register_MEM_WB(clock,reset,instruction,dataRFOut1,dataRFOut2,aluRESULT,memory_read_data,aluRESULTout,memory_read_data_out,dataRFOut1_Out,dataRFOut2_Out,instructionPropagation);
    register_MEM_WB MEM_WB(Clock, Reset, MEM_Instruction_Out, EX_MEM_dataRFOut1_Out, EX_MEM_dataRFOut2_Out, EX_MEM_AluResult_Out, DataIn_Mem, MEM_WB_AluResult_Out, MEM_WB_MemoryRead_Out, MEM_WB_dataRFOut1_Out, MEM_WB_dataRFOut2_Out, MEM_WB_Instruction_Out);

    //==================================================
    //                  Controladores
    //==================================================

    instructionExecute_Control EX_Control(ID_EX_Instruction_Out, ALU_Control);

    memoryAccess_Control MEM_Control(EX_MEM_Instruction_Out, MEM_WriteEnable_Control, MEM_Address_Control);    

    //==================================================
    //                  Banco de Registradores
    //==================================================
    //module registerFile (clock,RegReadAddress1,RegReadAddress2,RegWriteAdress,WriteData,WriteEnable,DataOut1,DataOut2);
    registerFile rf(Clock, ID_ReadAddressRF1_Out, ID_ReadAddressRF2_Out, WB_Address_Out, WB_Data_Out, WB_WriteEnable_Out, dataRFOut1, dataRFOut2);

    //==================================================
    //               Detector de Hazard
    //==================================================

     HazardDetection hazard(Reset, IF_ID_Instruction_Out[19:16], IF_ID_opA, IF_ID_opB, ID_EX_opDestino, EX_MEM_opDestino, stall);

endmodule