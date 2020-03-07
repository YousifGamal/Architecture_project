LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity checkDestRegDirect is
  port (
    NAF: in std_logic_vector (5 downto 0);
    IR5: in std_logic;
    IR4: in std_logic;
    IR3: in std_logic;
    checkDestRegDirectOut: out std_logic_vector (5 downto 0)
  ) ;
end checkDestRegDirect;


architecture checkDestRegDirect_arch of checkDestRegDirect is

    signal x: std_logic;

begin

    x<= ( not ( IR5 and (not IR4) and (not IR3) ));
    checkDestRegDirectOut(5 downto 0) <= NAF(5 downto 1) & x;  

end checkDestRegDirect_arch ; -- checkDestRegDirect_arch



