-- SIMULATION BCD TO DECIMAL DECODER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcd2dec_sim is
--  Port ( );
end bcd2dec_sim;

architecture Behavioral of bcd2dec_sim is

COMPONENT bcd2dec
Port (      
    X : in  std_logic_vector(3 downto 0);
    Y : out std_logic_vector(9 downto 0)

            );
END COMPONENT;
--Inputs
signal input  : std_logic_vector (3 downto 0) := "0000";
--Outputs
signal output : std_logic_vector (9 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: bcd2dec PORT MAP (
X => input,
Y => output
);

-- Stimulus process
stim_proc: process
variable i          : integer range 0 to 16    := 0;
variable calculated : integer range 0 to 2**10 := 0;
variable actual     : integer range 0 to 2**10 := 0;

begin
    -- we set a for loop for generating stimulus
    for i in 0 to 15 loop
	    -- use loop counter as input Stimulus
		-- cast and assign i to input
        input <= std_logic_vector(to_unsigned(i, input'length));
        
    	-- wait for clk_period
        wait for clk_period;
        -- evaluate responses
        -- calculated result in integer
		calculated := 1023 - 2**i;
		-- set calculated to 1023 for the undefined codes
		if (calculated < 0) then 
		  calculated := 1023;
		end if;
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

end process;

end Behavioral;
