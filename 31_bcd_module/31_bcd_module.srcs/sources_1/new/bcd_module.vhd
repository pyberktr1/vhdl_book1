-- 8-bit BCD COUNTER MODULE
-- 05.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_module is
    -- define code adapting constants in the Generic body
    Generic (
    -- define number of digits here
    num_digits : natural := 4
    
    );
    -- usual port definitions
    Port ( 
    q      : out std_logic_vector(num_digits*4-1 downto 0);
    clk    : in  STD_LOGIC;
    ci     : in  STD_LOGIC;
	co     : out STD_LOGIC;
    resetn : in  STD_LOGIC -- negative logic
    );
end bcd_module;

architecture Behavioral of bcd_module is

component bcd_counter_mod is
    Port ( 
    q      : out std_logic_vector(3 downto 0); 
    clk    : in  STD_LOGIC;
    co     : out STD_LOGIC;-- carry out 
    ci     : in  STD_LOGIC;-- carry in 
    resetn : in  STD_LOGIC -- negative logic
    );
end component bcd_counter_mod;

-- interconnection signals
-- new arrary type is defined
type dig_array is
  array(num_digits-1 downto 0) of std_logic_vector(3 downto 0);
	  
signal c      : std_logic_vector(num_digits downto 0) := (others => '0');
signal digits : dig_array := (others => (others => '0'));

begin
  -- module input output pins 
  -- connected to respective signals
  q_gen:
    for i in 0 to num_digits-1 generate
      begin
        q ( 4*i+3 downto 4*i ) <= digits(i);
      end generate q_gen;
  c(0) <= ci;
  co   <= c(num_digits);
  
  -- modular bcd counter implementation
  -- generate statement
bcd_gen :
  -- bcd_counter_mod module instantiated 2 times.
  for i in 0 to num_digits-1 generate   
    begin
      bcd_counter_mod_inst : bcd_counter_mod 
	  port map   
       (
	   q      => digits(i),
       clk    => clk,
       ci     => c(i),
       co     => c(i+1),
       resetn => resetn
			);  
    end generate bcd_gen;
	
end architecture Behavioral;
