-- ECHO MIKE ADDER MODULE DESIGN
-- 20.03.2025 (DD.MM.YYYY) by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Signed arithmetic library
use IEEE.STD_LOGIC_SIGNED.ALL;

entity adder is
    -- define code adapting constants in the Generic body
    Generic (
    -- define number of input port bits here
    nbits : integer := 21
	
    );
    Port ( 
	  reset : in  STD_LOGIC; -- master reset
	  clk   : in  STD_LOGIC; -- clock
	  -- input1
	  din1  : in  STD_LOGIC_VECTOR(nbits-1 downto 0); 
	  -- input2
	  din2  : in  STD_LOGIC_VECTOR(nbits-1 downto 0); 
	  -- output
	  dout  : out STD_LOGIC_VECTOR(nbits downto 0)  
           );
end adder;

architecture Behavioral of adder is

begin

-- adder process
mult_proc: process(clk)
begin
  if rising_edge(clk) then
    if (reset = '1') then
	  dout <= (others => '0');
	else
	  -- registered outputs 
	  -- incorporate delay
	  -- sign bit is extended to handle the carry
	  dout <= (din1(nbits-1) & din1) + (din2(nbits-1) & din2);
	end if;
  end if;
end process;

end Behavioral;
