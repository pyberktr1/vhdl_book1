-- SR TRANSPARENT LATCH
-- 22.02.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SR_latch is
    Port ( 
    S  : in  STD_LOGIC; -- Set input
    R  : in  STD_LOGIC; -- Reset input
    Q  : out STD_LOGIC; -- Q output
    Qp : out STD_LOGIC  -- Q' output (not inverse of Q)
    );
end SR_latch;

architecture Behavioral of SR_latch is
-- Bidirectional signals necessary to read from outputs
signal qout  : std_logic := '0';
signal qoutp : std_logic := '1';

begin
-- NOR type SR Latch logic gate expressions
-- Q' is not always inverse of Q
qout  <= qoutp nor R;
qoutp <= qout  nor S;

-- Send calculations to output
Q  <= qout;
Qp <= qoutp;

end Behavioral;
