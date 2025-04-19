-- BI-DIRECTIONAL SHIFT REGISTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bidir_shift is
    Port ( 
    lserin : in STD_LOGIC; -- left shift serin
    rserin : in STD_LOGIC; -- right shift serin
    resetn : in STD_LOGIC; -- negative logic
	-- mode select input
    s      : in std_logic_vector(1 downto 0);
    clk    : in STD_LOGIC; -- clock input
    clken  : in STD_LOGIC; -- clock enable input
	-- Data I/O buses
    d      : in std_logic_vector(7 downto 0);
    Q      : out std_logic_vector(7 downto 0)
    );
end bidir_shift;

architecture Behavioral of bidir_shift is
-- intertmediate SR signal
signal shift: std_logic_vector(7 downto 0):= (others => '0');

begin
-- SR signal connected to the outputs
Q <= shift;
-- Shift process
shift_proc: process(clk, clken)
begin
    if rising_edge(clk) then -- rising edge clock
        if (resetn = '0') then -- there is a reset signal
            shift <= (others => '0'); -- clear SR
        else
            if (clken = '1') then -- act on clock pulses
			-- Select operation mode
          case s is
		    -- hold status
            when "00" => shift <= shift;
			-- shift right
            when "01" => shift <= rserin & shift(7 downto 1); 
			-- shift left
            when "10" => shift <= shift(6 downto 0) & lserin; 
			-- load SR with data
            when "11" => shift <= d; 
            --hold status
            when others => shift <= shift; 
          end case;
            else -- clock disabled
			  -- hold status
              shift <= shift; 
            end if;
        end if;
    end if;    
end process;

end Behavioral;
