-- MODIFIED 4-BIT BCD COUNTER
-- 04.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_counter_mod is
    Port ( 
    q      : out std_logic_vector(3 downto 0); 
    clk    : in  STD_LOGIC;
    co     : out STD_LOGIC;-- carry out 
    ci     : in  STD_LOGIC;-- carry in 
    resetn : in  STD_LOGIC -- negative logic
    );
end bcd_counter_mod;

architecture Behavioral of bcd_counter_mod is
-- intermediate signal cnt
signal cnt: std_logic_vector(3 downto 0):= (others => '0');

begin
-- counter cnt connected to output
q <= cnt;
-- carry out process
co_proc: process(cnt, ci)
begin
    -- co pulse must last only one clock cycle 
    -- for each digit in the top module
	if (cnt = x"9") and (ci='1') then
		co <= '1'; -- carry pulse
	else
		co <= '0'; -- no carry pulse
	end if;
end process;

-- counter process
cnt_proc: process(clk)
begin
    if rising_edge(clk) then -- rising edge clock
        if (resetn = '0') then -- there is a reset signal
            cnt <= (others => '0'); -- clear counter
        else                        -- no reset, count up
		  if (ci = '1') then        -- there is a carry
            if (cnt >= x"9") then   -- next state zero
                cnt <= x"0";  -- clear counter
            else -- count normal
                cnt <= cnt + 1; -- increment counter
            end if;
		  else -- no carry, hold state
		    cnt <= cnt;
		  end if;
        end if;
    end if;    
end process;
end Behavioral;
