-- ECHO MIKE DELAY MODULE DESIGN
-- 20.03.2025 (DD.MM.YYYY) by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Signed arithmetic library
use IEEE.STD_LOGIC_SIGNED.ALL;

entity delay is
    -- define code adapting constants in the Generic body
    Generic (
    -- define number of input port bits here
    nbits : integer := 16
	
    );
    Port ( 
	  reset : in  STD_LOGIC; -- master reset
	  clk   : in  STD_LOGIC; -- clock
	  -- delay input
	  din   : in  STD_LOGIC_VECTOR(nbits-1 downto 0); 
	  -- delay output
	  dout  : out STD_LOGIC_VECTOR(nbits-1 downto 0)  
           );
end delay;

architecture Behavioral of delay is

begin

-- delay process
delay_proc: process(clk)
begin
  if rising_edge(clk) then
    if (reset = '1') then
	  dout <= (others => '0');
	else
	  -- registered outputs 
	  -- incorporate delay
	  dout <= din;
	end if;
  end if;
end process;

end Behavioral;
