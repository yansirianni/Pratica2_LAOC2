library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        opA             : in     vl_logic_vector(15 downto 0);
        opB             : in     vl_logic_vector(15 downto 0);
        control         : in     vl_logic_vector(1 downto 0);
        result          : out    vl_logic_vector(15 downto 0)
    );
end alu;
