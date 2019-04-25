library verilog;
use verilog.vl_types.all;
entity PC_reg15 is
    port(
        R               : in     vl_logic_vector(15 downto 0);
        L               : in     vl_logic;
        incr_pc         : in     vl_logic;
        Clock           : in     vl_logic;
        Q               : out    vl_logic_vector(15 downto 0)
    );
end PC_reg15;
