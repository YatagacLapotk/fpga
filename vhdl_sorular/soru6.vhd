library ieee;
use ieee.std_logic_1164.all;

entity soru6 is port(
    A,B,C,D : in std_logic;
    SEL : in std_logic_vector(1 downto 0);
    outmux : out std_logic
);
end soru6;

architecture soru6_arch of soru6 is 
begin 
with SEL select
    outmux <= A when 2b"00",
              B when 2b"01",
              C when 2b"10",
              D when 2b"11",
              0 when others;
end soru6_arch;