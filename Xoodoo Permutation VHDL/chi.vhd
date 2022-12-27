library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.spons.all;

entity chi is
  port( A0, A1, A2 : in plane;
		nA0, nA1, nA2 : out plane
		); 
end chi;

architecture chi0 of chi is 
	signal B0, B1, B2 : plane;
	begin
		process(B0, B1, B2, A0,A1,A2)
		begin
		for x in 0 to 3 loop
			for z in 0 to 31 loop
				B0(x,z) <= not(A1(x,z)) and A2(x,z);
				B1(x,z) <= not(A2(x,z)) and A0(x,z);
				B2(x,z) <= not(A0(x,z)) and A1(x,z);
			end loop;
		end loop;
		for x in 0 to 3 loop
			for z in 0 to 31 loop
				nA0(x,z) <= A0(x,z) xor B0(x,z);
				nA1(x,z) <= A1(x,z) xor B1(x,z);
				nA2(x,z) <= A2(x,z) xor B2(x,z);
			end loop;
		end loop;
		end process;
end chi0;
