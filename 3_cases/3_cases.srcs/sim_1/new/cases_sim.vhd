-- SIMULATION OF CASE STRUCTURES
-- 10.08.2024 by Bilgehan ERKAL

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity case_sim is
--  Port ( );
end case_sim;

architecture Behavioral of case_sim is

-- uut component declaration
COMPONENT cases
Port (      sel : in  STD_LOGIC_VECTOR (2 downto 0);
            y   : out STD_LOGIC_VECTOR (6 downto 0));
END COMPONENT;
--Inputs
signal input : std_logic_vector (2 downto 0) := "000";

--Outputs
signal output : std_logic_vector (6 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: cases PORT MAP (
sel => input, -- connect local signal input (stimulus) to sel
y   => output -- connect local signal output (response) to y
);

-- Stimulus process
stim_proc: process
-- counter variable to count simulation cycles
variable i : integer range 0 to 8 := 0;
begin
    -- we use a while loop for counting 7 cycles in simulation
    while (i <= 7) loop
        -- integer var i is cast to std_logic_vector datatype 
        -- to be sent to input signal
        -- this signal provides an input stimulus to 
        -- sel input of the cases uut
        input <= std_logic_vector(to_unsigned(i, input'length));
       
        i := i + 1; -- increment var i for each cycle
        wait for clk_period;-- wait for 100ns before next cycle
        -- evaluate input and output of cases uut, report error if actual outputs
        -- does not comply with the expected outputs        
        case input is
            when "000" => assert (output="0000000") report "error on input 0" severity error;
            when "001" => assert (output="0000001") report "error on input 1" severity error;
            when "010" => assert (output="0000010") report "error on input 2" severity error;
            when "011" => assert (output="0000100") report "error on input 3" severity error;
            when "100" => assert (output="0001000") report "error on input 4" severity error;
            when "101" => assert (output="0010000") report "error on input 5" severity error;
            when "110" => assert (output="0100000") report "error on input 6" severity error;
            when "111" => assert (output="1000000") report "error on input 7" severity error;
            
            when others => assert (output="0000000") report "error on others" severity error;
          end case;
     end loop;

-- simulation stops completely
-- report a false failure to end simulation
assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;

