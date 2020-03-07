LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity branchCheck is
  port (
    c: in std_logic;
    z: in std_logic;
    IR10: in std_logic;
    IR9: in std_logic;
    IR8: in std_logic;
    NAF: in std_logic_vector(5 downto 0);
    branchCheckOut: out std_logic_vector(5 downto 0)
  ) ;
end branchCheck;


architecture checkBranch_arch of branchCheck is
    component mux81 is
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
      end component mux81;

      component mux2_16bit is
        port (
          in1,in2: in std_logic_vector (5 downto 0);
      sel: in std_logic;
          mux_out: out std_logic_vector (5 downto 0)
          );
      end component mux2_16bit ;

    signal bne,blo,bls,bhs,muxSelectorBridge: std_logic;
    signal muxSelector: std_logic_vector (2 downto 0);

begin

    bne<= (not z);
    blo<= (not c);
    bls <= (not c) or z;
    bhs <= c or z; 
    muxSelector<= (IR10 & IR9 & IR8);
    muxLine: mux81 port map('1',z,bne,blo,bls,c,bhs,'0',muxSelector,muxSelectorBridge);
    muxline2: mux2_16bit port map("000000",NAF,muxSelectorBridge,branchCheckOut);

end checkBranch_arch ; -- checkBranch_arch
