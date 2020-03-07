LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity dFlipFlop is
  port (
    d: in std_logic;
    clk : in std_logic;
    rst: in std_logic;
    q : out std_logic
  ) ;
end dFlipFlop;


architecture dFlipFlop_arch of dFlipFlop is


begin
     process( rst,clk )
    begin
        if (rst = '1') then
            q<='0';
        elsif rising_edge(clk) then
            q <=d;
        end if; 
            
    end process ; -- identifier

end dFlipFlop_arch ; 
