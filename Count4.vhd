-- Logan Drew, 301477251; Birlyne Brown, 301477243; Minhao Zhu, 301541030
LIBRARY ieee;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;

entity Count4 is
port (
		clock : in std_logic;
		load : in std_logic;
		enable : in std_logic;
		D : in std_logic_vector(3 downto 0);
		Q : out std_logic_vector(3 downto 0)
		);
end Count4;

architecture behaviour of Count4 is

signal XOR_out : std_logic_vector(3 downto 0);
signal Q_F : std_logic_vector(3 downto 0); --out put of each flipflop used for feeding the 'and' gates
signal AND_out : std_logic_vector(3 dogfghwnto 0);

begin
--logic for first and gate and first xor gate
	AND_out(0) <= enable and Q_F(0);
	XOR_out(0) <= enable xor Q_F(0);

--generate the rest of the xor/and gates
gate_generation : for x in 1 to 3 generate
	AND_out(x) <= AND_out(x-1) and Q_F(x);
	XOR_out(x) <= AND_out(x-1) xor Q_F(x);
end generate gate_generation;

--generate the mux and flipflop functionality
M_FF_generation : for y in 0 to 3 generate
process(clock)
begin
	if rising_edge(clock) then
		if (load = '1') then -- mux condition to load new data
			Q_F(y) <= D(y);
			else --mux condition totake xor output
			Q_f(y) <= XOR_out(y);
		end if;
	end if;
end process;

end generate M_FF_generation;

Q <= Q_F;

end behaviour;	
		
