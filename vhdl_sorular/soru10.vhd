library ieee;
use ieee.std_logic_1164.all;

entity soru10 is port(
    D_in : in std_logic_vector(7 downto 0);
    Sel : in std_logic;
    Ce : in std_logic;
    F : out std_logic
);
end entity soru10;

architecture soru10_arch of soru10 is  
begin
    proc1 : process(D_in,Sel,Ce) is 
    begin 
        if Ce = '1' then
            if    SEL = "000" then F <= D_in(0);
            elsif SEL = "001" then F <= D_in(1);
            elsif SEL = "010" then F <= D_in(2);
            elsif SEL = "011" then F <= D_in(3);
            elsif SEL = "100" then F <= D_in(4);
            elsif SEL = "101" then F <= D_in(5);
            elsif SEL = "110" then F <= D_in(6);
            elsif SEL = "111" then F <= D_in(7);
            else  F <= '0';
            end if;
        else 
        F <= '0';
        end if;
    end process proc1;
end architecture;