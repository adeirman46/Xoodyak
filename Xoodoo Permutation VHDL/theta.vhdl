library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.spons.all;

entity theta is
  port( in_A0, in_A1, in_A2 : in plane;
        nA0, nA1, nA2 : out plane
      );
end theta;

architecture theta0 of theta is
	signal P, E, thA0,thA1,thA2 : plane;
	
	begin
	
		process(thA0,thA1,thA2,P,E,in_A0,in_A1,in_A2)
		begin
		thA0 <= in_A0;
		thA1 <= in_A1;
		thA2 <= in_A2;
		
		 for x in 0 to 3 loop
			for z in 0 to 31 loop
				 P(x,z) <= thA0(x,z) xor thA1(x,z) xor thA2(x,z);
		   end loop;
		 end loop;
		
		for x in 0 to 3 loop
			for z in 0 to 31 loop
				E(x,z) <= P((x-1) mod 4,(z-5) mod 32) xor P((x-1) mod 4,(z-14) mod 32);
				--E(x,z) <= P(x-1,z-5) xor P(x-1,z-14);]
			end loop;
		end loop;
		
		for x in 0 to 3 loop
			for z in 0 to 31 loop
				nA0(x,z) <=  thA0(x,z) xor E(x,z);
				nA1(x,z) <=  thA1(x,z) xor E(x,z);
				nA2(x,z) <=  thA2(x,z) xor E(x,z);
		  end loop;
		end loop;
		end process;
end theta0;