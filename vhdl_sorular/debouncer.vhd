library ieee;
  use ieee.std_logic_1164.all;

entity debouncer is
    generic (
        c_clkfreq : integer   := 100_000_000;
        c_debtime : integer   := 1000;
        c_initial : std_logic := '0'
    );
    port (
        clk      : in std_logic;
        signal_i : in std_logic;
        signal_o : out std_logic
    );
end entity;

architecture rtl of debouncer is
    constant c_timelim : integer := c_clkfreq/c_debtime;
    
    signal timer : integer range 0 to c_timelim := 0;
    signal timer_e : std_logic := '0';
    signal  timer_tick :std_logic :='0';
    type t_state is ( s_initial, s_zero, s_zeroone, s_one, s_onezero );
    signal state : t_state := s_initial;
begin

    p_state : process (clk)
    begin
        if(rising_edge(clk)) then   
            case state is
                when s_initial =>
                    if c_initial = '1' then
                        state <= s_zero;
                    else
                        state <= s_one;
                    end if;
                when s_zero =>
                    signal_o <= '0';
                    timer_e <= '1';
                    if signal_i = '1' then
                        state <= s_zeroone;
                    end if;
                when s_zeroone =>
                    signal_o <= '0';
                    timer_e <= '1';
                    if timer_tick = '1' then 
                        state <= s_one;
                    end if;
                    if (signal_i = '0') then  
                        state <= s_zero;
                        timer_e <= '0';
                    end if;
                when s_one =>
                    signal_o <= '1';
                    timer_e <= '1';
                    if signal_i = '0' then
                        state <= s_zeroone;
                    end if;
                when s_onezero =>
                    signal_o <= '1';
                    timer_e <= '1';
                    if timer_tick = '0' then 
                        state <= s_zero;
                    end if;
                    if (signal_i = '1') then  
                        state <= s_one;
                        timer_e <= '0';
                    end if;
            end case;
        end if;
    end process p_state;
    
    p_timer : process (clk) 
    begin
        if (rising_edge(clk)) then
            if timer_e ='1' then
                if timer = c_timelim - 1 then
                    timer_tick <= '1';
                    timer <= 0;
                else
                    timer_tick <= '0';
                    timer <= timer + 1;
                end if;
            else
                timer <= 0;
                timer_tick <= '0';
            end if;
        end if; 
    end process;
end architecture;
