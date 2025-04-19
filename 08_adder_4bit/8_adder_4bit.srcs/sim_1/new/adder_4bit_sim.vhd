-- SIMULATION 4-bit Adder
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder_4bit_sim is
--  Port ( );
end adder_4bit_sim;

architecture Behavioral of adder_4bit_sim is

COMPONENT adder_4bit
Port (      A  : in  STD_LOGIC_VECTOR (3 downto 0);
			B  : in  STD_LOGIC_VECTOR (3 downto 0);
			ci : in  STD_LOGIC;
			co : out  STD_LOGIC;
            Y  : out STD_LOGIC_VECTOR (3 downto 0));
END COMPONENT;
--Inputs (combined ci, A and B inputs)
signal input : std_logic_vector (8 downto 0) := (others => '0');

--Outputs
signal output : std_logic_vector (4 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: adder_4bit PORT MAP (
A  => input(3 downto 0),
B  => input(7 downto 4),
ci => input(8),
co => output(4),
Y  => output(3 downto 0)
);

-- Stimulus process
stim_proc: process
-- there are 2^9 = 64*32 combinations for a 9-bit bus
variable i          : integer range 0 to 2**9 := 0;
-- there are 2^5 = 64 combinations for a 5-bit bus
variable calculated : integer range 0 to 2**5 := 0;
variable actual     : integer range 0 to 2**5 := 0;

begin
    -- we set a for loop for generating stimulus
    for i in 0 to 2**9 loop
	    -- use loop counter as input Stimulus
		-- cast and assign i to input
        input <= std_logic_vector(to_unsigned(i, input'length));
        
    	-- wait for clk_period
        wait for clk_period;
        -- evaluate responses
        -- calculated result converted to integer
		calculated   := to_integer(unsigned(input(3 downto 0))) + 
		  to_integer(unsigned(input(7 downto 4))) + 
		  to_integer(unsigned(input(8 downto 8)));
		-- actual module output converted to integer
		actual := to_integer(unsigned(output));
        -- inequality between calculated and actual indicate an error
        if (calculated /= actual ) then
          report "error on calculated = " & integer'image(calculated) & 
            " actual result = " & integer'image(actual) severity error;
        end if;
 
     end loop;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process stim_proc;

end Behavioral;
