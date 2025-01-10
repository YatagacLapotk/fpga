library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM128_32 is
  port (
    address : in std_logic_vector (6 downto 0);
    clock   : in std_logic := '1';
    data    : in std_logic_vector (31 downto 0);
    wren    : in std_logic;
    q       : out std_logic_vector (31 downto 0)
  );
end RAM128_32;

architecture RAM128_32_arch of RAM128_32 is
  type memory is array (0 to 127) of std_logic_vector(31 downto 0);
  signal ram_ad  : memory;
  signal data_in : std_logic_vector(31 downto 0);
begin
  process (clock)
  begin
    if rising_edge(clock) then
      if wren = '1' then
        ram_ad(to_integer(unsigned(address))) <= data;
      end if;
      data_in <= ram_ad(to_integer(unsigned(address)));
    end if;
  end process;
  q <= data_in;
end architecture;
