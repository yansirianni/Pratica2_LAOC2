module pipelineProcessor (DataIn, Reset, Clock, Dout, Daddress, W);

    input [19:0] DataIn;
    input Reset, Clock;
    output [19:0] Dout, Daddress;

    output reg W;

    wire [3:0] WB_AddressReg;
    wire [15:0] DataOutMux;
    
    wire jumpEnable; // Habilita do jump no PC e é usado para resetar PC dentro do instructionFetch
    wire [19:0] IF_ID_Data_Out;
    wire [19:0] IF_ID_Instruction_Out;

    wire [3:0] ID_ReadAddressRF1_Out, ID_ReadAddressRF2_Out;
    wire [3:0] ID_EX_Instruction_Out;

    wire [1:0] ALU_Control; // Controle da alu que esta dentro de instructionExecute

    wire [19:0] EX_dataRFOut1, EX_dataRFOut2; // Saidas guardadas pelo registrador ID_EX
    wire [19:0] EX_Out; // Resultado do instructionExecute
    wire [19:0] MEM_MemoryRead_Out, MEM_WB_AluResult_Out, MEM_WB_MemoryRead_Out;


    //==================================================
    //                    Estágios
    //==================================================

    //Estágio 1
    instructionFetch IF(Clock, Reset, JumpAddress, JumpEnable, Daddress); //Carrega instruções da memória 

    //Estágio 2
    instructionDecode ID(Clock, Reset, IF_ID_Data_Out, ID_ReadAddressRF1_Out, ID_ReadAddressRF2_Out); //Decodifica a instrução e lê os registradores 

    //Estágio 3
    instructionExecute EX(ALU_Control, EX_dataRFOut1, EX_dataRFOut2, EX_Out, EX_ulaZero); //Executa o cálculo se necessário

    //Estágio 4
    //module memoryAccess(instruction, address, writeData, writeEnable, writeEnable_Out, writeData_Out, address_Out, instructionPropagation);
    memoryAccess MEM(EX_MEM_Instruction_Out, EX_MEM_AluResult_Out, EX_MEM_WriteData_Out); //Leitura ou escrita na memória 

    //Estágio 5
    writeBack WB(); //Escreve o resultado no banco de registradores

    //==================================================
    //            Registradores de Pipeline
    //==================================================

    register_IF_ID IF_ID(Clock, Reset, DataIn[19:16], DataIn, IF_ID_Data_Out, IF_ID_Instruction_Out); 

    register_ID_EX ID_EX(Clock, Reset, IF_ID_Instruction_Out, EX_dataRFOut1, EX_dataRFOut2, ID_EX_dataRFOut1, ID_EX_dataRFOut2, ID_EX_Instruction_Out);

    register_EX_MEM EX_MEM(Clock, Reset, ID_EX_Instruction_Out, EX_UlaZero, EX_Out, EX_dataRFOut2, EX_MEM_Ula_Out, EX_MEM_AluResult_Out, EX_MEM_Instruction_Out);
    //register_MEM_WB(clock, reset,opcode,aluRESULT,memory_read_data,aluRESULTout,memory_read_data_out);
    register_MEM_WB MEM_WB(Clock, Reset, EX_MEM_Instruction_Out, EX_MEM_AluResult_Out, MEM_MemoryRead_Out, MEM_WB_AluResult_Out, MEM_WB_MemoryRead_Out);

    //==================================================
    //                  Controladores
    //==================================================

    //==================================================
    //                    ATENÇÃO!
    //==================================================

    /*
        Por enquanto, há um consenso entre os devs deste projeto de que esse módulo não possui nenhuma responsabilidade. Por isso, está temporariamente sem atribuições.
    */

    //instructionDecode_Control ID_Control(); Não será necessário

    instructionExecute_Control EX_Control(ID_EX_Instruction_Out, ALU_Control);

    memoryAccess_Control MEM_Control(EX_MEM_Instruction_Out, MEM_WriteEnable_Control);

    //writeBack_Control WB_Control();

    

    //==================================================
    //                  Banco de Registradores
    //==================================================
    //module registerFile (clock,Read1,Read2,WriteReg,WriteData,RegWrite,Data1,Data2);
    registerFile rf(Clock, ID_ReadAddressRF1_Out, ID_ReadAddressRF2_Out, WB_AddressReg, DataOutMux[15:0], writeEnableRegisterFile, dataRFOut1, dataRFOut2);

endmodule

//==================================================
    //                    Testbench
    //==================================================


module pipelineProcessor_testbench;
    reg [19:0] DataIn;
    reg Reset, Clock;
    wire [19:0] Dout, Daddress;

    wire W;

    wire [3:0] WB_AddressReg;
    wire [15:0] DataOutMux;
    
    wire jumpEnable; 
    wire [19:0] IF_ID_Data_Out;
    wire [19:0] IF_ID_Instruction_Out;

    wire [3:0] ID_ReadAddressRF1_Out, ID_ReadAddressRF2_Out;
    wire [3:0] ID_EX_Instruction_Out;

    wire [1:0] ALU_Control; 

    wire [19:0] EX_dataRFOut1, EX_dataRFOut2; 
    wire [19:0] EX_Out;
    wire [19:0] MEM_MemoryRead_Out, MEM_WB_AluResult_Out, MEM_WB_MemoryRead_Out;

   parameter timeDelay = 200;

	 pipelineProcessor  pipelineProcessor_TestBench (DataIn, Reset, Clock, Dout, Daddress, W);

	 initial begin //RESETING EVERYTHING
	   DataIn = 0;
		  Clock = 0; Reset = 1;
      forever begin
		    #50 Clock = ~Clock;
		  end
	  end 

	initial begin
        //STORE DO DADO DO REGISTRADOR 0000(inicializado na memoria) PARA O REGISTRADOR 1111
        #(timeDelay) DataIn = 20'b11001111000000000000; //Saídas esperadas: Dout = ; Daddress = ; W = ;

        //ADD DO DADO DO REGISTRADOR 0000 E O REGISTRADOR 1111, SALVO EM REGISTRADOR 0001
        #(timeDelay) DataIn = 20'b00000001111100000000; //Saídas esperadas: Dout = ; Daddress = ; W = ; 

        //NOT DO DADO DO REGISTRADOR 0001, SALVO EM REGISTRADOR 0010
        #(timeDelay) DataIn = 20'b00110001111100000000; //Saídas esperadas: Dout = ; Daddress = ; W = ;

         //LOAD DO ENDEREÇO NO REGISTRADOR 0000 SALVO EM REGISTRADOR 0011
            //(LEMBRAR DE DEFINIR O ENDEREÇO NO REGISTRADOR 0000 E DEFINIR O DADO NO REGISTRADOR NO ENDEREÇO GUARADO POR 0000)
          #(timeDelay) DataIn = 20'b1011 0011 0000 00000000; //Saídas esperadas: Dout = ; Daddress = ; W = ;
    end 
endmodule