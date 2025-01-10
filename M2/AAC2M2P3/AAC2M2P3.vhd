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
  type state_type is (A, B, C, D);
  signal cur, nex : state_type;
begin
  timing_proc : process (clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        cur <= A;
      else
        cur <= nex;
      end if;
    end if;
  end process timing_proc;
  state_control : process (cur)
  begin
    case(cur)
      when A =>
         if In1 = '0'then
            nex <= A;
         elsif In1 = '1' then
            nex <= B;
         end if;
      when B =>
         if In1 = '1' then
            nex <= B;
         elsif In1 = '0' generate
            nex <= C;
         end if;
      when C =>
         if In1 = '0' then
            nex <= C;
         elsif In1 = '1' then
            nex <= A;
         end if;
   end process state_control;
   output_control : process (cur)
   begin
      case(cur)
         when A =>
            Out1 <= '0';
         when B =>
            Out1 <= '0';
         when C =>
            Out1 <= '1';
      end case; 
   end process;
end architecture;