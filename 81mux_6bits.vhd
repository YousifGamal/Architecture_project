LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity mux81_6bits is
  port (
    inp0:in std_logic_vector(5 downto 0);
    inp1:in std_logic_vector(5 downto 0);
    inp2:in std_logic_vector(5 downto 0);
    inp3:in std_logic_vector(5 downto 0);
    inp4:in std_logic_vector(5 downto 0);
    inp5:in std_logic_vector(5 downto 0);
    inp6:in std_logic_vector(5 downto 0);
    inp7:in std_logic_vector(5 downto 0);
    sel: in std_logic_vector(2 downto 0);
    outp: out std_logic_vector(5 downto 0)

  ) ;
end mux81_6bits;

architecture mux81_6bits_arch of mux81_6bits is
    component mux2_16bit is
        port (
          in1,in2: in std_logic_vector (5 downto 0);
      sel: in std_logic;
          mux_out: out std_logic_vector (5 downto 0)
          );
      end component mux2_16bit ;
      
    
      component mux4_6bits is
        port (
          inp0: IN std_logic_vector (5 downto 0);
           inp1: IN std_logic_vector (5 downto 0);
       inp2: IN std_logic_vector (5 downto 0);
       inp3: IN std_logic_vector (5 downto 0);
          sel: in std_logic_vector (1 downto 0);
          mux_output: out std_logic_vector(5 downto 0)
        ) ;
      end component mux4_6bits ;
    
    signal x1,x2: std_logic_vector (5 downto 0);
	

begin

    mux1L: mux4_6bits port map(inp0,inp1,inp2,inp3, sel(1 downto 0), x1);
    mux2L: mux4_6bits port map(inp4,inp5,inp6,inp7, sel(1 downto 0), x2);
    mux3L: mux2_16bit port map(x1,x2,sel(2),outp);

end mux81_6bits_arch ; -- arch

