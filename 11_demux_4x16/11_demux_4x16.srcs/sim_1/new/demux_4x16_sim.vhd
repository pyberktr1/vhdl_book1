-- SIMULATION 4-LINE TO 16-LINE MULTIPLEXER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity demux_4x16_sim is
--  Port ( );
end demux_4x16_sim;

architecture Behavioral of demux_4x16_sim is

COMPONENT demux_4x16
Port (      
    X  : in  std_logic_vector (3 downto 0);
    EN : in  std_logic;
    Y  : out std_logic_vector (15 downto 0)
            );
END COMPONENT;
--Inputs
signal input : std_logic_vector (3 downto 0) := "0000";
signal EN    : std_logic := '1';
--Outputs
signal output : std_logic_vector (15 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: demux_4x16 PORT MAP (
X  => input,
EN => EN,
Y  => output
);

-- Stimulus process
stim_proc: process
variable i : integer range 0 to 16 := 0;
begin
    -- we will select 1 of 16 outputs
    while (i <= 15) loop
        input <= std_logic_vector(to_unsigned(i, input'length));
        -- increment counter
        i := i + 1;
        wait for clk_period;
        
    end loop;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
