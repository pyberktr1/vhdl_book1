-- 5-BIT PARITY CHECKER/GENERATOR
-- 21.02.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity parity is
    Port ( 
    D  : in  std_logic_vector(3 downto 0);
	-- parity in is used as cascading input for 
	-- generator mode while it is parity bit input for
	-- parity checker mode.
    P  : in  std_logic; -- parity in
    PE : out std_logic; -- even parity output 
    PO : out std_logic  -- odd parity output
    );
end parity;

architecture Behavioral of parity is
-- bi-directional connector signal
signal parity : std_logic := '0';
begin
  -- calculate even parity using cascaded half-adders
  -- which are xor gates. odd parity is the inverse.
  parity <= (D(3) xor D(2) xor D(1) xor D(0) xor P);
  PE <= parity; 
  PO <= not parity;

end Behavioral;
