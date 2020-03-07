LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity mux81 is
  port (
    inp0:in std_logic;
    inp1:in std_logic;
    inp2:in std_logic;
    inp3:in std_logic;
    inp4:in std_logic;
    inp5:in std_logic;
    inp6:in std_logic;
    inp7:in std_logic;
    sel: in std_logic_vector(2 downto 0);
    outp: out std_logic

  ) ;
end mux81;

architecture mux81_arch of mux81 is
    component mux2 is
        port (
          in1,in2,sel: in std_logic;
          mux_out: out std_logic
          );
      end component mux2;
      
    
    component mux4 is
        port (
          inp: IN std_logic_vector (3 downto 0);
          sel: in std_logic_vector (1 downto 0);
          mux_output: out std_logic
        ) ;
      end component mux4;
    
    signal x1,x2: std_logic;
	signal s1,s2: std_logic_vector (3 downto 0);

begin
s1<=(inp3 & inp2 & inp1 & inp0);
s2<=(inp7 & inp6 & inp5 & inp4);
    mux1L: mux4 port map(s1 , sel(1 downto 0), x1);
    mux2L: mux4 port map(s2 , sel(1 downto 0), x2);
    mux3L: mux2 port map(x1,x2,sel(2),outp);

end mux81_arch ; -- arch
