LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity wideBranchPart2 is
  port (
    IR11: in std_logic;
    IR10: in std_logic;
    IR9: in std_logic;
    IR0: in std_logic;
    S: in std_logic_vector(1 downto 0);
    wideBranch2out: out std_logic_vector(5 downto 0)
  ) ;
end wideBranchPart2;


architecture wideBranchPart2_arch of wideBranchPart2 is

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


    signal F: std_logic_vector (5 downto 0);
    signal muxesBridge: std_logic_vector (5 downto 0);
    signal outBridger: std_logic_vector(5 downto 0);


begin

    F(5)<= '0';
    F(4)<= '0';
    F(3)<= '1';
    F(2)<= IR11;
    F(1)<= IR10;
    F(0)<= (not (IR10 or IR11 OR IR9));
    mux2Line: mux2_16bit port map("101010","101011",IR0,muxesBridge );
    mux4line: mux4_6bits port map("010110",F,"000100",muxesBridge,S,outBridger);
    wideBranch2out<= outBridger;



end wideBranchPart2_arch ; -- wideBranchPart2_arch
