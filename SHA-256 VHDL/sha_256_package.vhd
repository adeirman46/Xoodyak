-- buat yang cuma 1 blok dulu (M = 512 bit)

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package sha_256_package is
    constant NUM_BITS: integer := 32;

    -- make word array
    type word_array is array(0 to 63) of std_logic_vector(31 downto 0); -- message (512 bit) / 64 round = 16 W[i=0] - W[i=15], later W[i=16] - W[i=63] will be find. word_arry also carry constant kt(0-63).
    
    -- make hash array
    type hash_array is array(0 to 7) of std_logic_vector(NUM_BITS-1 downto 0); -- H -> (a, b, ..., h) = buffer

    -- constant hash H -> (a, b, ..., h)
    constant hash_constant: hash_array := (X"6a09e667", X"bb67ae85", X"3c6ef372", X"a54ff53a", X"510e527f", X"9b05688c", X"1f83d9ab", X"5be0cd19");

    -- constant kt
    constant kt : word_array := (X"428a2f98", X"71374491", X"b5c0fbcf", X"e9b5dba5", X"3956c25b", X"59f111f1", X"923f82a4", X"ab1c5ed5", X"d807aa98", X"12835b01", X"243185be", X"550c7dc3", X"72be5d74", X"80deb1fe", X"9bdc06a7", X"c19bf174", X"e49b69c1", X"efbe4786", X"0fc19dc6", X"240ca1cc", X"2de92c6f", X"4a7484aa", X"5cb0a9dc", X"76f988da", X"983e5152", X"a831c66d", X"b00327c8", X"bf597fc7", X"c6e00bf3", X"d5a79147", X"06ca6351", X"14292967", X"27b70a85", X"2e1b2138", X"4d2c6dfc", X"53380d13", X"650a7354", X"766a0abb", X"81c2c92e", X"92722c85", X"a2bfe8a1", X"a81a664b", X"c24b8b70", X"c76c51a3", X"d192e819", X"d6990624", X"f40e3585", X"106aa070", X"19a4c116", X"1e376c08", X"2748774c", X"34b0bcb5", X"391c0cb3", X"4ed8aa4a", X"5b9cca4f", X"682e6ff3", X"748f82ee", X"78a5636f", X"84c87814", X"8cc70208", X"90befffa", X"a4506ceb", X"bef9a3f7", X"c67178f2" );
    
    -- function declaration
    function Ch(X, Y, Z: std_logic_vector(NUM_BITS-1 downto 0)) return std_logic_vector;

    function Maj(X, Y, Z: std_logic_vector(NUM_BITS-1 downto 0)) return std_logic_vector;

    function upper_sig0(X: std_logic_vector(NUM_BITS-1 downto 0)) return
    std_logic_vector;

    function upper_sig1(X: std_logic_vector(NUM_BITS-1 downto 0)) return
    std_logic_vector;

    function lower_sig0(X: std_logic_vector(NUM_BITS-1 downto 0)) return
    std_logic_vector;

    function lower_sig1(X: std_logic_vector(NUM_BITS-1 downto 0)) return
    std_logic_vector;

    function circ_shift(X: std_logic_vector(NUM_BITS-1 downto 0); shift_n_bit: natural) return std_logic_vector;

    function right_shift(X: std_logic_vector(NUM_BITS-1 downto 0); shift_n_bit: natural) return std_logic_vector;
    
    function add_mod_2pow32(X, Y: std_logic_vector(NUM_BITS-1 downto 0)) return std_logic_vector;


end package sha_256_package;

package body sha_256_package is

    -- function addition mod 2^32
    function add_mod_2pow32(X, Y: std_logic_vector(NUM_BITS-1 downto 0)) return std_logic_vector is
    begin
        return std_logic_vector(unsigned(X) + unsigned(Y) mod "100000000000000000000000000000000"); -- output is 33 bit, we then should slice it or drop MSB because '1' - '1' is '0' then X(31 downto 0)
    end function add_mod_2pow32;

    -- function circ_shift 
    function circ_shift(X: std_logic_vector(NUM_BITS-1 downto 0); shift_n_bit: natural) return std_logic_vector is
    begin
        return std_logic_vector(rotate_right(unsigned(X), shift_n_bit));
    end function circ_shift;

    -- function right_shift
    function right_shift(X: std_logic_vector(NUM_BITS-1 downto 0); shift_n_bit: natural) return std_logic_vector is
    begin
        return std_logic_vector(shift_right(unsigned(X), shift_n_bit));
    end function right_shift;

    -- function Ch
    function Ch(X, Y, Z: std_logic_vector(NUM_BITS-1 downto 0)) return std_logic_vector is
    begin
        return std_logic_vector((X and Y) xor (not(X) and Z));
    end function Ch;

    -- function Maj
    function Maj(X, Y, Z: std_logic_vector(NUM_BITS-1 downto 0)) return std_logic_vector is
    begin
        return std_logic_vector((X and Y) xor (X and Z) xor (Y and Z));
    end function Maj;

    -- function upper_sig0
    function upper_sig0(X: std_logic_vector(NUM_BITS-1 downto 0)) return
    std_logic_vector is
    begin
        return std_logic_vector(circ_shift(X, 2) xor circ_shift(X, 13) xor circ_shift(X, 22));
    end function upper_sig0;

    -- function upper_sig1
    function upper_sig1(X: std_logic_vector(NUM_BITS-1 downto 0)) return
    std_logic_vector is
    begin
        return std_logic_vector(circ_shift(X, 6) xor circ_shift(X, 11) xor circ_shift(X, 25));
    end function upper_sig1;

    -- function lower_sig0
    function lower_sig0(X: std_logic_vector(NUM_BITS-1 downto 0)) return
    std_logic_vector is
    begin
        return std_logic_vector(circ_shift(X, 7) xor circ_shift(X, 18) xor right_shift(X, 3));
    end function lower_sig0;

    -- function lower_sig1
    function lower_sig1(X: std_logic_vector(NUM_BITS-1 downto 0)) return
    std_logic_vector is
    begin
        return std_logic_vector(circ_shift(X, 17) xor circ_shift(X, 19) xor right_shift(X, 10));
    end function lower_sig1;

end package body;

