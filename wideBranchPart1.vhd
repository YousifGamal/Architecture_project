LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity wideBranchPart1 is
  port (
      IR15: in std_logic;
      IR14: in std_logic;
      IR13: in std_logic;
      IR12: in std_logic;
      S1: out std_logic;
      S0 : out std_logic
  ) ;
end wideBranchPart1;


architecture wideBranchPart1_arch of wideBranchPart1 is

    component encoder42 is
        port (
            en_input: in std_logic_vector (3 downto 0);
            en_out: out std_logic_vector (1 downto 0)
        ) ;
      end component encoder42;
      signal encoder_in: std_logic_vector (3 downto 0);
      signal encoder_out: std_logic_vector (1 downto 0);
begin
    encoder_in(0)<= (not (IR15 or IR14 or IR13 or IR12));
    encoder_in(2)<= (IR15 and IR14 and IR13 and IR12);
    encoder_in(3)<= (IR15 and IR14 and IR13) and (not IR12);
    encoder_in(1)<= (not (encoder_in(0) or encoder_in(2) or encoder_in(3)));

    encoderLine:encoder42 PORT MAP(encoder_in,encoder_out);

    S1 <= encoder_out(1);
    S0 <= encoder_out(0);


end wideBranchPart1_arch ; -- arch
