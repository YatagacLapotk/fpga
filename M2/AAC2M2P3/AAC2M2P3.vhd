library ieee;
use ieee.std_logic_1164.all;

entity FSM is
generic(
   A : std_logic_vector(1 downto 0):="00";
   B : std_logic_vector(1 downto 0):="01";
   C : std_logic_vector(1 downto 0):="10"
);
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;
architecture FSM_arch of FSM is 
   signal cur,nex : std_logic_vector(1 downto 0);
begin
   comb_proc : process(In1) 
   begin
      case(cur) is 
         when A => 
            if (In1 = '0') then nex <= A;
            elsif(In1 ='1') then nex <= B;
            end if;
            Out1 <= '0';
         when B => 
            if(In1 = '1') then nex <= B;
            elsif(In1 = '0') then nex<= C;
            end if;
            Out1 <= '0';
         when C => 
            if (In1 = '0') then nex <= C;
            elsif(In1 = '1') then nex <= A;
            end if;
            Out1 <= '1';
         when others => nex <= A; 
      end case;
   end process comb_proc;
   sync_proc : process(RST,CLK)
   begin
      if (RST = '1') then cur <= "00";
      elsif (rising_edge(CLK)) then 
         cur <=nex;
      end if;
   end process sync_proc;
end architecture;