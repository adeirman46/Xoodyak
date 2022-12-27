library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 
use work.spons.all;

entity fsm is 
	port( proceed, rst, clk : in std_logic;
		xA0, xA1, xA2, in_A0, in_A1, in_A2 : in plane;
		A0, A1, A2 : out plane;
		print: out std_logic; 
		Ci: out lane 
		); 
end fsm; 

architecture fsm_arc of fsm is 
	type states is ( init, s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 ); 
	signal cState, nState: states; 
	
begin 
	process( proceed, rst, clk ) 
	begin 
	if( rst = '1' ) then 
		cState <= init; 
	elsif( clk'event and clk = '1' ) then 
		cState <= nState; 
	end if; 
	end process; 
	
	process(proceed,nState,cState) 
	begin 
	case cState is 
		when init =>
			if( proceed = '0' ) then nState <= init; 
			else nState <= s0; 
			end if; 
		when s0 => 
			A0 <= in_A0;
			A1 <= in_A1;
			A2 <= in_A2;
			print <= '0';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(3) <= '1';
			Ci(4) <= '1';
			Ci(6) <= '1';
			nState <= s1; 
		when s1 =>
			A0 <= xA0;
			A1 <= xA1;
			A2 <= xA2;
			print <= '0';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(3) <= '1';
			Ci(4) <= '1';
			Ci(5) <= '1';
			nState <= s2; 
		when s2 => 
			A0 <= xA0;
			A1 <= xA1;
			A2 <= xA2;
			print <= '0';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(6) <= '1';
			Ci(7) <= '1';
			Ci(8) <= '1';
			Ci(9) <= '1';
			nState <= s3; 
		when s3 => 
			A0 <= xA0;
			A1 <= xA1;
			A2 <= xA2;
			print <= '0';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(4) <= '1';
			Ci(6) <= '1';
			Ci(7) <= '1';
			nState <= s4; 
		when s4 => 
			A0 <= xA0;
			A1 <= xA1;
			A2 <= xA2;
			print <= '0';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(5) <= '1';
			Ci(8) <= '1';
			nState <= s5; 
		when s5 => 
			A0 <= xA0;
			A1 <= xA1;
			A2 <= xA2;
			print <= '0';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(2) <= '1';
			Ci(4) <= '1';
			nState <= s6;
		when s6 => 
			A0 <= xA0;
			A1 <= xA1;
			A2 <= xA2;
			print <= '0';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(5) <= '1';
			Ci(6) <= '1';
			nState <= s7;
		when s7 => 
			A0 <= xA0;
			A1 <= xA1;
			A2 <= xA2;
			print <= '0';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(2) <= '1';
			Ci(3) <= '1';
			Ci(5) <= '1';
			nState <= s8;
		when s8 => 
			A0 <= xA0;
			A1 <= xA1;
			A2 <= xA2;
			print <= '0';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(7) <= '1';
			Ci(8) <= '1';
			Ci(9) <= '1';
			nState <= s9;
		when s9 => 
			A0 <= xA0;
			A1 <= xA1;
			A2 <= xA2;
			print <= '0';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(4) <= '1';
			Ci(5) <= '1';
			Ci(6) <= '1';
			Ci(7) <= '1';
			nState <= s10;
		when s10 => 
			A0 <= xA0;
			A1 <= xA1;
			A2 <= xA2;
			print <= '0';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(5) <= '1';
			Ci(7) <= '1';
			Ci(8) <= '1';
			nState <= s11;
		when s11 => 
			A0 <= xA0;
			A1 <= xA1;
			A2 <= xA2;
			print <= '1';
			for x in 0 to 31 loop
				Ci(x) <= '0';
			end loop;
			Ci(1) <= '1';
			Ci(4) <= '1';
			nState <= s11;
		end case; 
	end process; 
end fsm_arc; 