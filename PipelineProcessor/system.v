module system (Clock, Reset, dout, q);

input Clock, Reset;
output [19:0] dout, q;

wire [19:0] addr;

wire w;


pipelineProcessor proc1 (q, Reset, Clock, dout, addr, w);
memory_main mem1 (addr[4:0], dout, w, Clock, q);


endmodule
