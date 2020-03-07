
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity checkDirIndirDest is
  port (
    NAF: in std_logic_vector(5 downto 0);
    IR5: in std_logic;
    checkDirIndirDestOut: out std_logic_vector (5 downto 0)
  ) ;
end checkDirIndirDest;


architecture checkDirIndirDest_arch of checkDirIndirDest is

    signal x,y,z: std_logic;

begin
    x <=  NAF(2) xor IR5;
    y <= NAF(1) xor IR5;
    z <= NAF(0) xor IR5;
    checkDirIndirDestOut(5 downto 0) <= NAF(5 downto 3) & x & y & z;

end checkDirIndirDest_arch ; -- arch
