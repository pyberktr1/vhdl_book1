-- IF STATEMENTS
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity if_statements is
    Port ( x1 : in bit; -- input 1
           x2 : in bit; -- input 2
           y  : out natural range 0 to 7); -- output
end if_statements;

architecture Behavioral of if_statements is
begin
 -- any if statement can only be in a process
 -- a process must have at least one input 
 -- in its sensitivity list 
 -- every process must have a name 
 compare:process(x1, x2)
 variable i: natural range 0 to 7;
 begin
  i := 3; -- set i to value of 3
  if ( x1 = x2 ) then -- equality check
   i := i + 1; -- if true, increment i 
  else
   i := 5; -- if false, set i to 5
  end if;
  y <= i; -- make i output to y
 end process compare;
end Behavioral;
