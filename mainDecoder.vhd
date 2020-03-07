
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity mainDecoder is
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
end mainDecoder;

architecture mainDecoder_arch of mainDecoder is
    component reg16Rising is
        port (
          d: in std_logic_vector (15 downto 0);
          clk: in std_logic;
          clear: in std_logic;
      enable: in std_logic;
          q: out std_logic_vector (15 downto 0)
      
        ) ;
      end component reg16Rising;

      component decoder is
        port (
          IR: in std_logic_vector (15 downto 0);
          NAF: in std_logic_vector (5 downto 0);
          c: in std_logic;
          z: in std_logic;
          G7: in std_logic_vector(2 downto 0);
          decoderOut: out std_logic_vector(5 downto 0)
        ) ;
      end component decoder;
      component controlstore IS
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
        clr: in std_logic);
        END component controlstore;

    signal mpcIN,mpcOut: std_logic_vector (15 downto 0);
    signal mpcIN6bits,mpcOut6bits: std_logic_vector (5 downto 0);
    signal NAFsiganl: std_logic_vector (5 downto 0);
    signal G7signal: std_logic_vector (2 downto 0);
begin
    mpcIN(15 downto 0)<= "0000000000"& mpcIN6bits(5 downto 0);
    mpcOut6bits(5 downto 0) <= mpcOut(5 downto 0); 
    microPC: reg16Rising port map(mpcIN,clk,clr,'1',mpcOut);
    decoderline: decoder port map(IR,NAFsiganl,c,z,G7signal,mpcIN6bits);
    controlStoreLine: controlstore port map(mpcOut6bits,NAFsiganl,group1,group2decoded,group3decoded,group4decoded,group5decoded,group6decoded,G7signal,'1',clr);
    myAddres<=mpcOut6bits;
    nextAddres <=NAFsiganl;

    end mainDecoder_arch ; -- mainDecoder_arch
