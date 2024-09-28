library ieee;
use ieee.std_logic_1164.all;

entity bus_build is port (
    D,CLK,R: in std_logic;
    Q: out std_logic);
end entity bus_build;

architecture bus_arch of bus_build is
begin 
    DFF: process (D,R,CLK) 
    begin
        if (R='1') then 
            Q <= '0';
        elsif (rising_edge(CLK)) then
            Q <= D;
        end if;
    end process DFF;
end architecture bus_arch;

