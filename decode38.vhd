---------------------------------------------------------------------
--              Digital System Design with VHDL 2nd Edition
--              Mark Zwolinski
--              Pearson Education, 2004, ISBN 0-13-039985-X
--
--              Chapter 4, Exercise 4.3, page 78, 342
--
-- Design unit: decoder(bool_expr, when_else, with_select)
--            : (Entity and Architectures)
--            :
-- File name  : decode38.vhd
--            :
-- Description: 3 to 8 decoder. Answer to exercise 4.3
--            :
-- Limitations: None
--            : 
-- System     : VHDL'93/'02, STD_LOGIC_1164
--            :
-- Author     : Mark Zwolinski
--            : mz@ecs.soton.ac.uk
--
-- Revision   : Version 2.0 03/12/03
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
entity decoder is
  port (a : in std_logic_vector(2 downto 0);
        z : out std_logic_vector(7 downto 0));
end entity decoder;

architecture bool_expr of decoder is
begin
  z(0) <= not a(0) and not a(1) and not a(2);
  z(1) <= a(0) and not a(1) and not a(2);
  z(2) <= not a(0) and a(1) and not a(2);
  z(3) <= a(0) and a(1) and not a(2);
  z(4) <= not a(0) and not a(1) and a(2);
  z(5) <= a(0) and not a(1) and a(2);
  z(6) <= not a(0) and a(1) and a(2);
  z(7) <= a(0) and a(1) and a(2);
end architecture bool_expr;

architecture when_else of decoder is
begin
  z <= "00000001" when a = "000" else
       "00000010" when a = "001" else
       "00000100" when a = "010" else
       "00001000" when a = "011" else
       "00010000" when a = "100" else
       "00100000" when a = "101" else
       "01000000" when a = "110" else
       "10000000" when a = "111" else
       "XXXXXXXX";
end architecture when_else;

architecture with_select of decoder is
begin
  with a select
    z <= "00000001" when "000",
         "00000010" when "001",
         "00000100" when "010",
         "00001000" when "011",
         "00010000" when "100",
         "00100000" when "101",
         "01000000" when "110",
         "10000000" when "111",
         "XXXXXXXX" when others;
end architecture with_select;

