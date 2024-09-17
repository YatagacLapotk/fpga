library ieee;
use ieee.std_logic_1164.all;


entity soru4 is port(
    A,B,C,D : in std_logic;
    SEL : in std_logic_vector(1 downto 0);
    outmux : out std_logic 
);
end soru4;

architecture soru4_arch of soru4 is 
begin 
    outmux <= A when SEL = '00' else
              B when SEL = '01' else
              C when SEL = '10' else
              D when SEL = '11' else
              0;
end soru4_arch;