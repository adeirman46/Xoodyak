library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 

package spons is
    type lane is array(0 to 31) of std_logic;
    type plane is array(0 to 3,0 to 31) of std_logic;
end package;

package body spons is
	function rot(p:plane,x:integer,z:integer,X:integer,Z:integer) return std_logic is
		variable rotres : std_logic;
	--fungsi shift, p untuk plane, xz buat isi loopingnya
	--contoh pemakaian: rot(A0,x-1,z-14)
	--belum dites
	begin
		rotres : p((x mod 4,z mod 32)
		return rotres;
end package body spons;