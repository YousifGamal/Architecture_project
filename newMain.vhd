LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity mianEnt is
  port (
    clr: in std_logic;
    clk: in std_logic;
    outMain: out std_logic_vector (15 downto 0)
  ) ;
end mianEnt;

architecture mianEnt_arch of mianEnt is

    component reg16Rising is
        port (
          d: in std_logic_vector (15 downto 0);
          clk: in std_logic;
          clear: in std_logic;
      enable: in std_logic;
          q: out std_logic_vector (15 downto 0)

        ) ;
      end component reg16Rising;

      component reg16Falling is
        port (
          d: in std_logic_vector (15 downto 0);
          clk: in std_logic;
          clear: in std_logic;
      enable: in std_logic;
          q: out std_logic_vector (15 downto 0)
      
        ) ;
      end component reg16Falling;

      component mdr_register IS

      PORT( Clk,Rst : IN std_logic;
      	    d,d2 : IN std_logic_vector(15 DOWNTO 0);
      	    q : OUT std_logic_vector(15 DOWNTO 0);
      	enable,enable2: in std_logic
      );

      END component mdr_register;

      component tristateBuffer is
        port (
          tsb_input: in std_logic_vector (15 downto 0);
          enable: in std_logic;
          tsb_output: out std_logic_vector (15 downto 0)
        ) ;
      end component tristateBuffer;

      component mainDecoder is
        port (
          IR: in std_logic_vector(15 downto 0);
          c: in std_logic;
          z: in std_logic;
          clk: in std_logic;
          clr: in std_logic;
          group1 : OUT std_logic_vector(1 DOWNTO 0);
       	group2decoded : OUT std_logic_vector (7 DOWNTO 0);
      	group3decoded : OUT std_logic_vector (7 DOWNTO 0);
      	group4decoded : OUT std_logic_vector (3 DOWNTO 0);
      	group5decoded : OUT std_logic_vector (3 DOWNTO 0);
          group6decoded : OUT std_logic_vector (3 DOWNTO 0);
          myAddres: out std_logic_vector (5 downto 0);
          nextAddres: out std_logic_vector (5 downto 0)

        ) ;
      end component mainDecoder;

      component zreg16Rising is
        port (
          d: in std_logic_vector (15 downto 0);
          clk: in std_logic;
          clear: in std_logic;
      enable: in std_logic;
          q: out std_logic_vector (15 downto 0)

        ) ;
      end component zreg16Rising;
      
      
      component decoder38 is
        port ( d_input: in std_logic_vector (2 downto 0);
        d_enable: in std_logic;
        d_output: out std_logic_vector (7 downto 0)
        ) ;
      end component decoder38;

      component ram IS
        PORT(
        clk : IN std_logic;
        we  : IN std_logic;
        address : IN  std_logic_vector(15 DOWNTO 0);
        datain  : IN  std_logic_vector(15 DOWNTO 0);
        dataout : OUT std_logic_vector(15 DOWNTO 0));
      END component  ram;


      component ALU IS
        PORT(
        --SEL  	       :  IN std_logic_vector(4 downto 0);
        INPUTA ,INPUTB :  IN std_logic_vector(15 downto 0);
        ALUOUT         :  OUT std_logic_vector(15 downto 0);
        IR  	       :  IN std_logic_vector(15 downto 0);
        ALU_GEN        :  IN std_logic_vector(1 downto 0);
        REGFLAGIN      :  IN std_logic_vector(4 downto 0);   -- carry - zero - negative - partiy - overflow
        REGFLAGOUT     :  OUT std_logic_vector(4 downto 0)
        --ALUINPUT:  OUT std_logic_vector(4 downto 0)
        );
      END component ALU ;




      signal IR,MAR,Y,Source,RamData,MDR,FlagReg,FlagRegIn,IRtemp: std_logic_vector(15 downto 0);
      signal BusData: std_logic_vector(15 downto 0);
      signal IRin,MARin,Yin,Sourcein,RD,MDRin,Sourceout,MDRout: std_logic;
      signal c,z: std_logic;
      type mySignal is array (0 to 7) of std_logic_vector (15 downto 0);
      signal regiTri: mySignal;
      signal Registerin,Registerout: std_logic_vector(7 downto 0);
      signal g1: std_logic_vector(1 downto 0);
      signal g2d,g3d: std_logic_vector(7 downto 0);
      signal g4d,g5d,g6d: std_logic_vector(3 downto 0);
      signal RsrcsOutEnables,RsrcsinEnables: std_logic_vector (7 downto 0);
      signal RdestsOutEnables,RdestsinEnables: std_logic_vector (7 downto 0);
      signal AluOut,Zreg: std_logic_vector (15 downto 0);
      signal regFlaginn,regFlagOuttt: std_logic_vector (4 downto 0);

      -----------------------------
      signal myAddres: std_logic_vector (5 downto 0);
      signal nextAddres: std_logic_vector (5 downto 0);

