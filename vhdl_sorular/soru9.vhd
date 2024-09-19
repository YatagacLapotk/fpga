library ieee;
use ieee.std_logic_1164.all;

entity soru9 is port(
    D_in : in std_logic_vector(7 downto 0);
    SEL : in std_logic_vector (2 downto 0);
    F_ctrl : out std_logic
);
end soru9;

architecture soru9_arch of soru9 is 
begin 
    proc1 : process(D_in, SEL) is 
    begin
        if    SEL = "000" then F_ctrl <= D_in(0);
        elsif SEL = "001" then F_ctrl <= D_in(1);
        elsif SEL = "010" then F_ctrl <= D_in(2);
        elsif SEL = "011" then F_ctrl <= D_in(3);
        elsif SEL = "100" then F_ctrl <= D_in(4);
        elsif SEL = "101" then F_ctrl <= D_in(5);
        elsif SEL = "110" then F_ctrl <= D_in(6);
        elsif SEL = "111" then F_ctrl <= D_in(7);
        else  F_ctrl <= '0';
        end if;
    end process proc1;  
end soru9_arch;