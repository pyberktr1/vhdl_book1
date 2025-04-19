-- SIMULATION AND-OR implementation of XOR Gate
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity andor_sim is
--  Port ( );
end andor_sim;

architecture Behavioral of andor_sim is

COMPONENT andor
Port (      X : in  STD_LOGIC_VECTOR (1 downto 0);
			Y : out STD_LOGIC );

END COMPONENT;
--Inputs
signal input : std_logic_vector (1 downto 0) := (others => '0');

--Outputs
signal output : std_logic;

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: andor PORT MAP (
X => input,
Y => output
);

-- Stimulus process
stim_proc: process
-- there are 4 combinations for a 2-bit bus
variable i : integer range 0 to 4 := 0;
begin
    -- we set a while loop for generating stimulus
    while (i <= 4) loop
	    -- use loop counter as input Stimulus
		-- cast and assign i to input
        input <= std_logic_vector(to_unsigned(i, input'length));
       
        i := i + 1;-- increment loop counter
		-- wait for clk_period
        wait for clk_period;
        
     end loop;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process stim_proc;

end Behavioral;
