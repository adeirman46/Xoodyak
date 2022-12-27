library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.spons.all;

entity redefine is
port ( print : in std_logic;
		xA0, xA1, xA2 : in plane;
		nA0, nA1, nA2 : out plane
		);
end redefine;

architecture redef of redefine is
begin
	process(xA0,xA1,xA2)
	begin
	if print='1' then
		nA0 <= xA0;
		nA1 <= xA1;
		nA2 <= xA2;
	end if;
	end process;
end redef;