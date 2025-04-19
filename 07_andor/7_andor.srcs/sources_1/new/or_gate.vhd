-- OR GATE
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_gate is
    Port ( X1 : in std_logic;
           X2 : in std_logic;
           Y  : out std_logic);
end or_gate;

architecture Behavioral of or_gate is

begin
    Y <= X1 or X2;

end Behavioral;
