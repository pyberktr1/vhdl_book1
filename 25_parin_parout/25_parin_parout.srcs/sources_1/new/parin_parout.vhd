-- PARALLEL IN PARALLEL OUT SHIFT REGISTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parin_parout is
    Port ( 
    serin  : in STD_LOGIC; -- serial input
    resetn : in STD_LOGIC; -- negative logic
    sh_ldn : in STD_LOGIC; -- shift/load input
    clk    : in STD_LOGIC; -- clcok input
    clken  : in STD_LOGIC; -- clcok enable input
	-- 8-bit data input/output buses
    d      : in std_logic_vector(7 downto 0);
    Q      : out std_logic_vector(7 downto 0)
    );
end parin_parout;

architecture Behavioral of parin_parout is
signal shift: std_logic_vector(7 downto 0):= (others => '0');

begin
-- SR outputs are connected to output
Q <= shift;

shift_proc: process(clk, clken)
begin
    if rising_edge(clk) then -- act on rising edge clock pulse
        if (resetn = '0') then -- there is a reset signal
            shift <= (others => '0'); -- clear SR
        else -- no reset
            if (clken = '1') then -- act on clock pulses
                if (sh_ldn = '1') then -- shift (left) out
					-- shift left one bit
                    shift <= shift(6 downto 0) & serin; 
                else
                    shift <= d; -- load parallel data
                end if;
            else
                shift <= shift; -- hold status
            end if;
        end if;
    end if;    
end process;

end Behavioral;
