library ieee;
use ieee.std_logic_1164.all;

entity soru12 is port(
    D_in : in std_logic_vector(7 downto 0);
    Sel : in std_logic_vector(2 downto 0);
    Ce : in std_logic;
    F : out std_logic
);
end soru12;

architecture soru12_arch of soru12 is
begin
    proc1 : process(D_in, Sel, Ce) is
    begin
        case Ce is
            when '1'=> 
                case Sel is 
                    when "000"  => F <= D_in(0);
                    when "001"  => F <= D_in(1);
                    when "010"  => F <= D_in(2);
                    when "011"  => F <= D_in(3);
                    when "100"  => F <= D_in(4);
                    when "101"  => F <= D_in(5);
                    when "110"  => F <= D_in(6);
                    when "111"  => F <= D_in(7);
                    when others => F <= '0';
                end case;
            when others => F <= '0';
        end case;
    end process proc1;
end architecture;