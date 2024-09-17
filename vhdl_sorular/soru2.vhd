library ieee;
use std_logic_1164.all;

entity soru2 is port(
    L, M, N : in std_logic;
    F3 : out std_logic
);
end soru2;

architecture soru2_arch of soru2 is 
begin 
F3 <= ((not(L) and not(M)) and N) or (L and M);
end soru2_arch; 