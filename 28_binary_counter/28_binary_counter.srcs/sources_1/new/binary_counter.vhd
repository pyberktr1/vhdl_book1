-- 4-BIT BINARY COUNTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity binary_counter is
    Port ( 
    q      : out std_logic_vector(3 downto 0);
    clk    : in STD_LOGIC;
    resetn : in STD_LOGIC
    );
end binary_counter;

architecture Behavioral of binary_counter is
-- intermediate signal 
signal cnt: std_logic_vector(3 downto 0):= (others => '0');

begin
-- all outputs connected to cnt counter signal
q <= cnt;
-- counter process cnt_proc
cnt_proc: process(clk)
begin
    if rising_edge(clk) then
        if (resetn = '0') then -- there is a reset signal
            cnt <= (others => '0'); -- clear all bits
        else
            cnt <= cnt + 1; -- increment counter
        end if;
    end if;    
end process;

end Behavioral;
