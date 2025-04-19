-- FOR LOOP
-- Example for counting zeroed bits in input port
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity for_loop is
    Port ( X : in  STD_LOGIC_VECTOR (3 downto 0);  -- input port
           Y : out STD_LOGIC_VECTOR (2 downto 0)); -- output port
end for_loop;

architecture Behavioral of for_loop is

begin
-- counter process
count:process(X)
  -- variable for counting the number of zeroed bits
  variable zeros_count: natural range 0 to X'length;
  begin
    zeros_count := 0; -- reset counter
	-- for loop for generating counter structre using serial addders
	-- counts from zero to bit length of input port X
    for i in 0 to X'length-1 loop
      if ( X(i) = '0' ) then -- if ith bith of X bus is set zero
        zeros_count := zeros_count + 1; -- increment counter
      end if;
    end loop;
	-- set Y output port to counter number
	-- limit cast operation to the length of Y bus and 
	-- assume contents of zeros_count as unsigned integer
    Y <= std_logic_vector(to_unsigned(zeros_count, Y'length));

 end process count;

end Behavioral;
