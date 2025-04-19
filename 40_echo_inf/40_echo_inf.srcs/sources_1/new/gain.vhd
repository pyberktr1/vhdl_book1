-- ECHO MIKE GAIN MODULE DESIGN
-- 20.03.2025 (DD.MM.YYYY) by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Signed arithmetic library
use IEEE.STD_LOGIC_SIGNED.ALL;

entity gain is
    -- define code adapting constants in the Generic body
    Generic (
    -- define number of input port bits here
    nbits : integer := 16;
	-- gain input bit depth
	ngain : integer := 5
	
    );
    Port ( 
	  reset : in  STD_LOGIC; -- master reset
	  clk   : in  STD_LOGIC; -- clock
	  -- input
	  din   : in  STD_LOGIC_VECTOR(nbits-1 downto 0); 
	  -- gain input
	  gain  : in  STD_LOGIC_VECTOR(ngain-1 downto 0); 
	  -- output
	  dout  : out STD_LOGIC_VECTOR(nbits+ngain-1 downto 0)  
           );
end gain;

architecture Behavioral of gain is

begin

-- multiplier process
mult_proc: process(clk)
begin
  if rising_edge(clk) then
    if (reset = '1') then
	  dout <= (others => '0');
	else
	  -- registered outputs 
	  -- incorporate delay
	  dout <= din * gain;
	end if;
  end if;
end process;

end Behavioral;
