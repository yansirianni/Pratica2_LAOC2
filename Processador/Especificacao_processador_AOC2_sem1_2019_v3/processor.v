
module processor (DataIn, Reset, Clock, Dout, Daddress, W);

input [15:0] DataIn;
input Reset, Clock; 
output [15:0] Dout, Daddress;

output reg W;

wire [15:0] instruction, dataRFOut1, dataRFOut2, aluOut, DataOutMux, DataOutRegAlu;

reg writeEnableRegALU,  writeEnableRegisterFile, incr_pc;
reg writeEnableRegInstruction, writeEnableRegAddress, writeEnableRegDout;
reg [1:0] Step, controlMux, controlAlu;

reg [2:0] ReadAddressRF1, ReadAddressRF2;

/*
module registerFile (Read1,Read2,WriteReg,WriteData,RegWrite,Data1,Data2,clock);
input [2:0] Read1,Read2,WriteReg;
input [15:0] WriteData;
input RegWrite, clock;
output [15:0] Data1, Data2;
*/
registerFile rf(ReadAddressRF1, ReadAddressRF2, instruction[11:9], DataOutMux, writeEnableRegisterFile, dataRFOut1, dataRFOut2, Clock, incr_pc);




/*
module mux4_1_16bits (A, B, C, D, Control, DataOut);
input [15:0] A, B, C, D;
input [1:0] Control;
output reg [15:0] dataRFOut;
*/
mux4_1_16bits mux1(dataRFOut2, dataRFOut1, DataIn, DataOutRegAlu, controlMux, DataOutMux);

/*
module alu (opA, opB, control, result);
input	  [1:0] control;
input	[15:0]  opA, opB;
output	reg [15:0]  result;
*/
alu alu1(dataRFOut1, dataRFOut2, controlAlu, aluOut);

/*
module register16bits(R, Rin, Clock, Q);
parameter n = 16;
input [n-1:0] R;
input Rin, Clock;
output [n-1:0] Q;
*/
register16bits regALU(aluOut, writeEnableRegALU, Clock, DataOutRegAlu);
register16bits RegInstruction(DataIn, writeEnableRegInstruction, Clock, instruction);

register16bits RegDout(DataOutMux, writeEnableRegDout, Clock, Dout);
register16bits_i RegAddress(DataOutMux, writeEnableRegAddress, Clock, Daddress);


//Maquina de Estados

    
always @(posedge Clock)
begin
  if(Reset)
    Step <= 2'b0;
    
  else
    case(Step)
      2'b00:
      begin
        Step <= 2'b01;
      end
      2'b01:
      begin
        Step <= 2'b10;
      end
      2'b10:
      begin
        Step <= 2'b11;
      end
      2'b11:
        Step <= 2'b0;
        
    endcase // Step
end // always @(posedge Clock)           




//ReadAddressRF1 = instruction[8:6]; // selecionado pelo controlMux <= 2'b01;
//ReadAddressRF2 = instruction[5:3]; // selecionado pelo controlMux <= 2'b00;




always @(Step, instruction)
begin
case(Step)
  2'b00:
  begin
    writeEnableRegInstruction <= 1'b1;
    writeEnableRegisterFile <= 1'b0;
    incr_pc  <= 1'b1;
    ReadAddressRF1 <= instruction[8:6];
    ReadAddressRF2 <= instruction[5:3];
    writeEnableRegAddress <= 1'b0;
    controlMux <= 2'b10;
    W <= 1'b0;

  end // Step 00 
    
  2'b01: // PASSO 1 ///////////////////////////////////////
  begin
    
  case(instruction[15:12])

    4'b1101:  // load
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;  
      writeEnableRegAddress <= 1'b1;
      controlMux <= 2'b01;  // Endereco de qual registrador em que esta' o endereco da memoria (00 ou 01)
      ReadAddressRF1 <= instruction[8:6];
      ReadAddressRF2 <= instruction[5:3];      

    end     
    4'b1100:  // store
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;  
      ReadAddressRF1 <= instruction[11:9];
      ReadAddressRF2 <= instruction[8:6];      

      writeEnableRegAddress <= 1'b1;
      controlMux <= 2'b00;  // seleciona o endereco da memoria onde o dado sera escrito  (00 ou 01)
      writeEnableRegDout <= 1'b0;

     
    end     
    4'b1011:  // conditional copy
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;  
      ReadAddressRF1 <= instruction[8:6];
      ReadAddressRF2 <= instruction[5:3];

    end

    
    4'b1111:  // copy input
    begin
      incr_pc  <= 1'b1;
      writeEnableRegInstruction <= 1'b0; 
      controlMux <= 2'b0;
      ReadAddressRF2 <= 3'b111;
      writeEnableRegAddress <= 1'b1;
      ReadAddressRF1 <= instruction[8:6];

    end     

    4'b1110:  // copy
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;  
      ReadAddressRF1 <= instruction[8:6];
      ReadAddressRF2 <= instruction[5:3];      

    end

    4'b0000: // sum
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;  
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b00;
      controlMux <= 2'b11;
      ReadAddressRF1 <= instruction[8:6];
      ReadAddressRF2 <= instruction[5:3];

    end 
    
    4'b0001: // OR
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;  
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b01;
      controlMux <= 2'b11;
      ReadAddressRF1 <= instruction[8:6];
     ReadAddressRF2 <= instruction[5:3];

    end 
    
    4'b0010: //AND
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;  
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b10;
      controlMux <= 2'b11;
      ReadAddressRF1 <= instruction[8:6];
      ReadAddressRF2 <= instruction[5:3];
 
    end 
    
    4'b0011: // NOT
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;  
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b11;
      controlMux <= 2'b11;
      ReadAddressRF1 <= instruction[8:6];
      ReadAddressRF2 <= instruction[5:3];

    end 
  endcase     
  end 

  2'b10: // PASSO 2 ///////////////////////////////////
  begin
  casex(instruction[15:12])
    
        4'b1101:  // load
    begin
      writeEnableRegAddress <= 1'b0;
      writeEnableRegisterFile <= 1'b1;
      controlMux <= 2'b10; // selecionar o DIN
      
    end     
    4'b1100:  // store
    begin
 
