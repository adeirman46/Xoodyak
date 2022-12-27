# Xoodyak
Xoodyak is lightweight cryptography algortithm. The Algorithm of Xoodyak is simply just hashing message into message digest then do Xoodoo permutation.

## SHA-256
SHA-256 is one of the most secure in Hash family. As you might heard that MD4, MD5, SHA-1 is not collision resistance. SHA-256 is so fast, that's why we choose SHA-256 as alternative of latest, most secure Hash Algorithm, Keccak. I think this is the easiest VHDL SHA-256 Algorithm to understand, don't worry we also made "step-by-step how to use SHA-256". If you have any questions regarding the algorithm i've made. You can email me @adeirman2705. I also made this SHA-256 is so powerful, it can hash 12.7 Million bits into 256 bit message digest in matter of minutes in Python.

## SHA-384 (Keccak)
Keccak is winner from NIST as a Secure Hash Algorithm (SHA-3). The Algorithm is super famous, "Sponge Construction" that consist 2 big step, absorbtion and squeeze. You can try this algorithm in Python Implementation folder. In python implementation, Keccak can hash 1.2 Million bits into 384 bits in just 40 seconds.

## Xoodoo Permutation
Xoodoo Permutation is so similar with Keccak Permuatation, we simply re-arrange bits in cube 4 x 32 x 3. Xoodoo Permutation need input from SHA-256 or SHA-384 and will permutatate and resulting 384 bits.
