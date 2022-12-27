library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.spons.all;

entity rhoeast is
  port(   A0, A1, A2 : in plane;
          nA0, nA1, nA2 : out plane
      );
end rhoeast;

architecture rhoeast0 of rhoeast is 
begin
		process(A0,A1,A2)
		begin
	
		for x in 0 to 3 loop
			for z in 0 to 31 loop
				nA0(x,z) <= A0(x,z);
				nA1(x,z) <= A1(x,(z-1) mod 32);
				nA2(x,z) <= A2((x-2) mod 4,(z-8) mod 32);
				--A[x][1][z] <- A[x][1][z-1]
				--A[x][2][z] <- A[x-2][1][z-8]
			end loop;
		end loop;
		end process;
end rhoeast0;
