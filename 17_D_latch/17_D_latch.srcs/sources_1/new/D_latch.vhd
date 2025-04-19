-- D-TYPE LATCH
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_latch is
    Port ( 
    D  : in STD_LOGIC;
    EN : in STD_LOGIC;
    Q  : inout STD_LOGIC;
    Qp : inout STD_LOGIC
    );
end D_latch;

architecture Behavioral of D_latch is

begin
-- output logic expressions with feedback
Q  <= Qp nand (EN nand D);
Qp <= Q  nand (EN nand not D);
end Behavioral;
