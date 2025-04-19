-- SIMULATION FOR LOOP
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity for_loop_sim is
--  Port ( );
end for_loop_sim;

architecture Behavioral of for_loop_sim is

COMPONENT for_loop
Port (      X : in  STD_LOGIC_VECTOR (3 downto 0);
            Y : out STD_LOGIC_VECTOR (2 downto 0));
END COMPONENT;
--Inputs
signal input : std_logic_vector (3 downto 0) := (others => '0');

--Outputs
signal output : std_logic_vector (2 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: for_loop PORT MAP (
X => input,
Y => output
);

-- Stimulus process
stim_proc: process
-- there are 16 combinations for a 4-bit bus
variable i : integer range 0 to 16 := 0;
begin
    -- we set a while loop for generating stimulus
    while (i <= 15) loop
	    -- use loop counter as input Stimulus
		-- cast and assign i to input
        input <= std_logic_vector(to_unsigned(i, input'length));
       
        i := i + 1;-- increment loop counter
		-- wait for clk_period
        wait for clk_period;
        -- evaluate responses
        case input is
		    -- we are using hex-radix for easy input representation
            when X"F" => assert (output= "000") report "error" severity error;
            when X"E" => assert (output= "001") report "error" severity error;
            when X"D" => assert (output= "001") report "error" severity error;
            when X"C" => assert (output= "010") report "error" severity error;
            when X"B" => assert (output= "001") report "error" severity error;
            when X"A" => assert (output= "010") report "error" severity error;
            when X"9" => assert (output= "010") report "error" severity error;
            when X"8" => assert (output= "011") report "error" severity error;
            when X"7" => assert (output= "001") report "error" severity error;
            when X"6" => assert (output= "010") report "error" severity error;
            when X"5" => assert (output= "010") report "error" severity error;
            when X"4" => assert (output= "011") report "error" severity error;
            when X"3" => assert (output= "010") report "error" severity error;
            when X"2" => assert (output= "011") report "error" severity error;
            when X"1" => assert (output= "011") report "error" severity error;
            when X"0" => assert (output= "100") report "error" severity error;
            when others => assert (output= "000") report "error" severity error;
 
           end case;
     end loop;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process stim_proc;

end Behavioral;
