-- RING COUNTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ring_counter is
    Port ( 
    clk : in STD_LOGIC;
    Q   : out std_logic_vector(3 downto 0)
    );
end ring_counter;

architecture Behavioral of ring_counter is
-- intermediate signal
signal shift: std_logic_vector(3 downto 0):= "0001";

begin
-- shift connected to output
Q <= shift;
-- shift process, rotates the initial word
shift_proc: process(clk)
begin
    if falling_edge(clk) then -- falling edge clock
	  -- make a left rotate by inserting MSB to LSB
      shift <= shift(2 downto 0) & shift(3);
    end if;    
end process;


end Behavioral;
