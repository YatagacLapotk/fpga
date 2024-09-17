
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity soru8 is
  port (
    a : in std_logic;
    b : out std_logic
  );
end entity;

architecture sour8_arch of soru8 is 
begin
    b <= a xor a;
end architecture;