-- SERIAL IN PARELLEL OUT SHIFT REGISTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity serin_parout is
    Port ( 
    din   : in STD_LOGIC;
    reset : in STD_LOGIC;
    clk   : in STD_LOGIC;
    dout  : out std_logic_vector(7 downto 0)
    );
end serin_parout;

architecture Behavioral of serin_parout is
-- shift register intermeditate signal
signal shift: std_logic_vector(7 downto 0):= (others => '0');

begin

-- output assignment
dout <= shift;

-- left shift process
shift_proc: process(clk)
begin
    if rising_edge(clk) then
        if (reset = '1') then         -- there is a reset signal
            shift <= (others => '0'); -- clear all outputs
        else                          -- shift left one bit
            shift <= shift(6 downto 0) & din; 
        end if;
    end if;    
end process;

end Behavioral;
