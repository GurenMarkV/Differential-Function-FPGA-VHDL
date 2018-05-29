---------------------------------------------------------------------
--              Digital System Design with VHDL 2nd Edition
--              Mark Zwolinski
--              Pearson Education, 2004, ISBN 0-13-039985-X
--
--              Chapter 6, page 143
--
-- Design unit: rom16x7(sevenseg) (Entity and Architecture)
--            :
-- File name  : rom.vhd
--            :
-- Description: RTL model of ROM containing decoding patterns for
--            : 7 segment display
--            :
-- Limitations: None
--            : 
-- System     : VHDL'93/'02, STD_LOGIC_1164
--            :
-- Author     : Mark Zwolinski
--            : mz@ecs.soton.ac.uk
--
-- Revision   : Version 2.0 10/12/03
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
entity rom16x7 is
  port (address : in INTEGER range 0 to 15;
        data : out std_logic_vector (6 downto 0));
end entity rom16x7;

architecture sevenseg of rom16x7 is
  type rom_array is array (0 to 15) of std_logic_vector(6 downto 0);
  constant rom : rom_array := ("1110111",
                               "0010010",
                               "1011101",
                               "1011011",
                               "0111010",
                               "1101011",
                               "1101111",
                               "1010010",
                               "1111111",
                               "1111011",
                               "1101101",
                               "1101101",
                               "1101101",
                               "1101101",
                               "1101101",
                               "1101101");
begin
  data <= rom(address);
end architecture sevenseg;

