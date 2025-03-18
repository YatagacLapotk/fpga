library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.std_logic_arith.all;

entity timer_counter is
  generic (
    time_deger : integer := 100_000_000
  );
  port (
    clk     : in    std_logic;
    sel     : in    std_logic_vector(1 downto 0);
    counter : out   std_logic_vector(7 downto 0)
  );
end entity timer_counter;

architecture rtl of timer_counter is

  constant clk200m : integer := time_deger * 2;
  constant clk100m : integer := time_deger;
  constant clk50m  : integer := time_deger / 2;
  constant clk25m  : integer := time_deger / 4;

  signal timer       : integer range 0 to clk200m;
  signal clk_deger   : integer range 0 to clk200m;
  signal counter_int : std_logic_vector(7 downto 0);

begin

  clk_deger <= clk100m when sel = "00" else
               clk200m when sel = "01" else
               clk50m  when sel = "10" else
               clk25m;

  plabel : process (clk) is
  begin

    if (rising_edge(clk)) then
      if (clk_deger = timer - 1) then
        counter_int <= counter_int + 1;
        timer       <= 0;
      else
        timer <= timer + 1;
      end if;
    end if;

  end process plabel;

end architecture rtl;