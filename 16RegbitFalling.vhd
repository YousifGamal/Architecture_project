LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity reg16Falling is
  port (
    d: in std_logic_vector (15 downto 0);
    clk: in std_logic;
    clear: in std_logic;
enable: in std_logic;
    q: out std_logic_vector (15 downto 0)

  ) ;
end reg16Falling;

architecture reg16Falling_arch of reg16Falling is
begin
    process( d,clk,clear )
    begin
        if (clear = '1') then
            q<=(others =>'0');
        elsif (falling_edge(clk) and enable='1') then
            q<=d;
        end if;
     end process ; -- identifier

end reg16Falling_arch ;