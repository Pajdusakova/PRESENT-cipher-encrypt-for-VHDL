library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.array_roundkey.all;

entity encryption is
	port( X: in std_logic_vector(63 downto 0);
			roundkey: in rk;
			Y: out std_logic_vector(63 downto 0));
end encryption;

architecture rtl of encryption is
	component sBoxLayer is
		port( X: in std_logic_vector(63 downto 0);
				Y: out std_logic_vector(63 downto 0));
	end component;
	component pLayer is
		port( X: in std_logic_vector(63 downto 0);
				Y: out std_logic_vector(63 downto 0));
	end component;
	type temp is array(0 to 31) of std_logic_vector(63 downto 0);
	signal A: temp;	-- add roundkey
	signal S: temp;	-- through sBoxLayer
	signal P: temp;	-- permutated
	constant round: integer := 32;
begin
	P(0)<=X;
	encrypting: for i in 1 to round-1 generate
		A(i)<=P(i-1) xor roundkey(i);
		U1:sBoxLayer port map(A(i),S(i));
		U2:pLayer port map(S(i),P(i));
	end generate;
	Y<=P(round-1) xor roundkey(round);
end rtl;