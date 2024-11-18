-- Logan Drew, 301477251; Birlyne Brown, 301477243; Minhao Zhu, 301541030
LIBRARY ieee;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;

entity TestBCDCount2 is
port (
		SW : in std_logic_vector(9 downto 0);
		KEY : in std_logic_vector(3 downto 0);
		LEDR : out std_logic_vector(9 downto 0)
		);
end TestBCDCount2;

architecture behaviour of TestBCDCount2 is

component BCDCount2 is
port (
		clear, enable, clock : in std_logic;
		BCD0, BCD1 : out std_logic_vector(3 downto 0)
		);
end component;

begin
inst1 : BCDCount2
--in order to have the keys be active when pressed, have NOT key...
port map (clear => not KEY(0), clock => not KEY(1), enable => SW(0), BCD0 => LEDR(3 downto 0), BCD1 => LEDR(7 downto 4));
end behaviour;
		
