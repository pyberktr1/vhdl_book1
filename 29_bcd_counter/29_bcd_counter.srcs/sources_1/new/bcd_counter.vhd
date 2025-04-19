-- 4-BIT BCD COUNTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_counter is
    Port ( 
    q      : out std_logic_vector(3 downto 0); 
    clk    : in  STD_LOGIC;
    co     : out STD_LOGIC;-- carry out 
    resetn : in  STD_LOGIC -- negative logic
    );
end bcd_counter;

architecture Behavioral of bcd_counter is
-- intermediate signal cnt
signal cnt: std_logic_vector(3 downto 0):= (others => '0');

begin
-- counter cnt connected to output
q <= cnt;
-- counter process
cnt_proc: process(clk)
begin
    if rising_edge(clk) then -- rising edge clock
        if (resetn = '0') then -- there is a reset signal
            cnt <= (others => '0'); -- clear counter
            co <= '0';              -- clear carry out
        else                        -- no reset, count up
            if (cnt = x"9") then    -- next state zero
                cnt <= x"0";  -- clear counter
                co  <= '1';   -- generate carry pulse
            else -- count normal
                cnt <= cnt + 1; -- increment counter
                co  <= '0';     -- no carry out pulse
            end if;
        end if;
    end if;    
end process;
end Behavioral;
