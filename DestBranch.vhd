LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity destBranch is
  port (
    IR3: in std_logic;
    IR4: in std_logic;
    IR5: in std_logic;
    destBranchOut:out std_logic_vector(5 downto 0)
  ) ;
end destBranch;


architecture destBranch_arch of destBranch is

    signal x,y,w,z: std_logic;

begin
  destBranchOut <= "010111" when IR3='0' and IR4 = '0' and IR5 = '1'
                  else "011000" when IR3='0' and IR4 = '0' and IR5 = '0'
                  else "011001" when IR3='1' and IR4 = '0' 
                  else "011011" when IR3='0' and IR4 = '1'
                  else "011101" when IR3='1' and IR4 = '1'; 


end destBranch_arch ; -- arch
