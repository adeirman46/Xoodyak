library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.sha_256_package.all;

entity sha_256_top_level is
    port(
        clk: in std_logic;
        rst: in std_logic;
        msg_in : in std_logic_vector(511 downto 0);
        ciphertext : out std_logic_vector(255 downto 0)
    );
end entity;

architecture sha_256_arch of sha_256_top_level is
    type states is (init, state_1, state_2, state_3, state_4, state_5, state_6);
    signal ps_state, nx_state : states;
    signal Wt: word_array;
    signal a, b, c, d, e, f, g, h, T1, T2: std_logic_vector(31 downto 0);
    signal h1, h2, h3, h4, h5, h6, h7, h8: std_logic_vector(31 downto 0);
    signal range_1, range_2, round_1: integer;

begin

    process(rst, clk)
    begin
    if rst = '1' then
        ps_state <= init;
    elsif rising_edge(clk) then
        ps_state <= nx_state;
    end if;
    end process;
        
    process(ps_state, nx_state, clk)
    begin
    case ps_state is
        when init =>
            range_1 <= 0;
            range_2 <= 16;
            round_1 <= 0;
            nx_state <= state_1;

        when state_1 =>
            -- get W(0) - W(15)
            if range_1 < 16 then
                Wt(15 - range_1) <= msg_in(32*(range_1+1)-1 downto 32*range_1);
                -- 63 downto 32, 31 downto 0
                range_1 <= range_1 + 1;
                nx_state <= state_1;
            else
                nx_state <= state_2;
            end if;

        when state_2 =>
            -- get W(16) - W(63)
            if range_2 < 64 then -- if you see range_2 = 64 in modelsim (because it should be 0-63), don't be frightened because when range_2 = 63 it still add 1
                Wt(range_2) <= add_mod_2pow32(add_mod_2pow32(lower_sig1(Wt(range_2-2)),Wt(range_2-7))(31 downto 0),add_mod_2pow32(lower_sig0(Wt(range_2-15)),Wt(range_2-16))(31 downto 0))(31 downto 0);
                range_2 <= range_2 + 1; 
                nx_state <= state_2;
            else
                nx_state <= state_3;
            end if;

        when state_3 => 
            -- assign initial hash value (constant)
            h1 <= hash_constant(0);
            h2 <= hash_constant(1);
            h3 <= hash_constant(2);
            h4 <= hash_constant(3);
            h5 <= hash_constant(4);
            h6 <= hash_constant(5);
            h7 <= hash_constant(6);
            h8 <= hash_constant(7);
            -- assign buffer (a, b, .., h) with value (h1, h2, .., h8)
            a <= h1;
            b <= h2;
            c <= h3;
            d <= h4;
            e <= h5;
            f <= h6;
            g <= h7;
            h <= h8;
            T1 <= add_mod_2pow32(add_mod_2pow32(h, upper_sig1(e))(31 downto 0), add_mod_2pow32(add_mod_2pow32(Ch(e, f, g), kt(round_1))(31 downto 0), Wt(round_1))(31 downto 0))(31 downto 0); -- why i write (31 downto 0)? it is because output of add_mod_2pow32 is 33 bit, we then should slice it or drop MSB because '1' - '1' is '0' thus we specify X(31 downto 0)
            T2 <= add_mod_2pow32(upper_sig0(a), Maj(a, b, c))(31 downto 0);
            nx_state <= state_4;

        when state_4 =>
            -- do hash computation with 64 rounds
            if round_1 < 64 then 
                h <= g;
                g <= f;
                f <= e;
                e <= add_mod_2pow32(d, T1)(31 downto 0);
                d <= c; 
                c <= b;
                b <= a;
                a <= add_mod_2pow32(T1, T2)(31 downto 0);
                T1 <= add_mod_2pow32(add_mod_2pow32(h, upper_sig1(e))(31 downto 0), add_mod_2pow32(add_mod_2pow32(Ch(e, f, g), kt(round_1))(31 downto 0), Wt(round_1))(31 downto 0))(31 downto 0);
                T2 <= add_mod_2pow32(upper_sig0(a), Maj(a, b, c))(31 downto 0);
                round_1 <= round_1 + 1;
                nx_state <= state_4;
            else
                nx_state <= state_5;
            end if;

        when state_5 =>
            h1 <= add_mod_2pow32(h1, a)(31 downto 0);
            h2 <= add_mod_2pow32(h2, b)(31 downto 0);
            h3 <= add_mod_2pow32(h3, c)(31 downto 0);
            h4 <= add_mod_2pow32(h4, d)(31 downto 0);
            h5 <= add_mod_2pow32(h5, e)(31 downto 0);
            h6 <= add_mod_2pow32(h6, f)(31 downto 0);
            h7 <= add_mod_2pow32(h7, g)(31 downto 0);
            h8 <= add_mod_2pow32(h8, h)(31 downto 0);
            nx_state <= state_6;
        
        when state_6 =>
            ciphertext <= h1 & h2 & h3 & h4 & h5 & h6 & h7 & h8;

    end case;
    end process;

end architecture sha_256_arch;

            

    





        
        


