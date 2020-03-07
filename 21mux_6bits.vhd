LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity mux2_16bit is
  port (
    in1,in2: in std_logic_vector (5 downto 0);
sel: in std_logic;
    mux_out: out std_logic_vector (5 downto 0)
    );
end entity mux2_16bit ;

architecture mux2Arch_16bit  of mux2_16bit  is
begin
    mux_out <= in1 when sel='0'
		else in2;

end mux2Arch_16bit ;
