 LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity mux_2to1 is
    Port ( S : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (15 downto 0);
           B   : in  STD_LOGIC_VECTOR (15 downto 0);
           Y   : out STD_LOGIC_VECTOR (15 downto 0));
end mux_2to1;

architecture Behavioral of mux_2to1 is
begin
    Y <= B when (S = '1') else A;
end Behavioral;