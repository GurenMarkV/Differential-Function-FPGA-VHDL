-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

--Group Member: Daksh Patel         ID: 104 030 031
--Group Member: Nyasha Kapfumvuti	ID: 104 121 166
--Group Member: Khalifa Badamasi		ID: 103 674 900
--
--Project 1: VHDL Implementation of Single Purpose Processor


library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--library ieee_proposed;
--use ieee_proposed.fixed_pkg.all;

entity Project1_vhd is

	port(
		clk		: in	std_logic;
		start	 : in	std_logic;
		rst	 : in	std_logic;
		x_in, u_in, y_in	: in std_logic_vector(15 downto 0);
	 	x_out, u_out, y_out : out std_logic_vector(15 downto 0)
	);
	
end entity;

architecture rtl of Project1_vhd is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3, s4, s5, s6);
	
	-- Register to hold the current state
	signal state   : state_type;
	--shared variable count : INTEGER range 0 to 10;
	-- Internal Variables
	signal x_o, u_o, y_o, x_i, u_i, y_i :  std_logic_vector(15 downto 0);
	signal rx4, rx2, rdx, r3, rudx, r3ux4_yx4, rux4_x4y, ru_y :  std_logic_vector(15 downto 0);
	signal tempMult : std_logic_vector(31 downto 0);

	
	-- Booth Multiplier Variables 
	signal mult_ina, mult_inb : std_logic_vector(15 downto 0);
	signal mload : std_logic := '1'; 
	signal mready : std_logic;
	signal mult_o : std_logic_vector(31 downto 0);
	-- Booth Component Ports
	component booth port(ain : in std_logic_vector(15 downto 0);
       bin : in std_logic_vector(15 downto 0);
       qout : out std_logic_vector(31 downto 0);
       clk : in std_logic;
       load : in std_logic;
       ready : out std_logic);
	end component;
	
	
	-- Full Adder Variables
	signal add_A, add_B: std_logic_vector(15 downto 0);
	signal add_Sum : std_logic_vector(16 downto 0);
	
	
	-- Full Adder Ports
	component ripple_carry_adder port(i_add_term1, i_add_term2: in std_logic_vector(15 downto 0);
       
       o_result : out std_logic_vector(16 downto 0)
       );
	end component;
	
	-- Mux Variables
	signal mux1out : std_logic_vector(15 downto 0);
	signal mux2out : std_logic_vector(15 downto 0);
	signal mux3out : std_logic_vector(15 downto 0);
	signal mux1s : std_logic;
	signal mux2s : std_logic;
	signal mux3s : std_logic;
	
	-- Mux Ports
	component mux_2to1 port (A,B : in std_logic_vector(15 downto 0);
	S:IN std_logic;
	Y:OUT std_logic_vector(15 downto 0));
	end component;
	
begin
	-- Booth Port Map
	mult1 : booth port map (ain => mult_ina, bin => mult_inb, qout => mult_o, clk => clk, load => mload, ready => mready);
	-- Full Adder Port Map
	add1 : ripple_carry_adder port map (i_add_term1 => add_A, i_add_term2 => add_B, o_result => add_Sum);
	-- Mux Port Map
	mux1 : mux_2to1 port map (A => x_in, B => x_o, S => mux1s, Y => x_i);
	mux2 : mux_2to1 port map (A => u_in, B => u_o, S => mux2s, Y => u_i);
	mux3 : mux_2to1 port map (A => y_in, B => y_o, S => mux3s, Y => y_i);

	rdx <= "0000000000000001";
	r3 <= "0000000000000110";
--	x_i <= x_in;
--	u_i <= u_in;
--	y_i <= y_in;

	
	-- Logic to advance to the next state
	process (clk, rst)
	
	begin
		if rst = '1' then
			state <= s0;
		elsif (rising_edge(clk)) then
		--elsif count > 0 then
			case state is
				when s0=>
					if start = '1' then
						state <= s1;
					else
						state <= s0;
					end if;
				when s1=>
					if start = '1' then
						state <= s2;
					else
						state <= s1;
					end if;
				when s2=>
					if start = '1' then						
						state <= s3;
					else
						state <= s2;
					end if;
				when s3 =>
					if start = '1' then
						state <= s4;
					else
						state <= s3;
					end if;
				when s4=>
					if start = '1' then						
						state <= s5;
					else
						state <= s4;
					end if;
				when s5=>
					if start = '1' then						
						state <= s6;
					else
						state <= s5;
					end if;
				when s6=>
					if start = '1' then						
						state <= s0;
					else
						state <= s6;
					end if;
			end case;
		end if;
	end process;
	
	-- Output depends solely on the current state
	process (state)
	begin
	
		mux1s <= '0';
		mux2s <= '0';
		mux3s <= '0';
		
		case state is
			when s0 =>
				mult_ina <= x_i;
				mult_inb <= x_i;
				tempMult <= mult_o;
				
				
				--tempMult <= x_i*x_i; 
				rx2 <= tempMult(15 downto 0);
				--x_out <= x_i + rdx;	
				add_A <= x_i;
				add_B <= rdx;
				
				if add_Sum(16) = '1' then
					x_o <= add_Sum(16 downto 1);
				else 
					x_o <= add_Sum(15 downto 0);	
				end if;
				
			when s1 =>
				mult_ina <= rx2;
				mult_inb <= rx2;
			
				--tempMult <= rx2*rx2;
				rx4 <= tempMult(15 downto 0);
				--ru_y <= u_i + y_i;
				
				add_A <= u_i;
				add_B <= y_i;
				if add_Sum(16) = '1' then
					ru_y <= add_Sum(16 downto 1);
				else 
					ru_y <= add_Sum(15 downto 0);	
				end if;
				
			when s2 =>
				mult_ina <= rx4;
				mult_inb <= ru_y;
				
				--tempMult <= rx4*ru_y;
				rux4_x4y <= tempMult(15 downto 0);
			when s3 =>
				mult_ina <= rux4_x4y;
				mult_inb <= r3;
				
				--tempMult <= rux4_x4y*r3;
				r3ux4_yx4 <= tempMult(15 downto 0);
			when s4 =>
				mult_ina <= u_i;
				mult_inb <= rdx;
		
				--tempMult <= u_i*rdx;
				rudx <= tempMult(15 downto 0);
				--u_o <= r3ux4_yx4 + u_i;
				add_A <= u_i;
				add_B <= r3ux4_yx4;
				if add_Sum(16) = '1' then
					u_o <= add_Sum(16 downto 1);
				else 
					u_o <= add_Sum(15 downto 0);	
				end if;
				
			when s5 =>
				--y_o <= rudx + y_i;
				add_A <= rudx;
				add_B <= y_i;
				if add_Sum(16) = '1' then
					y_o <= add_Sum(16 downto 1);
				else 
					y_o <= add_Sum(15 downto 0);	
				end if;
				
			when s6 =>
--				y_i <= y_o;
--				x_i <= x_o;
--				u_i <= u_o;
				mux1s <= '1';
				mux2s <= '1';
				mux3s <= '1';
				
				y_out <= y_o;
				x_out <= x_o;
				u_out <= u_o;

		end case;
	end process;
	
end rtl;
