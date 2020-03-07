LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY full_adder IS 
	PORT(A,B,Cin: IN std_logic;
	     SUM,Cout: OUT std_logic);
END ENTITY full_adder ;

architecture fa_mix of full_adder is

COMPONENT half_adder IS 
	PORT(A,B: IN std_logic; SUM,CARRY: OUT std_logic);
END COMPONENT;
signal i1, i2, i3 : std_logic;
begin
u1 : half_adder port map (A, B, i2, i1);
u2 : half_adder port map (i2, Cin, SUM, i3);
Cout <= i3 OR i1;
end fa_mix;
