library verilog;
use verilog.vl_types.all;
entity memory_main is
    port(
        addr            : in     vl_logic_vector(4 downto 0);
        data            : in     vl_logic_vector(19 downto 0);
        wr_en           : in     vl_logic;
        Clock           : in     vl_logic;
        q               : out    vl_logic_vector(19 downto 0)
    );
end memory_main;
