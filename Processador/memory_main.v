module memory_main (addr, data, wr_en, Clock, q);

input [4:0] addr; 
input [15:0] data;
input wr_en, Clock;
output [15:0] q;

reg [15:0] Mem [0:31];

initial 
begin
  
  
Mem[ 5'h0] = 16'hf000;

  
  Mem[ 5'h1d] = 16'h0;
  Mem[ 5'h1e] = 16'h0;
  Mem[ 5'h1f] = 16'h1;
  

  
end


assign q = Mem[addr];

always @(posedge Clock)
begin
  if (wr_en) Mem[addr] = data;
  
end

endmodule

