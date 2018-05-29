---------------------------------------------------------------------
--              Digital System Design with VHDL 2nd Edition
--              Mark Zwolinski
--              Pearson Education, 2004, ISBN 0-13-039985-X
--
--              Chapter 6, page 148
--
-- Design unit: booth(rtl) (Entity and Architecture)
--            :
-- File name  : booth.vhd
--            :
-- Description: RTL description of Booth multiplier
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
use IEEE.std_logic_1164.all, IEEE.numeric_std.all;
entity booth is
  generic(al : NATURAL := 16;
          bl : NATURAL := 16;
          ql : NATURAL := 32);
  port(ain : in std_logic_vector(al-1 downto 0);
       bin : in std_logic_vector(bl-1 downto 0);
       qout : out std_logic_vector(ql-1 downto 0);
       clk : in std_logic;
       load : in std_logic;
       ready : out std_logic);
end entity booth;

architecture rtl of booth is
begin
  process (clk) is
    variable count : INTEGER range 0 to al;
    variable pa : signed((al+bl) downto 0);
    variable a_1 : std_logic;
    alias p : signed(bl downto 0) is pa((al + bl) downto al);
  begin
    if (rising_edge(clk)) then
      if load = '1' then
        p := (others => '0');
        pa(al-1 downto 0) := signed(ain);
        a_1 := '0';
        count := al;
        ready <= '0';
      elsif count > 0 then
        case std_logic_vector'(pa(0), a_1) is
          when "01" =>
            p := p + signed(bin);
          when "10" =>
            p := p - signed(bin);
          when others => null;
        end case;
        a_1 := pa(0);
        pa := shift_right(pa, 1); 
        count := count - 1;
      end if;
      if count = 0 then
        ready <= '1';
      end if;  
      qout <= std_logic_vector(pa(al+bl-1 downto 0));
    end if;
  end process;
end architecture rtl;

