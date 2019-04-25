library verilog;
use verilog.vl_types.all;
entity processor is
    port(
        DataIn          : in     vl_logic_vector(19 downto 0);
        Reset           : in     vl_logic;
        Clock           : in     vl_logic;
        Dout            : out    vl_logic_vector(19 downto 0);
        Daddress        : out    vl_logic_vector(19 downto 0);
        W               : out    vl_logic
    );
end processor;
