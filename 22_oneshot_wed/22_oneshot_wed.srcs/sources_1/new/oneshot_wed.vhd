-- ONESHOT Non-Retriggerable Monostable Multi-Vibrator (MMV)
-- with edge trigger input
-- 26.02.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity oneshot is
    Port ( 
    trig : in STD_LOGIC;					-- trigger input
    pd   : in std_logic_vector(3 downto 0); -- pulse duration input
    clk  : in STD_LOGIC;                    -- clock
    Q    : out STD_LOGIC                    -- pulse output
    );
end oneshot;

architecture Behavioral of oneshot is
-- internal counter for pulse timing
signal cnt : std_logic_vector(3 downto 0):= "0000";
-- rising edge detector function
signal ret      : std_logic := '0';
signal del_trig : std_logic := '0';

begin
-- when rising edge occurs, 
-- trig='1' and del_trig='0'
ret <= trig and not del_trig;

-- del_trig process for tracking trigger 
-- input changes with delay
del_trig_proc: process(clk)
begin
  if rising_edge(clk) then
    del_trig <= trig;
  end if;
end process;

-- non-retriggerable MMV process
-- clock frequency and pd input determines the pulse width
-- the generated pulse is positive (positive logic output)
oneshot_proc: process(clk)
begin
    -- synhronize timing to positive edge of clock signal
    if rising_edge(clk) then 
        if (ret = '1') then -- there is a trigger signal
		    -- trigger only when output is not busy
            if (cnt = "0000") then -- oneshot ready to trigger
                cnt <= pd; -- reload cnt with pulse duration
                Q <= '1';  -- start a positive pulse
            else -- oneshot busy, continue to decrement
                cnt <= cnt - 1;
				-- pulse stop will be delayed by one clock cycle
				-- the command will be executed after one cycle
                if (cnt = "0001") then -- cnt=0 will be too late
                    Q <= '0'; -- stop pulse
                else
                    Q <= '1'; -- continue pulse
                end if;
            end if;
        else -- no trigger signal
            if (cnt = "0000") then -- wait state, oneshot ready
                cnt <= cnt; -- hold state
                Q <= '0';   
            else -- oneshot busy
                cnt <= cnt - 1; -- decrement cnt
                if (cnt = "0001") then
                    Q <= '0'; -- stop pulse
                else
                    Q <= '1'; -- continue pulse
                end if;
            end if;
        end if;
    end if;    
end process;

end Behavioral;
