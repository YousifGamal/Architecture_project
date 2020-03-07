LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity decoder is
  port (
    IR: in std_logic_vector (15 downto 0);
    NAF: in std_logic_vector (5 downto 0);
    c: in std_logic;
    z: in std_logic;
    G7: in std_logic_vector(2 downto 0);
    decoderOut: out std_logic_vector(5 downto 0)
  ) ;
end decoder;


architecture decoder_arch of decoder is
    component wideBranch is
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
      end component wideBranch;

      component branchCheck is
        port (
          c: in std_logic;
          z: in std_logic;
          IR10: in std_logic;
          IR9: in std_logic;
          IR8: in std_logic;
          NAF: in std_logic_vector(5 downto 0);
          branchCheckOut: out std_logic_vector(5 downto 0)
        ) ;
      end component branchCheck;

      component checkDirIndirSrc is
        port (
          NAF: in std_logic_vector (5 downto 0);
          IR9: in std_logic;
          checkDirIndirSrcOut: out std_logic_vector(5 downto 0)
        ) ;
      end component checkDirIndirSrc;

      component checkDirIndirDest is
        port (
          NAF: in std_logic_vector(5 downto 0);
          IR5: in std_logic;
          checkDirIndirDestOut: out std_logic_vector (5 downto 0)
        ) ;
      end component checkDirIndirDest;

      component destBranch is
        port (
          IR3: in std_logic;
          IR4: in std_logic;
          IR5: in std_logic;
          destBranchOut:out std_logic_vector(5 downto 0)
        ) ;
      end component destBranch;

      component checkDestRegDirect is
        port (
          NAF: in std_logic_vector (5 downto 0);
          IR5: in std_logic;
          IR4: in std_logic;
          IR3: in std_logic;
          checkDestRegDirectOut: out std_logic_vector (5 downto 0)
        ) ;
      end component checkDestRegDirect;


      component mux81_6bits is
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
      end component mux81_6bits;

    
    signal m1,m2,m3,m4,m5,m6 : std_logic_vector(5 downto 0);


begin
    checkDestRegDirectLine: checkDestRegDirect port map(NAF,IR(5),IR(4),IR(3),m6);
    destBranchLine: destBranch port map(IR(3),IR(4),IR(5),m5);
    checkDirIndirDestLine: checkDirIndirDest port map(NAF,IR(5),m4);
    checkDirIndirSrcLine: checkDirIndirSrc port map(NAF,IR(9),m3);
    branchCheckLine: branchCheck port map(c,z,IR(10),IR(9),IR(8),NAF,m2);
    wideBranchLine: wideBranch port map(IR(15),IR(14),IR(13),IR(12),IR(11),IR(10),IR(9),IR(0),m1);

    mux81_6bitsLine: mux81_6bits port map(NAF,m1,m2,m3,m4,m5,m6,"000000",G7,decoderOut);

end decoder_arch ; -- arch
