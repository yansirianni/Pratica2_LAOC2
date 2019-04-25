library verilog;
use verilog.vl_types.all;
entity programCounter is
    port(
        regPc           : out    vl_logic_vector(15 downto 0);
        Data            : in     vl_logic_vector(15 downto 0);
        RegWrite        : in     vl_logic;
        incr_pc         : in     vl_logic;
        clock           : in     vl_logic
    );
end programCounter;
