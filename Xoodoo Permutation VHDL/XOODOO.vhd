library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 
use work.spons.all; 

entity xoodoo is 
	port( 	proceed, rst, clk : in std_logic;
			in_A0, in_A1, in_A2 : in plane;
			A0_final, A1_final, A2_final : out plane 
		); 
end xoodoo; 

architecture xoodoo0 of xoodoo is 

component fsm is 
	port( proceed, rst, clk : in std_logic;
		xA0, xA1, xA2, in_A0, in_A1, in_A2 : in plane;
		A0, A1, A2 : out plane;
		print: out std_logic; 
		Ci: out lane 
		); 
end component;

component theta is 
	port( in_A0, in_A1, in_A2 : in plane;
          nA0, nA1, nA2 : out plane
		); 
end component; 

component rhowest is 
	port( A1, A2 : in plane;
        nA1, nA2 : out plane
		); 
end component; 

component iota is 
	port( Ci : in lane;
		A0 : in plane;
		nA0 : out plane
		); 
end component; 

component chi is 
	port( A0, A1, A2 : in plane;
		nA0, nA1, nA2 : out plane
		); 
end component; 

component rhoeast is 
	port( A0, A1, A2 : in plane;
		nA0, nA1, nA2 : out plane
		); 
end component; 

component redefine is
	port ( print : in std_logic;
		xA0, xA1, xA2 : in plane;
		nA0, nA1, nA2 : out plane
		);
end component;

signal P, E, aA0, aA1, aA2, bA0, bA1, bA2, cA0, cA1, cA2, nA0, nA1, nA2, xA0, xA1, xA2, A0, A1, A2 : plane;
signal Ci : lane;
signal print: std_logic;

begin 
	-- FSM controller 
		TOFSM: fsm port map(proceed, rst, clk, xA0, xA1, xA2, in_A0, in_A1, in_A2, A0, A1, A2, print, Ci);
	-- Datapath 
		TH_STEP: theta port map(A0, A1, A2, aA0, aA1, aA2); 
		RW_STEP: rhowest port map( aA1, aA2, bA1, bA2); 
		I_STEP: iota port map(Ci, aA0, bA0); 
		X_STEP: chi port map( bA0, bA1, bA2, cA0, cA1, cA2 ); 
		RE_STEP: rhoeast port map(cA0, cA1, cA2, xA0, xA1, xA2); 
		DEFINE : redefine port map(print, xA0, xA1, xA2, nA0, nA1, nA2);
		A0_final <= nA0;
		A1_final <= nA1;
		A2_final <= nA2;
end xoodoo0;