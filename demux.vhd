---------------------------------------------------------------------
--              Digital System Design with VHDL 2nd Edition
--              Mark Zwolinski
--              Pearson Education, 2004, ISBN 0-13-039985-X
--
--              Chapter 4, page 64
--
-- Design unit: mux(mux1, mux2) (Entity and Architectures)
--            :
-- File name  : mux.vhd
--            :
-- Description: 
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
entity mux is
  port (a, b: out std_logic_vector(15 downto 0);
        s: in std_logic;
        y: in std_logic_vector(15 downto 0));
end entity mux;

architecture mux1 of mux is
begin
  with s select
    y => a when "0",
         b when "1",

         'X' when others;
end architecture mux1;

architecture mux2 of mux is
begin
  y => a when s="0" else
       b when s="1" else

       'X';
end architecture mux2;

