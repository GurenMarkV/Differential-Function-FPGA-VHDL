library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

LIBRARY ieee  ; 
LIBRARY std  ;  
USE ieee.std_logic_1164.all  ; 
 
ENTITY Project1_tb  IS 
END ; 
 
architecture test of Project1_tb is 
	component Project1_vhd
		port (
		clk		: in	std_logic;
		start	 : in	std_logic;
		rst	 : in	std_logic;
		x_in, u_in, y_in	: in std_logic_vector(15 downto 0);
	 	x_out, u_out, y_out : out std_logic_vector(15 downto 0)
		);
	end component; 
	
  signal clk_TB		: std_logic;
  signal start_TB	 : std_logic;
  signal rst_TB	 : std_logic;
  signal x_in_TB, u_in_TB, y_in_TB	: std_logic_vector(15 downto 0);
  signal x_out_TB, u_out_TB, y_out_TB : std_logic_vector(15 downto 0);

  
begin
	-- instantiate the ALU
	inst_Project1_vhd:	Project1_vhd
		port map(

		clk =>clk_TB,		
		start =>start_TB,	 
		rst =>rst_TB,	 
		x_in =>x_in_TB, 
		u_in =>u_in_TB, 
		y_in =>y_in_TB,	
	 	x_out =>x_out_TB, 
		u_out =>u_out_TB, 
		y_out =>y_out_TB
		);

	-- Generate clock stimulus
	clk_gen: process 
	begin -- clock period = 10 ns
		clk_TB <= '1';
		wait for 5 ns;
		clk_TB <= '0';
		wait for 5 ns;

		if now >= 2000 ns then -- run for 200 cc
			assert false
			 report "simulation is completed (not error)."
			 severity error;
			wait;
		end if;
	end process;

	data_gen: process 
	begin
  
      x_in_TB <= "0000000000000001";
      u_in_TB <= "0000000000000010";
      y_in_TB <= "0000000000000011";
			start_TB <= '0';  
			rst_TB <= '1';
			wait for 10 ns;
			rst_TB <= '0';
			wait for 10 ns;
			
    
			--input_TB <= (others => "00000000"); --all values 0 at beginning
			wait for 10 ns;
			start_TB <= '1';

		wait;
					
	end process;

end test;