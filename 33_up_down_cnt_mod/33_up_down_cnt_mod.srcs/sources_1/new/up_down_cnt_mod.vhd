-- 4-BIT MODIFIED PRELOADED UP-DOWN COUNTER
-- 08.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity up_down_cnt_mod is
    Port ( 
    q       : out std_logic_vector(3 downto 0); -- output
    d       : in  std_logic_vector(3 downto 0); -- data input
    clk     : in  STD_LOGIC;
    ld      : in  STD_LOGIC; -- load input
    down    : in  STD_LOGIC; -- down count input
    co      : out STD_LOGIC; -- carry out 
    ci      : in  STD_LOGIC; -- carry in 
    resetn  : in  STD_LOGIC  -- negative logic reset
    );
end up_down_cnt_mod;

architecture Behavioral of up_down_cnt_mod is
-- intermediate counter signal
signal cnt: std_logic_vector(3 downto 0):= (others => '0');

begin
-- cnt is connected to output
q <= cnt;

-- carry out process
co_proc: process(down, cnt, ci)
begin
    -- co pulse must last only one clock cycle 
    -- for each digit in the top module
	-- and changes place according to the mode
	if (down='0') then -- count upwards
	  -- the co pulse on 9-to-0 transition
	  if (cnt = x"9") and (ci='1') then
		co <= '1'; -- carry pulse
	  else
		co <= '0'; -- no carry pulse
	  end if;
	else -- count downwards
	  -- the co pulse on 0-to-9 transition
	  if (cnt = x"0") and (ci='1') then
		co <= '1'; -- carry pulse
	  else
		co <= '0'; -- no carry pulse
	  end if;
	end if;
end process;

-- counter process
cnt_proc: process(clk, resetn, ld, ci, down)
begin
    if rising_edge(clk) then
        if (resetn = '0') then -- there is a reset signal
            cnt <= (others => '0'); -- clear counter
        else -- no reset, continue with other tasks
            if (ld = '1') then -- load counter with data
                cnt <= d;
            else -- count!
			  if (ci = '1') then     -- there is a carry
                if (down = '0') then -- count up
                    cnt <= cnt + 1;  -- increment
                else                 -- count down
                    cnt <= cnt - 1;  -- decrement
                end if;
		      else -- no carry, hold state
		        cnt <= cnt;
		      end if;
            end if;
        end if;
    end if;    
end process;
end Behavioral;
