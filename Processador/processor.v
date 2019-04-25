
module processor (DataIn, Reset, Clock, Dout, Daddress, W);

input [19:0] DataIn;
input Reset, Clock;
output [19:0] Dout, Daddress;

output reg W;

wire[19:0] instruction, DataOutMux;

wire [15:0] dataRFOut1, dataRFOut2, aluOut, DataOutRegAlu, DataOutRegPc;

reg writeEnableRegALU,  writeEnableRegisterFile, incr_pc;
reg writeEnableRegInstruction, writeEnableRegAddress, writeEnableRegDout;
reg [1:0] Step, controlAlu;

reg [2:0] controlMux;

reg [3:0] ReadAddressRF1, ReadAddressRF2;

/*
module registerFile (Read1,Read2,WriteReg,WriteData,RegWrite,Data1,Data2,clock);
input [2:0] Read1,Read2,WriteReg;
input [15:0] WriteData;
input RegWrite, clock;
output [15:0] Data1, Data2;
*/
registerFile rf(ReadAddressRF1, ReadAddressRF2, instruction[15:12], DataOutMux[15:0], writeEnableRegisterFile, dataRFOut1, dataRFOut2, Clock, incr_pc);

programCounter pc1 (DataOutRegPc, DataOutMux[15:0],RegWrite,incr_pc, Clock);




/*
module mux4_1_20bits (A, B, C, D, Control, DataOut);
input [19:0] A, B, C, D;
input [1:0] Control;
output reg [19:0] dataRFOut;
*/
mux5_1_20bits mux1(dataRFOut2, dataRFOut1, DataIn[19:0], {4'b0, DataOutRegAlu}, {4'b0, DataOutRegPc}, controlMux, DataOutMux);

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
register20bits RegInstruction(DataIn, writeEnableRegInstruction, Clock, instruction);

register16bits RegDout(DataOutMux[15:0], writeEnableRegDout, Clock, Dout[15:0]);
register20bits_i RegAddress(DataOutMux, writeEnableRegAddress, Clock, Daddress);



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




//ReadAddressRF1 = instruction[11:8]; // selecionado pelo controlMux <= 2'b01;
//ReadAddressRF2 = instruction[7:4]; // selecionado pelo controlMux <= 2'b00;


always @(Step, instruction)
begin
case(Step)
  2'b00:
  begin
    writeEnableRegInstruction <= 1'b1;
    writeEnableRegisterFile <= 1'b0;
    incr_pc  <= 1'b1;
    ReadAddressRF1 <= instruction[11:8];
    ReadAddressRF2 <= instruction[7:4];
    writeEnableRegAddress <= 1'b0;
    controlMux <= 3'b010;
    W <= 1'b0;

  end // Step 00

  2'b01: // PASSO 1 ///////////////////////////////////////
  begin

  case(instruction[19:16])

    4'b1101:  // load
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      writeEnableRegAddress <= 1'b1;
      controlMux <= 3'b001;  // Endereco de qual registrador em que esta' o endereco da memoria (00 ou 01)
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end
    4'b1100:  // store
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      ReadAddressRF1 <= instruction[15:12];
      ReadAddressRF2 <= instruction[11:8];

      writeEnableRegAddress <= 1'b1;
      controlMux <= 3'b000;  // seleciona o endereco da memoria onde o dado sera escrito  (00 ou 01)
      writeEnableRegDout <= 1'b0;


    end
    4'b1011:  // conditional copy
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end


    4'b1111:  // copy input
    begin
      incr_pc  <= 1'b1;
      writeEnableRegInstruction <= 1'b0;
      controlMux <= 3'b100;
      //ReadAddressRF2 <= 4'b1111;
		ReadAddressRF2 <= instruction[7:4];
      writeEnableRegAddress <= 1'b1;
      ReadAddressRF1 <= instruction[11:8];

    end

    4'b1110:  // copy
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end

    4'b0000: // sum
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b00;
      controlMux <= 3'b011;
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end

    4'b0001: // OR
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b01;
      controlMux <= 3'b011;
      ReadAddressRF1 <= instruction[11:8];
     ReadAddressRF2 <= instruction[7:4];

    end

    4'b0010: //AND
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b10;
      controlMux <= 3'b011;
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end

    4'b0011: // NOT
    begin
      incr_pc  <= 1'b0;
      writeEnableRegInstruction <= 1'b0;
      writeEnableRegisterFile <= 1'b0;
      writeEnableRegALU <= 1'b1;
      controlAlu <= 2'b11;
      controlMux <= 3'b011;
      ReadAddressRF1 <= instruction[11:8];
      ReadAddressRF2 <= instruction[7:4];

    end
  endcase
  end

  2'b10: // PASSO 2 ///////////////////////////////////
  begin
  casex(instruction[19:16])

        4'b1101:  // load
    begin
      writeEnableRegAddress <= 1'b0;
      writeEnableRegisterFile <= 1'b1;
      controlMux <= 3'b010; // selecionar o DIN

    end
    4'b1100:  // store
    begin

