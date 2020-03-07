LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity zreg16Rising is
  port (
    d: in std_logic_vector (15 downto 0);
    clk: in std_logic;
    clear: in std_logic;
enable: in std_logic;
    q: out std_logic_vector (15 downto 0)

  ) ;
end zreg16Rising;

architecture zreg16Rising_arch of zreg16Rising is
begin
    process( d,clk,clear )
    begin
        if (clear = '1') then
            q<="0000000000000001";
        elsif (rising_edge(clk) and enable='1') then
            q<=d;
        end if;
     end process ; -- identifier

end zreg16Rising_arch ; 