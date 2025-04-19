-- 4-BIT ADDER
-- 10.08.2024 by Bilgehan ERKAL

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- library necessary for arithmetic operations
use IEEE.NUMERIC_STD.ALL;
-- library necessary for operations with unsigned numbers 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder_4bit is
Port (      
    A  : in STD_LOGIC_VECTOR (3 downto 0); -- first number input
    B  : in STD_LOGIC_VECTOR (3 downto 0); -- second number input
    ci : in STD_LOGIC;                     -- carry input
    Y  : out STD_LOGIC_VECTOR (3 downto 0);-- sum output
    co : out STD_LOGIC                     -- carry output
    );
end adder_4bit;

architecture Behavioral of adder_4bit is
-- intermediate result signal
signal result : STD_LOGIC_VECTOR(4 downto 0);
begin
  -- We always extend one of the number inputs by one-bit
  result <= ('0' & A) + B + ci;
  co     <= result(4); -- MSB of the result is carry output
  Y      <= result(3 downto 0); -- output is 4 LSB of the result
    
end Behavioral;
