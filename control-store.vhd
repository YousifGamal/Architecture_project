
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY controlstore IS
	PORT(
		micropc : IN  std_logic_vector(5 DOWNTO 0);
		nextAddress : OUT std_logic_vector(5 DOWNTO 0);
		group1 : OUT std_logic_vector(1 DOWNTO 0);
 		 group2decoded : OUT std_logic_vector (7 DOWNTO 0);
		 group3decoded : OUT std_logic_vector (7 DOWNTO 0);
		 group4decoded : OUT std_logic_vector (3 DOWNTO 0); 
		 group5decoded : OUT std_logic_vector (3 DOWNTO 0);
		 group6decoded : OUT std_logic_vector (3 DOWNTO 0);
		group7 : OUT std_logic_vector(2 DOWNTO 0);
		d_enable : IN std_logic;
		clr: in std_logic
		);
END ENTITY controlstore;

ARCHITECTURE syncrama OF controlstore IS

	TYPE ram_type IS ARRAY(0 TO 44) OF std_logic_vector(22 DOWNTO 0);
	SIGNAL ram : ram_type := (
	0 => "00000101001011010001000",
	1 => "00001000011001000000000",
	2 => "00001100010010000000000",
	3 => "00000000000000000000001",
	4 => "00011000001000000100010",
	5 => "00000000000000000000000", 
	6 => "00011100111011000000000",
	7 => "00000000011001000000000",
	8 => "01011000100000001000000",
	9 => "01010100100000010001000",
	10 => "00101101100011010001000",
	11 => "01001100011100000000000",
	12 => "00110110100011000000000",
	13 => "01001100011100010001000",
	14 => "00111101001011010001000",
	15 => "01000000011001000000000",
	16 => "01000100010000000100000",
	17 => "01001000100011000000000",
	18 => "01001100011000010001000",
	19 => "01010000000000000000011",
	20 => "01010100010000010001000",
	21 => "01011000010000001000000",
	22 => "01000000000000000000101",
	23 => "10010000101000100000000",
	24 => "10010000101000010001000",
	25 => "01101001101011010001000",
	26 => "10001000011101000000000",
	27 => "01110010101011000000000",
	28 => "10001000011101010001000",
	29 => "01111001001011010001000",
	30 => "01111100011001000000000",
	31 => "10000000010000000100000",
	32 => "10000100101011000000000",
	33 => "10001000011000010001000",
	34 => "10001100000000000000100", 
	35 => "10010000010000010001000",
	36 => "10010100110000000100000",
	37 => "10011111010011000000000",
	38 => "10011111000011000000000",
	39 => "10100000000000000000110",
	40 => "00000000011101000000000",
	41 => "00000000011000100010000",
	42 => "00000000000000000000000",
	43 => "10110000000000000000000",
	44 => "10110000000000000000000"	
	);

	SIGNAL group2 : std_logic_vector(2 DOWNTO 0);
	SIGNAL group3 : std_logic_vector(2 DOWNTO 0);
	SIGNAL group4 : std_logic_vector(1 DOWNTO 0);
	SIGNAL group5 : std_logic_vector(1 DOWNTO 0);
	SIGNAL group6 : std_logic_vector(1 DOWNTO 0);


      component decoder42 is
        port ( d_input: in std_logic_vector (1 downto 0);
        d_enable: in std_logic;
        d_output: out std_logic_vector (3 downto 0)
        ) ;
      end component decoder42;

	component decoder38 is
  	port ( d_input: in std_logic_vector (2 downto 0);
  	d_enable: in std_logic;
  	d_output: out std_logic_vector (7 downto 0)
  	) ;
	end component decoder38;

	SIGNAL microinst :  std_logic_vector(22 DOWNTO 0);
	BEGIN	
		
		microinst <= ram(to_integer(unsigned(micropc)));
		nextAddress <= microinst(22 DOWNTO 17);
		group1 <= microinst(16 DOWNTO 15);
		group2 <= microinst(14 DOWNTO 12);
		group3 <= microinst(11 DOWNTO 9);
		group4 <= microinst(8 DOWNTO 7);
		group5 <= microinst(6 DOWNTO 5);
		group6 <= microinst(4 DOWNTO 3); 
		group7 <= microinst(2 DOWNTO 0) when clr = '0' else 
						"111";
		
		gp2:decoder38 PORT MAP(group2,d_enable,group2decoded);
		gp3:decoder38 PORT MAP(group3,d_enable,group3decoded);
		gp4:decoder42 PORT MAP(group4,d_enable,group4decoded);
		gp5:decoder42 PORT MAP(group5,d_enable,group5decoded);
		gp6:decoder42 PORT MAP(group6,d_enable,group6decoded);
		
END syncrama;
