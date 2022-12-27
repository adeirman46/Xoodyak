library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.spons.all;

entity iota is
  port(   A0 : in plane;
		  Ci : in lane;
          nA0 : out plane
      );
end iota;

architecture iota0 of iota is 
begin
		process(A0,Ci)
		begin
		for z in 0 to 31 loop
			nA0(0,z) <= A0(0,z) xor Ci(z);
			nA0(1,z) <= A0(1,z);
			nA0(2,z) <= A0(2,z);
			nA0(3,z) <= A0(3,z);
		end loop;
		end process;
end iota0;
