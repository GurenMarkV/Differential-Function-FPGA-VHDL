---------------------------------------------------------------------
--              Digital System Design with VHDL 2nd Edition
--              Mark Zwolinski
--              Pearson Education, 2004, ISBN 0-13-039985-X
--
--              Chapter 8, Exercise 8.4, page 188/353
--
-- Design unit: mux(behave, correct1, correct2) (Entity and Architectures)
--            :
-- File name  : mux.vhd
--            :
-- Description: Exercise 8.4 multiplexer with erroneous behaviour 
--            : and two correct versions
--            :
-- Limitations: None
--            : 
-- System     : VHDL'93/'02, STD_LOGIC_1164
--            :
-- Author     : Mark Zwolinski
--            : mz@ecs.soton.ac.uk
--
-- Revision   : Version 2.0 15/12/03
---------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity mux is
  port (a, b, c : in std_logic;
      z : out std_logic);
end entity mux;

architecture behave of mux is
  signal sel : integer range 0 to 1;
begin
  m1: process (a, b, c) is
  begin
    sel <= 0;
    if (c = '1') then
      sel <= sel + 1;
    end if;
    case sel is
      when 0 =>
        z <= a;
      when 1 =>
        z <= b;
    end case;
  end process m1;
end architecture behave;

architecture correct1 of mux is
  signal sel : integer range 0 to 1;
begin
  m1: process is
  begin
    sel <= 0;
    wait for 0 ns;
    if (c = '1') then
      sel <= sel + 1;
    end if;
    wait for 0 ns;
    case sel is
      when 0 =>
        z <= a;
      when 1 =>
        z <= b;
    end case;
    wait on a, b, c;
  end process m1;
end architecture correct1;


architecture correct2 of mux is
begin
  m1: process (a, b, c) is
    variable sel : integer range 0 to 1;
  begin
    sel := 0;
    if (c = '1') then
      sel := sel + 1;
    end if;
    case sel is
      when 0 =>
        z <= a;
      when 1 =>
        z <= b;
    end case;
  end process m1;
end architecture correct2;

