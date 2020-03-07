LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity register32 is
  port (
    d: in std_logic_vector (31 downto 0);
    clk: in std_logic;
    clear: in std_logic;
enable: in std_logic;
    q: out std_logic_vector (31 downto 0)

  ) ;
end register32;

architecture register32_arch of register32 is
begin
    process( d,clk,clear )
    begin
        if (clear = '1') then
            q<=(others =>'0');
        elsif (rising_edge(clk) and enable='1') then
            q<=d;
        end if;
     end process ; -- identifier

end register32_arch ; 