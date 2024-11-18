-- Logan Drew, 301477251; Birlyne Brown, 301477243; Minhao Zhu, 301541030
LIBRARY ieee;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;

entity TestReaction is
port (
		CLOCK_50 : in std_logic;
		KEY : in std_logic_vector(3 downto 0);
		SW : in std_logic_vector(9 downto 0);
		LEDR : out std_logic_vector(9 downto 0);
		HEX0, HEX1 : out std_logic_vector(6 downto 0)
		);
end TestReaction;

architecture behaviour of TestReaction is

component SegDecoder is
Port (
		D : in std_logic_vector( 3 downto 0 ); -- 4 input vector
		Y : out std_logic_vector( 6 downto 0 ) -- 7 output vector
		);
end component;

component BCDCount2 is
port (
		clear, enable, clock : in std_logic;
		BCD0, BCD1 : out std_logic_vector(3 downto 0)
		);
end component;

component PreScale is
port (clock_in : in std_logic;--declare ports for clock in and out
		clock_out : out std_logic
		);
end component;

signal and1, mux, enable, clock, q1, w, reset: std_logic; --single mux, and, reset, clock, 'w' signals
signal bcd0, bcd1 : std_logic_vector(3 downto 0); --decoder input
signal hex0, hex1 : std_logic_vector(6 downto 0); --decoder output

begin
--mux
mux <= '1' when (w = '1')
	else q1;
	
--and
and1 <= mux and not KEY(0);

--flipflop
process(clock)
begin
	if(rising_edge(clock)) then
		q1 <= and1;
	else
		q1 <= q1;
	end if
end process;

LEDR(0) <= not q1;

--need instances of segdecoder, prescale, and BCDCount2
inst1 : PreScale
port map (clock_in => CLOCK_50, clock_out => clock);
		
inst2 : BCDCount2
port map (clear => reset, enable => q1, BCD0 => bcd0, BCD1 => bcd1, clock => clock);

inst3 : SegDecoder
port map (D => bcd0, Y => HEX0);

inst4 : SegDecoder
port map (D => bcd1, Y => HEX1);

w <= SW(0);
reset <= SW(1);
end behaviour;
