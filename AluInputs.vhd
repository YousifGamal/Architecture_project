LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ALU_Input IS
PORT(
IR  	:  IN std_logic_vector(15 downto 0);
ALU_GEN :  IN std_logic_vector(1 downto 0);
ALUINPUT:  OUT std_logic_vector(4 downto 0)
);
END ALU_Input ;

ARCHITECTURE a_ALU_Input of ALU_Input is 

SIGNAL OUT1: std_logic_vector (4 downto 0);

--CONSTANT  SEL  :  std_logic  :=  IR(15) XNOR  IR(14) XNOR  IR(13) XNOR  IR(12) XNOR  IR(11) XNOR  IR(10);


SIGNAL  SEL : std_logic := '0';  


BEGIN

SEl <= NOT (IR(15) OR  IR(14) OR  IR(13) OR  IR(12) OR  IR(11) OR  IR(10));

OUT1 <=  SEL & IR(15 downto 12) WHEN SEL = '0' ELSE  SEL & IR(9 downto 6) ;

ALUINPUT <= "00100" WHEN ALU_GEN = "00"  ELSE
 	    "10001" WHEN ALU_GEN = "01"  ELSE
	    "10010" WHEN ALU_GEN = "10"  ELSE
 	    OUT1    WHEN ALU_GEN = "11" ; 

END a_ALU_Input ;