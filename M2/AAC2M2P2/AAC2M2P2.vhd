LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY RAM128_32 IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END RAM128_32;

architecture RAM128_32_arch of RAM128_32 is
	type memory is array  (0 to 127) of std_logic_vector(31 downto 0); 
	signal ram_ad: memory:= (others=>(others=>'0'));
begin
	process(clock,wren)
  	begin
		if(rising_edge(clock)) then 
			if(wren='1') then 
				ram_ad(unsigned(address)) <= data;
			end if;
			q <= ram_ad(unsigned(address));
		end if;
	end process;
end architecture;
