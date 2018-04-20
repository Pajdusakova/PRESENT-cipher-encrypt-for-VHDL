library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.array_roundkey.all;

entity present_encrypt_80 is
	port( clk: in std_logic;
			D3,D2,D1,D0: out std_logic_vector(7 downto 0));
end present_encrypt_80;

architecture rtl of present_encrypt_80 is
	signal plaintxt: std_logic_vector(63 downto 0) := (others=>'0');
	signal key: std_logic_vector(79 downto 0) := (others=>'0');
	signal crypt: std_logic_vector(63 downto 0);
	signal roundkey: rk;
	component show_16digit is
		port( clk: in std_logic;
				C: in std_logic_vector(63 downto 0);
				D3,D2,D1,D0: out std_logic_vector(7 downto 0));
	end component;
	component generateRoundKeys is
		port( X: in std_logic_vector(79 downto 0);
				Y: out rk);
	end component;
	component encryption is
		port( X: in std_logic_vector(63 downto 0);
				roundkey: in rk;
				Y: out std_logic_vector(63 downto 0));
	end component;
begin
	UU1:generateRoundKeys port map(key,roundkey);
	UU2:encryption port map(plaintxt,roundkey,crypt);
	U:show_16digit port map(clk,crypt,D3,D2,D1,D0);
end rtl;