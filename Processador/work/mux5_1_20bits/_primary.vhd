library verilog;
use verilog.vl_types.all;
entity mux5_1_20bits is
    port(
        A               : in     vl_logic_vector(19 downto 0);
        B               : in     vl_logic_vector(19 downto 0);
        C               : in     vl_logic_vector(19 downto 0);
        D               : in     vl_logic_vector(19 downto 0);
        E               : in     vl_logic_vector(19 downto 0);
        Control         : in     vl_logic_vector(2 downto 0);
        DataOut         : out    vl_logic_vector(19 downto 0)
    );
end mux5_1_20bits;
