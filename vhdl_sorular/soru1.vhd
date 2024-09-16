library ieee;
use ieee.std_logic_1164.all;

entity sour1 is port(
    A,B,C : in std_logic_vector(2 downto 0);
    F : out std_logic);
end sour1;

architecture sour1_arch of sour1 is 
begin 
    F <= not(A and B and C);
end sour1_arch;


