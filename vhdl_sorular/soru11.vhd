library ieee;
use ieee.std_logic_1164.all;

entity soru11 ISPORT
  (
  A, B, C : in std_logic;
  F       : out std_logic
  );
end soru11;

architecture soru11_arch of soru11 is
  signal ABC : std_logic_vector(2 downto 0);
begin
  ABC <= A & B & C;
  proc1 : process (ABC) is
  begin
    case ABC is
      when "100"  => F  <= '1';
      when "-11"  => F  <= '1';
      when others => F <= '0';
    end case;
  end process proc1;
end architecture;