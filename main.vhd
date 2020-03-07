LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity main is
  port (
    main_input: in std_logic_vector (15 downto 0);
    dst: in std_logic_vector (1 downto 0);
    dst_enable : in std_logic;
    src: in std_logic_vector(1 downto 0);
    src_enable: in std_logic;
    reg_clear: in std_logic_vector(3 downto 0);
    clk : in std_logic;
    main_output: out std_logic_vector(15 downto 0)
  ) ;
end main;


architecture main_arch of main is
  component reg16Rising is
    port (
      d: in std_logic_vector (15 downto 0);
      clk: in std_logic;
      clear: in std_logic;
  enable: in std_logic;
      q: out std_logic_vector (15 downto 0)
  
    ) ;
  end component reg16Rising;

      component decoder42 is
        port ( d_input: in std_logic_vector (1 downto 0);
        d_enable: in std_logic;
        d_output: out std_logic_vector (3 downto 0)
        ) ;
      end component decoder42;

      component tristateBuffer is
        port (
          tsb_input: in std_logic_vector (15 downto 0);
          enable: in std_logic;
          tsb_output: out std_logic_vector (15 downto 0)
        ) ;
      end component tristateBuffer;

       signal theBus: std_logic_vector (15 downto 0);
    type mySignal is array (0 to 3) of std_logic_vector (15 downto 0);
	signal regiTri: mySignal;
    signal dstDecoderOut: std_logic_vector (3 downto 0);
    signal srcDecoderOut: std_logic_vector (3 downto 0);
    
    

begin
    theBus <= main_input;
    main_output <= theBus;
    dstDecoder:decoder42 PORT MAP(dst,dst_enable,dstDecoderOut);
    srcDecoder:decoder42 PORT MAP(src,src_enable,srcDecoderOut);
    
    loop1: FOR i IN 0 TO 3 GENERATE
    regs: reg16Rising PORT MAP(theBus,clk,reg_clear(i),dstDecoderOut(i),regiTri(i));
    tristatebuffers: tristateBuffer PORT MAP(regiTri(i),srcDecoderOut(i),theBus);
    END GENERATE loop1;
 
end main_arch ;