begin
RdestInDecoder: decoder38 port map(IR(2 downto 0),g3d(5),RdestsinEnables);
RdestOutDecoder: decoder38 port map(IR(2 downto 0),g2d(5),RdestsOutEnables);  
RsrcInDecoder: decoder38 port map(IR(8 downto 6),g3d(4),RsrcsinEnables);
RsrcOutDecoder: decoder38 port map(IR(8 downto 6),g2d(4),RsrcsOutEnables);


-----------------------------------------------------------

outMain <= BusData;

---------------------------------------------------------------

regFlaginn(4 downto 0) <= FlagReg(4 downto 0);
FlagRegIn(15 downto 0) <= "00000000000" & regFlagOuttt(4 downto 0);

ALfuckingU: ALU port map(BusData,Y,AluOut,IR,g1,regFlaginn,regFlagOuttt);

----------------------------------------------

ZRegister: zreg16Rising port map(AluOut,clk,clr,g3d(3),Zreg);
triBufferZ: tristateBuffer port MAP(Zreg,g2d(3),BusData);


-------------------------------------------------------------------

RamLine:ram port map(clk,g6d(2),MAR,MDR,RamData);

----------------------------------------------------------------
c<=FlagReg(0);
z<=FlagReg(1);
mainDecoderLine: mainDecoder port map(IR,c,z,clk,clr,g1,g2d,g3d,g4d,g5d,g6d,myAddres,nextAddres);

--------------------------------------------------------------------------------
IRin <= g3d(2);
IRtemp(15 downto 0)  <= "00000000" & IR(7 downto 0) WHEN IR(7) = '0' ELSE
		        "11111111" & IR(7 downto 0) ;
IRregister:reg16Falling port map(BusData,clk,clr,IRin,IR);
triBufferIRaddd: tristateBuffer port MAP(IRtemp,g2d(7),BusData);

---------------------------------------------------------------------------------

MARregister: reg16Falling port map(BusData,clk,clr,g4d(1),MAR);

--------------------------------------------------------------------------------

YRegister: reg16Rising port map(BusData,clk,clr,g5d(1),Y);

--------------------------------------------------------------------------------

FlagRegister: reg16Rising port map(FlagRegIn,clk,clr,'1',FlagReg);

-----------------------------------------------------------------------------------

-- 7 registres and their enables
Registerout(6 downto 0) <= RdestsOutEnables(6 downto 0) or RsrcsOutEnables(6 downto 0);
Registerin(6 downto 0) <= RdestsinEnables(6 downto 0) or RsrcsinEnables(6 downto 0);
-- for PC R7 register special case
Registerout(7) <= RdestsOutEnables(7) or RsrcsOutEnables(7) or g2d(1);
Registerin(7) <= RdestsinEnables(7) or RsrcsinEnables(7) or g3d(1);
loop1: FOR i IN 0 TO 7 GENERATE
regs: reg16Rising PORT MAP(BusData,clk,clr,Registerin(i),regiTri(i));
tristatebuffers: tristateBuffer PORT MAP(regiTri(i),Registerout(i),BusData);
END GENERATE loop1;

------------------------------------------------------------------

sourceRegister: reg16Rising port map(BusData,clk,clr,g5d(2),Source);
triBufferSource: tristateBuffer port MAP(Source,g2d(6),BusData);

-----------------------------------------------------------------------

MDRRegister: mdr_register port map(clk,'0',BusData,RamData,MDR,g4d(2),g6d(1));
triBufferMDR: tristateBuffer port map(MDR,g2d(2),BusData);

------------------------------------------------------------------------









end mianEnt_arch ; -- arch
