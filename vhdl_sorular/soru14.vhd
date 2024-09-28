library ieee;
use ieee.std_logic_1164.all;

entity dff is port(
    D,CLK : in std_logic;
    S,R   : in std_logic;
    Q     : out std_logic
);
end dff;

architecture dff_arch of dff is
begin
    proc_dff : process(D,CLK,S,R)
    begin
        if (S = '0') then 
            Q <= '1';
        elsif (R = '1') then
            Q <= '0';
        elsif (rising_edge(CLK)) then
            Q <= D;
        end if;
    end process;
end architecture;