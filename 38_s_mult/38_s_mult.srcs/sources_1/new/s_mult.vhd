-- TWO'S COMPLEMENT SIGNED BINARY NUMBER MULTIPLICATION DESIGN
-- 19.03.2025 (DD.MM.YYYY) by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Signed arithmetic library
use IEEE.STD_LOGIC_SIGNED.ALL;

entity s_mult is
    Port ( 
	  reset : in  STD_LOGIC; -- master reset
	  clk   : in  STD_LOGIC; -- clock
	  -- multiplier input1 (8-bit signed)
	  m1    : in  STD_LOGIC_VECTOR(7 downto 0); 
	  -- multiplier input2 (5-bit signed)
	  m2    : in  STD_LOGIC_VECTOR(4 downto 0); 
	  -- multiplier output (8-bit signed)
	  o     : out STD_LOGIC_VECTOR(7 downto 0)  
           );
end s_mult;

architecture Behavioral of s_mult is

signal mult : STD_LOGIC_VECTOR(12 downto 0) := (others => '0');
signal in1  : STD_LOGIC_VECTOR(7 downto 0)  := (others => '0');
signal in2  : STD_LOGIC_VECTOR(4 downto 0)  := (others => '0');

begin
-- lowest 5-bits are truncated from result to fit it to 8-bits
o <= mult(12 downto 5);

-- multiplier process
mult_proc: process(clk)
begin
  if rising_edge(clk) then
    if (reset = '1') then
	  mult <= (others => '0');
	  in1  <= (others => '0');
	  in2  <= (others => '0');
	else
	  -- registered inputs 
	  -- incorporate delay
	  in1 <= m1;
	  in2 <= m2;
	  mult <= in1*in2;
	end if;
  end if;
end process;

end Behavioral;
