LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
-- n-bit adder

ENTITY nbits_adder IS
GENERIC (n : integer := 16);

PORT(a,b : IN std_logic_vector(n-1 DOWNTO 0);
     s   : OUT std_logic_vector(n-1 DOWNTO 0);
     cin : IN std_logic;
    cout : OUT std_logic);

END nbits_adder;

ARCHITECTURE nadder_mix OF nbits_adder IS

COMPONENT full_adder IS 
	PORT(A,B,Cin: IN std_logic;
	     SUM,Cout: OUT std_logic);
END COMPONENT;

SIGNAL temp : std_logic_vector(n-1 DOWNTO 0);
BEGIN

f0: full_adder PORT MAP(a(0),b(0),cin,s(0),temp(0));
loop1: FOR i IN 1 TO n-1 GENERATE
fx: full_adder PORT MAP(a(i),b(i),temp(i-1),s(i),temp(i));
END GENERATE;
cout <= temp(n-1);

END nadder_mix;