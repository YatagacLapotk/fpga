
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity soru8 is
  port (
    a : in std_logic;
    b : in std_logic;
    c : in std_logic;
    f : out std_logic
  );
end entity;

architecture sour8_arch of soru8 is 
begin
  proc1 : process(a,b,c) is
    begin 
    if (a = '1' and b = '0' and c = '0') then 
        f <= '1';
    elsif (b = '1' and c = '1') then 
        f <= '1';
    else 
      f <= '0';
    end if;
  end process proc1;
end architecture sour8_arch;