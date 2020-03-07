LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity wideBranch is
  port (
    IR15: in std_logic;
    IR14: in std_logic;
    IR13: in std_logic;
    IR12: in std_logic;
    IR11: in std_logic;
    IR10: in std_logic;
    IR9: in std_logic;
    IR0: in std_logic;
    WideBranchOut: out std_logic_vector(5 downto 0)
  ) ;
end wideBranch;

architecture wideBranch_arch of wideBranch is

    component wideBranchPart1 is
        port (
            IR15: in std_logic;
            IR14: in std_logic;
            IR13: in std_logic;
            IR12: in std_logic;
            S1: out std_logic;
            S0 : out std_logic
        ) ;
      end component wideBranchPart1;

      component wideBranchPart2 is
        port (
          IR11: in std_logic;
          IR10: in std_logic;
          IR9: in std_logic;
          IR0: in std_logic;
          S: in std_logic_vector(1 downto 0);
          wideBranch2out: out std_logic_vector(5 downto 0)
        ) ;
      end component wideBranchPart2;
      

    signal selectoresBridge: std_logic_vector (1 downto 0);
    signal outputBridge: std_logic_vector(5 downto 0);

begin
part1Line: WideBranchPart1 port map(IR15,IR14,IR13,IR12,selectoresBridge(1),selectoresBridge(0));
part2Line: wideBranchPart2 port map(IR11,IR10,IR9,IR0,selectoresBridge,outputBridge);
WideBranchOut<=outputBridge;

end wideBranch_arch ; -- wideBranch_arch
