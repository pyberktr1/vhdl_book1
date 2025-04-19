-- SIMULATION ONESHOT Non-Retriggerable Monostable Multi-Vibrator (MMV)
-- 26.02.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity oneshot_sim is
--  Port ( );
end oneshot_sim;

architecture Behavioral of oneshot_sim is
COMPONENT oneshot
Port (      
    trig : in STD_LOGIC;
    pd   : in std_logic_vector(3 downto 0);
    clk  : in STD_LOGIC;
    Q    : out STD_LOGIC
    
    );
END COMPONENT;
--Inputs
signal trig : std_logic := '0';
signal clk  : std_logic := '0';
signal pd   : std_logic_vector (3 downto 0) := "0000";

--Outputs
signal Q    : std_logic;

-- Clock period definitions
constant clk_period : time := 50 ns;

begin

-- Instantiate the Unit Under Test (UUT)
uut: oneshot PORT MAP (
trig => trig,
clk  => clk,
pd   => pd,
Q    => Q
);

-- Clock process definitions
clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

stim_proc: process
begin
    -- wait for clock to stabilize
    wait for clk_period*2;
	-- set duration and trigger MMV
    pd   <= "0001";
    trig <= '1';
    wait for clk_period*6;
	-- end trigger pulse
    trig <= '0';
    wait for clk_period*4;
	-- increase duration andd trigger MMV
    pd   <= "0011";
    trig <= '1';
    wait for clk_period;
	-- end trigger pulse
    trig <= '0';
    wait for clk_period;
	-- re-trigger MMV
    trig <= '1';
    wait for clk_period;
	-- end trigger pulse
    trig <= '0';
    wait for clk_period;
	-- re-trigger MMV
    trig <= '1';
    wait for clk_period*12;
    
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
