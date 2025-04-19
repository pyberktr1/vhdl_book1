-- DECIMAL TO BCD ENCODER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dec2bcd is
    Port ( 
    X : in  std_logic_vector(8 downto 0);
    Y : out std_logic_vector(3 downto 0)   
    );
end dec2bcd;

architecture Behavioral of dec2bcd is

begin
-- encoder process
encode_proc : process
-- variable that holds output in integer
VARIABLE i, y_out: integer range 0 to 9 := 0;

begin
-- we set a for loop to scan inputs
-- we start with X8 and count downto X0,
-- since highest input pins have priority over
-- lower input pins
   for i in 8 downto 0 loop
     if X(i) = '1' then --  we found an active line
       --  increment counter and assign to y_out
       --  input pin index start from 0,
       --  however corresponding output codes start from 1 	   
       y_out := i + 1;
	   -- break the loop, we found an active pin
	   -- no need to continue the loop
       exit;
     else
       -- default value will be 0
       -- implied zero
       y_out := 0;
     end if;
   end loop;
 -- cast and assign found code to Y output bus
 Y <= std_logic_vector(to_unsigned(y_out, Y'length));
end process;

end Behavioral;
