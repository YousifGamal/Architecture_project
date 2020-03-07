LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY half_adder IS 
	PORT(A,B: IN std_logic; SUM,CARRY: OUT std_logic);
END ENTITY half_adder;

architecture ha_dataflow of half_adder  is
begin
SUM <= A xor B;

CARRY <= A and B;
end ha_dataflow;