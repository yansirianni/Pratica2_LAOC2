library verilog;
use verilog.vl_types.all;
entity system is
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        dout            : out    vl_logic_vector(19 downto 0);
        q               : out    vl_logic_vector(19 downto 0)
    );
end system;
