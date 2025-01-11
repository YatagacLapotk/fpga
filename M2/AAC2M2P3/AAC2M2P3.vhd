library ieee;
use ieee.std_logic_1164.all;

entity FSM is
  port (
    In1  : in std_logic;
    RST  : in std_logic;
    CLK  : in std_logic;
    Out1 : inout std_logic);
end FSM;
architecture FSM_arch of FSM is
  type state_type is (A, B, C);
  signal cur, nex : state_type;
begin
  timing_proc : process (clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        cur <= A;
      else
        cur <= nex;
      end if;
    end if;
  end process timing_proc;
  state_control : process (cur)
  begin
    case cur is
      when A =>
        if In1 = '1' then
          nex <= B;
        else
          nex <= A;
        end if;
      when B =>
        if In1 = '1' then
          nex <= B;
        else
          nex <= C;
        end if;
      when C =>
        if In1 = '1' then
          nex <= A;
        else
          nex <= C;
        end if;
    end case;
      
   end process state_control;
   output_control : process (cur)
   begin
      case cur is
         when A =>
            Out1 <= '0';
         when B =>
            Out1 <= '0';
         when C =>
            Out1 <= '1';
      end case; 
   end process;
end architecture;