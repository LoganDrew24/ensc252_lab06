-- Logan Drew, 301477251; Birlyne Brown, 301477243; Minhao Zhu, 301541030
LIBRARY ieee;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;

entity PreScale is
	port (clock_in : in std_logic;--declare ports for clock in and out
			clock_out : out std_logic;
			);
end PreScale;

architecture behaviour of PreScale is
signal f : unsigned(19 downto 0):=(others=>'0');--declared unsigned 20 bit signal to work as accumulator

begin
process(clock_in)
	begin
		if rising_edge(clock_in) then--if clock_in goes from 0 to 1...
			f <= f+1;--accumulate
		end if;
	end process;
	
clock_out <= f(19);--assign left most (MSB) bit to clock out
end behaviour;





			