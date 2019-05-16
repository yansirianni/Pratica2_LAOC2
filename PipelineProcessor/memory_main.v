module memory_main (mem_addr, addr, data, wr_en, Clock, q, q_mem);

  input [4:0] addr, mem_addr;
  input [19:0] data; //Mudar para 20 bits
  input wr_en, Clock;
  output [19:0] q, q_mem;

  reg [19:0] Mem [0:31];

  initial
  begin

    Mem[ 5'b0] = {4'b1111, 4'b0, 7'b0, 5'b11100}; //Copy input para $s0
    Mem[ 5'b00001] = {4'b1111, 4'b0001, 7'b0, 5'b11110}; //Copy input para $s1
    Mem[ 5'b00010] = {4'b1111, 4'b0010, 7'b0, 5'b11111}; //Copy input para $s2


    //add
    Mem[ 5'b00111] = {4'b0, 4'b1111, 4'b0, 4'b0001, 4'b0}; //Add para $s15 de $s0, $s1
    //load
    Mem[ 5'b01000] = {4'b1101, 4'b1110, 4'b0, 4'b0, 4'b0}; //load para $s14 de $s0
    //
    Mem[ 5'b01001] = {4'b1100, 4'b0, 4'b01, 4'b0, 4'b0};
    // //or
    // Mem[ 5'b01000] = {4'b0001, 4'b1110, 4'b0001, 4'b0010, 4'b0}; //Or para $s14 de $s1,$s2

    // //and
    // Mem[ 5'b01001] = {4'b0010, 4'b1101, 4'b0010, 4'b0010, 4'b0}; //And para $s13 de $s2, $s2
    // Mem[ 5'b00100] = {4'b1110, 4'b0110, 4'b0100, 8'b0};
    // Mem[ 5'b00101] = {4'b0011, 4'b0001, 12'b0};

    // Mem[ 5'b00110] = {4'b0, 4'b0101, 4'b0, 4'b0001, 4'b0};
    Mem[ 5'b11100] = {13'b0, 7'b1000000};
    Mem[ 5'b11101] = {18'b0, 2'b01}; //Dado de entrada
    Mem[ 5'b11110] = {17'b0, 3'b100}; //Dado de entrada
    Mem[ 5'b11111] = {17'b0, 3'b101}; //Dado de entrada

  end

  assign q = Mem[addr];
  assign q_mem = Mem[mem_addr];

  always @(negedge Clock)
  begin
    if (wr_en) Mem[mem_addr] = data;

  end

endmodule
