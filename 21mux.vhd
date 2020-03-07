LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity mux2 is
  port (
    in1,in2,sel: in std_logic;
    mux_out: out std_logic
    );
end entity mux2;

architecture mux2Arch of mux2 is
begin
    mux_out <= in1 when sel='0'
		else in2;

end mux2Arch;