LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity mux4 is
  port (
    inp: IN std_logic_vector (3 downto 0);
    sel: in std_logic_vector (1 downto 0);
    mux_output: out std_logic
  ) ;
end mux4;

architecture mux4Arch of mux4 is
component mux2 is
    port (
      in1,in2,sel: in std_logic;
      mux_out: out std_logic
      );
  end component mux2;
  signal s1,s2 :std_logic;

begin
    l0: mux2 port map(inp(0),inp(1),sel(0),s1);
    l1: mux2 port map(inp(2),inp(3),sel(0),s2);
    l2: mux2 port map(s1,s2,sel(1),mux_output);

end mux4Arch ; 