//      writeEnableRegAddress <= 1'b1;
//      controlMux <= 2'b00;  // seleciona o endereco da memoria onde o dado sera escrito  (00 ou 01)
//      writeEnableRegDout <= 1'b0;

      writeEnableRegDout <= 1'b1;
      controlMux <= 3'b001;  //  seleciona o dado que sera escrito na memoria  (00 ou 01)
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
          controlMux <= 3'b001;
        end
    end


    4'b00xx: //ULA
    begin
      writeEnableRegisterFile <= 1'b1;
      writeEnableRegALU <= 1'b0;
      controlMux <= 3'b011;
    end
    4'b1111:  // copy input
    begin
      writeEnableRegisterFile <= 1'b1;
      controlMux <= 3'b010;
      incr_pc  <= 1'b0;
      writeEnableRegAddress <= 1'b0;
    end

    4'b1110:  // copy
    begin
      writeEnableRegisterFile <= 1'b1;
      controlMux <= 3'b001;
    end



  endcase
  end

  2'b11: // PASSO 3 //////////////////////////////////////////////////
  begin
    incr_pc  <= 1'b0;
    controlMux <= 3'b100;
    //ReadAddressRF2 <= 4'b1111; //POSSIVELMENTE MUDAR AQUI
    writeEnableRegAddress <= 1'b1;
 //   W <= 1'b0;
    writeEnableRegDout <= 1'b0;
    writeEnableRegisterFile <= 1'b0;
    if(instruction[19:16]==4'b1100) //store
    begin
      W <= 1'b1;
    end

  end

endcase
end


endmodule


module PC_reg15 (R, L, incr_pc, Clock, Q);
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

module programCounter (regPc,Data,RegWrite,incr_pc, clock);

input clock, incr_pc,RegWrite;
input [15:0] Data;
output [15:0] regPc;

PC_reg15 PC(Data, RegWrite, incr_pc, clock, regPc); 

endmodule


module registerFile (Read1,Read2,WriteReg,WriteData,RegWrite,Data1,Data2,clock, incr_pc);
input [3:0] Read1,Read2,WriteReg;
input [15:0] WriteData;
input RegWrite, clock, incr_pc;
output [15:0] Data1, Data2;

wire [15:0] decOut;
wire [15:0] register [15:0];

decoder dec1(WriteReg, decOut); 
//PC_reg15 PC(WriteData, decOut[15]& RegWrite, incr_pc, clock, register[15]); 

//Modificado para 16 bits

register16bits register1(WriteData, decOut[0]& RegWrite , clock, register[0]);
register16bits register2(WriteData, decOut[1]& RegWrite , clock, register[1]);
register16bits register3(WriteData, decOut[2]& RegWrite , clock, register[2]);
register16bits register4(WriteData, decOut[3]& RegWrite , clock, register[3]);
register16bits register5(WriteData, decOut[4]& RegWrite , clock, register[4]);
register16bits register6(WriteData, decOut[5]& RegWrite , clock, register[5]);
register16bits register7(WriteData, decOut[6]& RegWrite , clock, register[6]);
register16bits register8(WriteData, decOut[7]& RegWrite , clock, register[7]);
register16bits register9(WriteData, decOut[8]& RegWrite , clock, register[8]);
register16bits register10(WriteData, decOut[9]& RegWrite , clock, register[9]);
register16bits register11(WriteData, decOut[10]& RegWrite , clock, register[10]);
register16bits register12(WriteData, decOut[11]& RegWrite , clock, register[11]);
register16bits register13(WriteData, decOut[12]& RegWrite , clock, register[12]);
register16bits register14(WriteData, decOut[13]& RegWrite , clock, register[13]);
register16bits register15(WriteData, decOut[14]& RegWrite , clock, register[14]);
register16bits register16(WriteData, decOut[15]& RegWrite , clock, register[15]);

assign Data1 = register[Read1];
assign Data2 = register[Read2];

endmodule

module decoder #(parameter N = 4) (input [N-1:0] DataIn, output reg [(1<<N)-1:0] DataOut);
    always @ (DataIn)
     begin
       DataOut <= 1 << DataIn;
     end
endmodule

module mux5_1_20bits (A, B, C, D, E, Control, DataOut);

input [19:0] A, B, C, D, E;
input [2:0] Control;
output reg [19:0] DataOut;

always @(A, B, C, D, E, Control)
begin
  case (Control)
	  3'b000: DataOut <= A;
	  3'b001: DataOut <= B;
	  3'b010: DataOut <= C;
	  3'b011: DataOut <= D;
	  3'b100: DataOut <= E;
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

module register20bits(R, Rin, Clock, Q);
parameter n = 20;
input [n-1:0] R;
input Rin, Clock;
output [n-1:0] Q;
reg [n-1:0] Q;

/*
initial
begin
  Q <= 20'b0;
end
*/

always @(posedge Clock)
if (Rin)
	Q <= R;

endmodule

//register20bits_i RegAddress(DataOutMux, writeEnableRegAddress, Clock, Daddress);

module register20bits_i(R, Rin, Clock, Q);
parameter n = 20;
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
