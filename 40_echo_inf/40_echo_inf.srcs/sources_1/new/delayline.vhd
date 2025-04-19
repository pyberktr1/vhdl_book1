-- ECHO MIKE DELAY LINE MODULE DESIGN
-- 20.03.2025 (DD.MM.YYYY) by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Signed arithmetic library
use IEEE.STD_LOGIC_SIGNED.ALL;

entity delayline is
    -- define code adapting constants in the Generic body
    Generic (
    -- define number of input port bits here
    nbits : integer := 16;
    -- sample frequency (hz)
    fs    : integer := 48000;
	-- delay line elements (td = ndelay/fs seconds)
	ndelay : integer := 4800
	
    );
    Port ( 
	  reset : in  STD_LOGIC; -- master reset
	  clk   : in  STD_LOGIC; -- clock
	  -- delay input
	  din   : in  STD_LOGIC_VECTOR(nbits-1 downto 0); 
	  -- delay output
	  dout  : out STD_LOGIC_VECTOR(nbits-1 downto 0)  
           );
end delayline;

architecture Behavioral of delayline is
-- 2-D array type definitions
type vect_arr is array 
  ( integer range <>) of 
    STD_LOGIC_VECTOR(nbits-1 downto 0);
-- interconnecting signal array
signal q     : vect_arr(0 to ndelay) 
             := (others => (others => '0'));

begin
-- input output connections
q(0) <= din;
dout <= q(ndelay);
-- delay line generate
delay_gen: 
  for i in 0 to ndelay-1 generate   
    begin
	  delay_inst : entity work.delay 
	  generic map
	    (
        -- define number of input port bits here
        nbits => nbits
		)
	  port map   
        (
	       reset => reset,
           clk   => clk,
           din   => q(i),
           dout  => q(i+1)
	    );  

	end generate delay_gen;

end Behavioral;
