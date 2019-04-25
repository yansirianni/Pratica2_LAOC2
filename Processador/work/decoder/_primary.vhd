library verilog;
use verilog.vl_types.all;
entity decoder is
    generic(
        N               : integer := 4
    );
    port(
        DataIn          : in     vl_logic_vector;
        DataOut         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end decoder;
