library ieee;
  use ieee.std_logic_1164.all;

entity mux2x1 is
  port (
    a   : in    std_logic;
    b   : in    std_logic;
    sel : in    std_logic;
    y   : out   std_logic
  );
end entity mux2x1;

architecture rtl of mux2x1 is

begin

  y <= a when sel = '0' else
       b when sel = '1' else
       'X';

end architecture rtl;