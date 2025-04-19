-- COMPARATOR ERROR CHECKER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity err_comp is
    Port ( 
    eqi  : in std_logic;
    asbi : in std_logic;
    abbi : in std_logic;
    erro : out std_logic
    
    );
end err_comp;

architecture Behavioral of err_comp is

begin
-- when at least two magnitude inputs are active at the same time 
-- we assume it as an error condition
-- no numbers can be equal and bigger or smaller at the same time
-- another error condition is the condition of all inputs are inactive 
-- this last condition is repeated at the output to signal 
-- an error condition
 erro <= (eqi and asbi) or (asbi and abbi) or (abbi and eqi) or 
         (not eqi and not abbi and not asbi);-- error condition

end Behavioral;
