library ieee;
use std_logic_1164.all;

entity soru3 is port(
    L,M,N : in std_logic;
    F3 : out std_logic
);
end soru3;

architecture soru3_arch of soru3 is 
begin 
    F3 <= '1' when (L = '0' and M = '0' and N = '1') else 
          '1' when (L='1' and M = '1') else 
          '0';
end soru3_arch;  