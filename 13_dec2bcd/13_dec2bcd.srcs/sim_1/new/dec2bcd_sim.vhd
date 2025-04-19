-- SIMULATION DECIMAL TO BCD ENCODER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dec2bcd_sim is
--  Port ( );
end dec2bcd_sim;

architecture Behavioral of dec2bcd_sim is
COMPONENT dec2bcd
Port (      
    X : in  std_logic_vector(8 downto 0);
    Y : out std_logic_vector(3 downto 0)
            );
END COMPONENT;
--Inputs
signal input : std_logic_vector (8 downto 0) := "000000000";

--Outputs
signal output : std_logic_vector (3 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: dec2bcd PORT MAP (
X => input,
Y => output
);


-- Stimulus process
stim_proc: process
-- i stimulus variable
-- j temporary calculation variable
-- k calculated (desired) value variable
variable i, j, k : integer := 0;

begin

  -- generate stimulus and check all input codes
  -- there are 512 codes (0-511) for 9-bit input bus X
  while (i <= 511) loop
      wait for clk_period;

    -- send stimulus to input
    input <= std_logic_vector(to_unsigned(i, input'length));
    -- wait for next cycle   
    wait for clk_period;
	-- calculate desired value
    if (i = 0) then -- desired value 0
      assert (output = "0000") report "failure at input code 0!" & 
        "output: " & integer'image(to_integer(unsigned(output))) 
        severity ERROR;
    else -- test for other codes
      j := i; k := 1;
      -- iterate until active highest priority pin found
      while (j > 1) loop 
        j := j/2;-- instead we can use: 
        -- j := to_integer(shift_right(to_unsigned(j,9),1));
        k := k + 1;
      end loop;
      -- test for the code      
      assert (output = std_logic_vector(to_unsigned(k,4))) 
        report "actual: " & integer'image(to_integer(unsigned(output))) & 
               " desired: " & integer'image(k) severity ERROR;
    end if;
    -- increment counter
	i := i + 1;
  end loop;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process;
end Behavioral;
