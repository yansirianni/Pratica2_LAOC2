module system (Clock, Reset, dout, q);

input Clock, Reset;
output [19:0] dout, q;

wire [19:0] addr, mem_addr, q_mem;

wire w;

//module pipelineProcessor (DataIn, Reset, Clock, Dout, MEM_Address_Out, Daddress, MEM_WriteEnable_Out);
pipelineProcessor proc1 (q, q_mem, Reset, Clock, dout, mem_addr, addr, w);
//module memory_main (mem_addr, addr, data, wr_en, Clock, q, q_mem);
memory_main mem1 (mem_addr[4:0], addr[4:0], dout, w, Clock, q, q_mem);


endmodule
