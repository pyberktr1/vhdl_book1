-- BOOLEAN EXPRESSIONS
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bool_expr is
    Port ( X : in  STD_LOGIC_VECTOR (2 downto 0);
           Y : out STD_LOGIC_VECTOR (1 downto 0));
end bool_expr;

architecture Behavioral of bool_expr is

begin

  -- Boolean expressions
  Y(0) <= (X(2) AND X(1) AND NOT X(0)) OR (X(2) AND NOT X(1) AND NOT X(0));
  Y(1) <= NOT (((NOT X(2) AND X(0)) OR NOT X(1) OR X(0)) OR (NOT (NOT X(2) OR X(1)) AND X(0)));

end Behavioral;
