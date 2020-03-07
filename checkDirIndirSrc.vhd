LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity checkDirIndirSrc is
  port (
    NAF: in std_logic_vector (5 downto 0);
    IR9: in std_logic;
    checkDirIndirSrcOut: out std_logic_vector(5 downto 0)
  ) ;
end checkDirIndirSrc;


architecture checkDirIndirSrc_arch of checkDirIndirSrc is

    signal x: std_logic;


begin
    x<= NAF(0) or IR9;
    checkDirIndirSrcOut (5 downto 0) <= NAF(5 downto 1) & x;
	

end checkDirIndirSrc_arch ; -- arch

