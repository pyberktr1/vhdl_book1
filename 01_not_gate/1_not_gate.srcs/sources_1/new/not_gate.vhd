
-- NOT GATE
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity not_gate is
    Port ( btn : in STD_LOGIC;
           led : out STD_LOGIC
           );
end not_gate;

architecture Behavioral of not_gate is

begin

    led <= not btn;
    
end Behavioral;

