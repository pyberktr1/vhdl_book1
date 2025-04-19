-- 4-BIT PRELOADED UP-DOWN COUNTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity up_down_counter is
    Port ( 
    q       : out std_logic_vector(3 downto 0); -- output
    d       : in  std_logic_vector(3 downto 0); -- data input
    clk     : in  STD_LOGIC;
    ld      : in  STD_LOGIC; -- load input
    down    : in  STD_LOGIC; -- down count input
    resetn  : in  STD_LOGIC  -- negative logic reset
    );
end up_down_counter;

architecture Behavioral of up_down_counter is
-- intermediate counter signal
signal cnt: std_logic_vector(3 downto 0):= (others => '0');

begin
-- cnt is connected to output
q <= cnt;
-- counter process
cnt_proc: process(clk)
begin
    if rising_edge(clk) then
        if (resetn = '0') then -- there is a reset signal
            cnt <= (others => '0'); -- clear counter
        else -- no reset, continue with other tasks
            if (ld = '1') then -- load counter with data
                cnt <= d;
            else -- count!
                if (down = '0') then -- count up
                    cnt <= cnt + 1;  -- increment
                else                 -- count down
                    cnt <= cnt - 1;  -- decrement
                end if;
            end if;
        end if;
    end if;    
end process;
end Behavioral;
