module memory_main (addr, data, wr_en, Clock, q);

input [4:0] addr;
input [19:0] data; //Mudar para 20 bits
input wr_en, Clock;
output [19:0] q;

reg [19:0] Mem [0:31];

initial
begin

Mem[ 5'b0] = {4'b1111, 16'b0}; //Copy input para $s1
Mem[ 5'b00001] = {4'b1111, 4'b0111, 4'b0110, 4'b0}; //Dado de entrada

Mem[ 5'b00010] = {4'b1111, 4'b0100, 12'b0}; //Copy input para $s1
Mem[ 5'b00011] = {12'b0, 4'b0001, 4'b0}; //Dado de entrada

Mem[ 5'b00100] = {4'b1110, 4'b0110, 4'b0100, 8'b0};
Mem[ 5'b00101] = {4'b0011, 4'b0001, 12'b0};

Mem[ 5'b00110] = {4'b0, 4'b0101, 4'b0, 4'b0001, 4'b0};

end

assign q = Mem[addr];

always @(posedge Clock)
begin
  if (wr_en) Mem[addr] = data;

end

endmodule
