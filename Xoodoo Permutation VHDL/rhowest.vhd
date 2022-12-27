library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.spons.all;

entity rhowest is
  port(   A1, A2 : in plane;
          nA1, nA2 : out plane
      );
end rhowest;

architecture rhowest0 of rhowest is 
begin
		process(A1,A2)
		begin
		for x in 0 to 3 loop
			for z in 0 to 31 loop
				nA1(x,z) <= A1((x-1) mod 4,z);
				nA2(x,z) <= A2(x,(z-11) mod 32);
				--A[x][1][z] <- A[x-1][1][z]
				--A[x][2][z] <- A[x][1][z-11]
			end loop;
		end loop;
		end process;
end rhowest0;