//      writeEnableRegAddress <= 1'b1;
//      controlMux <= 2'b00;  // seleciona o endereco da memoria onde o dado sera escrito  (00 ou 01)
//      writeEnableRegDout <= 1'b0;

      writeEnableRegDout <= 1'b1;
      controlMux <= 2'b01;  //  seleciona o dado que sera escrito na memoria  (00 ou 01)
      writeEnableRegAddress <= 1'b0;

    end     
    4'b1011:  // conditional copy
    begin
      if(DataOutRegAlu == 16'b0)
        begin
          incr_pc  <= 1'b0;
          writeEnableRegInstruction <= 1'b0;  
        end
      else
        begin
          writeEnableRegisterFile <= 1'b1;
          controlMux <= 2'b01;
        end
    end     
      

    4'b00xx: //ULA
    begin
      writeEnableRegisterFile <= 1'b1;
      writeEnableRegALU <= 1'b0;
      controlMux <= 2'b11;
    end     
    4'b1111:  // copy input
    begin
      writeEnableRegisterFile <= 1'b1;
      controlMux <= 2'b10;
      incr_pc  <= 1'b0;
      writeEnableRegAddress <= 1'b0;
    end     

    4'b1110:  // copy
    begin
      writeEnableRegisterFile <= 1'b1;
      controlMux <= 2'b01;
    end
    
    
 
  endcase
  end

  2'b11: // PASSO 3 //////////////////////////////////////////////////
  begin
    incr_pc  <= 1'b0;
    controlMux <= 2'b0;
    ReadAddressRF2 <= 3'b111;
    writeEnableRegAddress <= 1'b1;
 //   W <= 1'b0;
    writeEnableRegDout <= 1'b0;
    writeEnableRegisterFile <= 1'b0;
    if(instruction[15:12]==4'b1100) //store
    begin
      W <= 1'b1;
    end

  end
    
endcase
end


endmodule


module PC_reg7 (R, L, incr_pc, Clock, Q);
input [15:0] R;
input L, incr_pc, Clock;
output reg [15:0] Q;

initial
begin
  Q <= 16'b0;
end

always @(posedge Clock)
if (L)
	Q <= R;
else
	if (incr_pc)
		Q <= Q + 1'b1;
endmodule 


module registerFile (Read1,Read2,WriteReg,WriteData,RegWrite,Data1,Data2,clock, incr_pc);
input [2:0] Read1,Read2,WriteReg;
input [15:0] WriteData;
input RegWrite, clock, incr_pc;
output [15:0] Data1, Data2;
     
wire [7:0] decOut;          
wire [15:0] register [7:0];

decoder dec1(WriteReg, decOut);

PC_reg7 PC(WriteData, decOut[7]& RegWrite, incr_pc, clock, register[7]);

register16bits register1(WriteData, decOut[0]& RegWrite , clock, register[0]);
register16bits register2(WriteData, decOut[1]& RegWrite , clock, register[1]);
register16bits register3(WriteData, decOut[2]& RegWrite , clock, register[2]);
register16bits register4(WriteData, decOut[3]& RegWrite , clock, register[3]);
register16bits register5(WriteData, decOut[4]& RegWrite , clock, register[4]);
register16bits register6(WriteData, decOut[5]& RegWrite , clock, register[5]);
register16bits register7(WriteData, decOut[6]& RegWrite , clock, register[6]);



assign Data1 = register[Read1];
assign Data2 = register[Read2];

endmodule

module decoder #(parameter N = 3) (input [N-1:0] DataIn, output reg [(1<<N)-1:0] DataOut);
    always @ (DataIn)
     begin
       DataOut <= 1 << DataIn;
     end
endmodule


module mux4_1_16bits (A, B, C, D, Control, DataOut);

input [15:0] A, B, C, D;
input [1:0] Control;
output reg [15:0] DataOut;


always @(A, B, C, D, Control)
begin
  case (Control)
	  2'b00: DataOut <= A;
	  2'b01: DataOut <= B;
	  2'b10: DataOut <= C;
	  2'b11: DataOut <= D;
  endcase
end
endmodule



module register16bits(R, Rin, Clock, Q);
parameter n = 16;
input [n-1:0] R;
input Rin, Clock;
output [n-1:0] Q;
reg [n-1:0] Q;

/*
initial 
begin
  Q <= 16'b0;
end
*/

always @(posedge Clock)
if (Rin)
	Q <= R;

endmodule

module register16bits_i(R, Rin, Clock, Q);
parameter n = 16;
input [n-1:0] R;
input Rin, Clock;
output [n-1:0] Q;
reg [n-1:0] Q;


initial 
begin
  Q <= 16'b0;
end


always @(posedge Clock)
if (Rin)
	Q <= R;

endmodule

module alu (opA, opB, control, result);

input	  [1:0] control;
input	[15:0]  opA, opB;
output	reg [15:0]  result;


always @(opA, opB, control )
	case (control)
	  2'b00: 		result <= opA + opB;
	  2'b01: 		result <= opA | opB;
	  2'b10: 		result <= opA & opB;	  	  
	  2'b11: 		result <= ~(opA);
	  endcase
endmodule
	
		
		
