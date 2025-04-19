-- SIMULATION Water Reservoir
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reservoir_sim is
--  Port ( );
end reservoir_sim;

architecture Behavioral of reservoir_sim is

COMPONENT reservoir
Port (      S : in  STD_LOGIC_VECTOR (2 downto 0);
			P : out STD_LOGIC;
			V : out STD_LOGIC );

END COMPONENT;
--Inputs
signal input : std_logic_vector (2 downto 0) := (others => '0');

--Outputs
signal output : std_logic_vector (1 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: reservoir PORT MAP (
S => input,
P => output(1),
V => output(0)
);

-- Stimulus process
stim_proc: process
-- there are 8 combinations for a 3-bit bus
variable i : integer range 0 to 8 := 0;
begin
    -- we set a while loop for generating stimulus
    while (i <= 8) loop
	    -- use loop counter as input Stimulus
		-- cast and assign i to input
        input <= std_logic_vector(to_unsigned(i, input'length));
       
        i := i + 1;-- increment loop counter
		-- wait for clk_period
        wait for clk_period;
        
     end loop;
     -- provide a don't care state
     input <= "101";
     wait for clk_period;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process stim_proc;

end Behavioral;
