library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AAC2M2P1 IS PORT
  (
  CP  : in std_logic; -- clock
  SR  : in std_logic; -- Active low, synchronous reset
  P   : in std_logic_vector(3 downto 0); -- Parallel input
  PE  : in std_logic; -- Parallel Enable (Load)
  CEP : in std_logic; -- Count enable parallel input
  CET : in std_logic; -- Count enable trickle input
  Q   : out std_logic_vector(3 downto 0);
  TC  : out std_logic -- Terminal Count
  );
end AAC2M2P1;

architecture AAC2M2P1_arch of AAC2M2P1 is
  signal curr : std_logic_vector(3 downto 0); 
begin
  process (CP,CET,CEP,SR) begin
    if rising_edge(CP) then
      if SR = '1' then
        if PE = '0' then 
          curr <= P;
        elsif (CET='1' and CEP='1') then
          curr <= curr + 1;
        end if; 
      else
        curr <= "0000"; 
      end if;
    end if;
  end process;
  Q <= curr;
  TC <= CET and curr;
  if TC ='1' then 
    curr<= "0000";
  end if;
end architecture;