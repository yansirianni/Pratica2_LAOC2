module registerFile (clock,RegReadAddress1,RegReadAddress2,RegWriteAdress,WriteData,WriteEnable,DataOut1,DataOut2);
    input [3:0] RegReadAddress1,RegReadAddress2,RegWriteAdress;
    input [19:0] WriteData;
    input WriteEnable, clock;
    output [19:0] DataOut1, DataOut2;

    wire [15:0] decOut;
    wire [19:0] register [15:0];

    decoder dec1(RegWriteAdress, decOut); 

    //Modificado para 20 bits

    register20bits register0(WriteData, decOut[0]& WriteEnable , clock, register[0]);
    register20bits register1(WriteData, decOut[1]& WriteEnable , clock, register[1]);
    register20bits register2(WriteData, decOut[2]& WriteEnable , clock, register[2]);
    register20bits register3(WriteData, decOut[3]& WriteEnable , clock, register[3]);
    register20bits register4(WriteData, decOut[4]& WriteEnable , clock, register[4]);
    register20bits register5(WriteData, decOut[5]& WriteEnable , clock, register[5]);
    register20bits register6(WriteData, decOut[6]& WriteEnable , clock, register[6]);
    register20bits register7(WriteData, decOut[7]& WriteEnable , clock, register[7]);
    register20bits register8(WriteData, decOut[8]& WriteEnable , clock, register[8]);
    register20bits register9(WriteData, decOut[9]& WriteEnable , clock, register[9]);
    register20bits register10(WriteData, decOut[10]& WriteEnable , clock, register[10]);
    register20bits register11(WriteData, decOut[11]& WriteEnable , clock, register[11]);
    register20bits register12(WriteData, decOut[12]& WriteEnable , clock, register[12]);
    register20bits register13(WriteData, decOut[13]& WriteEnable , clock, register[13]);
    register20bits register14(WriteData, decOut[14]& WriteEnable , clock, register[14]);
    register20bits register15(WriteData, decOut[15]& WriteEnable , clock, register[15]);

    assign DataOut1 = register[RegReadAddress1];
    assign DataOut2 = register[RegReadAddress2];

endmodule

module decoder #(parameter N = 4) (input [N-1:0] DataIn, output reg [(1<<N)-1:0] DataOut);
    always @ (DataIn)
     begin
       DataOut <= 1 << DataIn;
     end
endmodule

module register20bits(R, Rin, Clock, Q);
    parameter n = 20;
    input [n-1:0] R;
    input Rin, Clock;
    output [n-1:0] Q;
    reg [n-1:0] Q;

    always @(negedge Clock)
    if (Rin)
        Q <= R;

endmodule

  //==================================================
  //                    Testbench
  //==================================================

module RegisterFile_TestBench; //Template TESTBENCH for the instatiation module
	reg [3:0] RegReadAddress1,RegReadAddress2,RegWriteAdress;
    reg [19:0] WriteData;
    reg WriteEnable, clock;
    wire [19:0] DataOut1, DataOut2;
	
    parameter timeDelay = 200; //Delay time(ps) parameter
   
    registerFile rf (clock,RegReadAddress1,RegReadAddress2,RegWriteAdress,WriteData,WriteEnable,DataOut1,DataOut2);
	 
	initial begin
		clock = 0; RegReadAddress1 = 0; RegWriteAdress = 0; WriteData = 0; WriteEnable = 0; //Setting variables initial values
		forever begin
		    #100 clock = ~clock; //Defining clock pulse delay time
		end 
	end 
	initial begin   //Delay times changed for synchronizing write operations
		#(timeDelay)
            WriteData = 20'b00000000000000000001;
            RegWriteAdress = 4'b0000;
            WriteEnable = 1;  //Value changing example routine
            RegReadAddress1 = 4'b0000;

        #190
            WriteData = 20'b00000000000000000010;
            RegWriteAdress = 4'b0010;
            RegReadAddress1 = 4'b0001;

        #170
            WriteData = 20'b00000000000000000011;
            RegReadAddress1 = 4'b0010;

	end 

endmodule // testBench_template