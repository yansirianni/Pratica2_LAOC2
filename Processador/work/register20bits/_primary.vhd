library verilog;
use verilog.vl_types.all;
entity register20bits is
    generic(
        n               : integer := 20
    );
    port(
        R               : in     vl_logic_vector;
        Rin             : in     vl_logic;
        Clock           : in     vl_logic;
        Q               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end register20bits;
