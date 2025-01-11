library ieee;
use ieee.std_logic_1164.all;

entity adder is
    port (
        A,B : in std_logic_vector(31 downto 0);
        Cin : in std_logic;
        Cout: out std_logic;
        S : out std_logic_vector(31 downto 0) 
    );
end entity;

architecture rtl of adder is
    signal sum_bits : std_logic_vector(31 downto 0);
    signal carry_generate : std_logic;
    signal carry_propagate : std_logic;
    signal carry : std_logic;
begin
    process(A,B,Cin)
    begin
        carry <= Cin;
        for i in 31 downto 0 loop
            sum_bits(i) <= A(i) xor B(i);
            carry_generate <= A(i) and B(i);
            S(i) <= sum_bits(i) xor carry;
            carry_propagate <= sum_bits(i) and carry;
            carry <= carry_generate or carry_propagate;
        end loop;
        Cout <= carry;
    end process;
end architecture;
