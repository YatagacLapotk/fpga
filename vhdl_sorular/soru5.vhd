library ieee;
use std_logic_1164.all;

entity soru5 is port(
    L, M, N : in std_logic;
    F3 : out std_logic
);
end soru5;

architecture soru5_arch of soru5 is 
begin 
with ((not(L) and not(M)) and N) or (L and M) select 
    F3 <= '1' when '1'
          '0' when '0'
          '0' when others;
end soru5_arch; 