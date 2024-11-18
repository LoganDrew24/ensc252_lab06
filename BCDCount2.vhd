-- Logan Drew, 301477251; Birlyne Brown, 301477243; Minhao Zhu, 301541030
LIBRARY ieee;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;

entity BCDCount2 is

port (
		clear, enable, clock : in std_logic;
		BCD0, BCD1 : out std_logic_vector(3 downto 0)
		);
end BCDCount2;

architecture behaviour of BCDCount2 is

component Count4 is

port (
		clock : in std_logic;
		load : in std_logic;
		enable : in std_logic;
		D : in std_logic_vector(3 downto 0);
		Q : out std_logic_vector(3 downto 0)
		);
end component;
signal and1, or1 : std_logic_vector(1 downto 0);
signal q1, q2 : std_logic_vector(3 downto 0);

begin

inst1 : Count4
port map (clock => clock, load => or1(0), enable => enable, D=> "0000", Q => q1);

inst2 : Count4
port map (clock => clock, load => or1(1), enable => and1(0), D=> "0000", Q => q2);

or1(0) <= and1(0) or clear;
or1(1) <= and1(1) or clear;

and1(0) <= q1(0) and q1(3);
and1(1) <= q2(0) and q2(3) and and1(0);
BCD0 <= q1;
BCD1 <= q2;

end behaviour;
