library ieee;
use std_logic_1164.all;

entity soru7 is port(
    D_IN : in std_logic_vector(3 downto 0);
    Z_OUT : out std_logic_vector(2 downto 0)
);
end soru7;

architecture soru7_arch of soru7 is 
begin 
with D_IN select 
    Z_OUT <= '100' when '0000'| '0001'| '0010'| '0011' else
             '010' when '0100'| '0101'| '0110'| '0111'| '1000'| '1001' else
             '001' when '1010'| '1011'| '1100'| '1101'| '1110'| '1111' else
             '000' when others;
end soru7_arch;
        
            