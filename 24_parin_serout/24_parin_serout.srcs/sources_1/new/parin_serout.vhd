-- PARALLEL IN SERIAL OUT SHIFT REGISTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parin_serout is
    Port ( 
    serin  : in STD_LOGIC; -- serial data input
    resetn : in STD_LOGIC; -- negative logic reset
    sh_ldn : in STD_LOGIC; -- '1'-shift, '0'-load
    clk    : in STD_LOGIC; -- clock input
    clken  : in STD_LOGIC; -- clock enable
	-- 8-bit parallel data input bus
    d      : in std_logic_vector(7 downto 0);
    Q      : out STD_LOGIC -- serial data output
    );
end parin_serout;

architecture Behavioral of parin_serout is
-- intermediate signal
signal shift: std_logic_vector(7 downto 0):= (others => '0');

begin

-- MSB of output bus is serial data output
Q <= shift(7);
-- Shift process
shift_proc: process(clk, clken)
begin
    if rising_edge(clk) then   -- rising edge clock pulse
        if (resetn = '0') then -- there is a reset signal
            shift <= (others => '0');
        else                   -- out of reset
            if (clken = '1') then -- act on clock pulses
                if (sh_ldn = '1') then -- mode is shift (left) out
				    -- shift left one bit
                    shift <= shift(6 downto 0) & serin; 
                else -- mode is load data
                    shift <= d; -- load parallel data
                end if;
            else --  do nothing
                shift <= shift; -- hold status
            end if;
        end if;
    end if;    
end process;

end Behavioral;
