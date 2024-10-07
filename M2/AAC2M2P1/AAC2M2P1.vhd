LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
    TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;

architecture AAC2M2P1_arch of AAC2M2P1 is
    signal Q_reg : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(CP,SR)
    begin
        if(SR = '0') then 
            Q <= (others => '0');
        elsif(rising_edge(CP)) then
            if(PE='1') then 
                Q_reg <= P;
            elsif(CEP='1'and CET='1') then
                Q_reg <= std_logic_vector(unsigned(Q_reg)+1);
            end if;
        end if;
    end process;
    Q<=Q_reg;
    TC<= '1' when (Q_reg = "1111") else '0';
end architecture;