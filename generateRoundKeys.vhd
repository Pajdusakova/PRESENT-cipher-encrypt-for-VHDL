library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

library work;
use work.array_roundkey.all;

entity generateRoundKeys is
	port( X: in std_logic_vector(79 downto 0);
			Y: out rk);
end generateRoundKeys;

architecture rtl of generateRoundKeys is
	type s is array(0 to 15) of std_logic_vector(3 downto 0);
	constant sbox: s := ("1100", "0101", "0110", "1011", "1001", "0000", "1010", "1101", "0011", "1110", "1111", "1000", "0100", "0111", "0001", "0010");
	type temp is array(0 to 32) of std_logic_vector(79 downto 0);
	signal R: temp;	--rotate shifted
	signal C: temp;	--sbox converted
	signal A: temp;	--add counter
begin
	Y(1)<=X(79 downto 16);
	A(0)<=X;
--	R(1)<=to_stdlogicvector(to_bitvector(X) ror 19);
--	C(1)<=sbox(conv_integer(R(1)(79 downto 76))) & R(1)(75 downto 0);
--	A(1)<=C(1) xor to_stdlogicvector(to_bitvector(conv_std_logic_vector(1, 5)) sll 15);
--	Y(2)<=A(1)(79 downto 16);
	generateKeys: for i in 1 to 31 generate
		R(i)<=to_stdlogicvector(to_bitvector(A(i-1)) ror 19);
		C(i)<=sbox(conv_integer(R(i)(79 downto 76))) & R(i)(75 downto 0);
		A(i)<=C(i) xor to_stdlogicvector(to_bitvector(conv_std_logic_vector(i, 64)) sll 15);
		Y(i+1)<=A(i)(79 downto 16);
	end generate;
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("000001") sll 15);
--	Y(2)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("000010") sll 15);
--	Y(3)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("000011") sll 15);
--	Y(4)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("000100") sll 15);
--	Y(5)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("000101") sll 15);
--	Y(6)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("000110") sll 15);
--	Y(7)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("000111") sll 15);
--	Y(8)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("001000") sll 15);
--	Y(9)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("001001") sll 15);
--	Y(10)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("001010") sll 15);
--	Y(11)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("001011") sll 15);
--	Y(12)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("001100") sll 15);
--	Y(13)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("001101") sll 15);
--	Y(14)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("001110") sll 15);
--	Y(15)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("001111") sll 15);
--	Y(16)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("010000") sll 15);
--	Y(17)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("010001") sll 15);
--	Y(18)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("010010") sll 15);
--	Y(19)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("010011") sll 15);
--	Y(20)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("010100") sll 15);
--	Y(21)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("010101") sll 15);
--	Y(22)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("010110") sll 15);
--	Y(23)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("010111") sll 15);
--	Y(24)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("011000") sll 15);
--	Y(25)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("011001") sll 15);
--	Y(26)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("011010") sll 15);
--	Y(27)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("011011") sll 15);
--	Y(28)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("011100") sll 15);
--	Y(29)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("011101") sll 15);
--	Y(30)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("011110") sll 15);
--	Y(31)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("011111") sll 15);
--	Y(32)<=C(79 downto 16);
--	C<=to_stdlogicvector(to_bitvector(C) ror 19);
--	C<=sbox(conv_integer(C(79 downto 76))) & C(75 downto 0);
--	C<=C xor to_stdlogicvector(to_bitvector("100000") sll 15);
end rtl;