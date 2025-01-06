library ieee;                                
use ieee.std_logic_1164.all;                 
use ieee.numeric_std.all; 
use ieee.std_logic_textio.all;
use std.textio.all;
use work.all;

----------------------------------------------------------------------
-- Testbench entity declaration
----------------------------------------------------------------------
entity AAC2M1P1_test is     
--  port( ); 
-- no external interface.....THIS IS THE TOP LEVEL
end AAC2M1P1_test;


-------------------------------------------------------------------
-- Testbench architecture body
----------------------------------------------------------------------
architecture behavioral of AAC2M1P1_test is      

----------------------------------------------------------------------
--- constant declarations
----------------------------------------------------------------------
   constant delay:  TIME := 10.00 NS; -- defines the wait period.
   constant Points: integer := 10;   -- number of points this problem
                                    -- is worth
----------------------------------------------------------------------                                                                      
-- signal declarations 
----------------------------------------------------------------------
--  signal clock:  std_logic := '0';
  signal a_tb, b_tb:  std_logic_vector(1 downto 0);  -- data inputs
  signal c_tb:  std_logic;  -- data output
  signal ValidCheck: std_logic_vector(15 downto 0);  
            -- unique to this problem, to check validity of submission    
                        
  type mem is array (integer range <>) of std_logic_vector(7 downto 0);
  signal ROM: mem(0 to 255);


--------------------------------------------------
-- component declarations before instantiation 
--------------------------------------------------
---------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- Mux
component comparator2 
   port (                 
    A, B: in std_logic_vector(1 downto 0); 
    Equals: out std_logic            		    
    );  
end component;


----------------------------------------------------------------------
--- Procedures
----------------------------------------------------------------------

  procedure Load_ROM(signal data_word : inout mem) is
     file ROMfile : text open read_mode is "vectorh.out";
     variable lbuf: line;
     variable i: integer :=0;
     variable fdata: std_logic_vector(7 downto 0);
 --
   begin
     while not(endfile(ROMfile))  loop
     -- read digital data from input file
     readline(ROMfile, lbuf);
     hread(lbuf, fdata);
     data_word(i) <= fdata;
     i := i + 1;
     end loop;
  end procedure; 

 procedure Write_ROM (signal data_word : inout mem) is
     file ROMfileOut : text open write_mode is "myvectorh.out";
     variable row: line;
     variable i : integer :=0;
     variable fdata: std_logic_vector (7 downto 0);
 --
   begin
     while (i<256) loop
     fdata := data_word(i);
     hwrite(row, fdata, left,4);
     writeline(RomfileOut, row);
     i := i + 1;
     end loop;
  end procedure;    

----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
begin
  
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- find_errors
DUT : comparator2      -- Device under test instantiation
    port map( 
        -- Inputs
        A    => a_tb,
        B    => b_tb,
         -- Outputs
        Equals    => c_tb
        );

process 
begin
  a_tb <= "00";
  b_tb <= "00";
  wait for 100 ns;
  a_tb <= "01";
  b_tb <= "00";
  wait for 100 ns;
  a_tb <= "10";
  b_tb <= "00";
  wait for 100 ns;
  a_tb <= "11";
  b_tb <= "00";
  wait for 100 ns;
  a_tb <= "00";
  b_tb <= "01";
  wait for 100 ns;
  a_tb <= "01";
  b_tb <= "01";
  wait for 100 ns;
end process;
end behavioral; -- of AAC2M1P1_tb;  

