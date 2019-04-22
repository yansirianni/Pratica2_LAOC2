module system (Clock, Reset, dout, q);

input Clock, Reset;
output [15:0] dout, q;

wire [15:0] addr;

wire w;


processor proc1 (q, Reset, Clock, dout, addr, w);
memory_main mem1 (addr[4:0], dout, w, Clock, q);


endmodule

