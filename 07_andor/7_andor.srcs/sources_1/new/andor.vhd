-- AND-OR GATE
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity andor is
    Port ( X  : in std_logic_vector (1 downto 0);
           Y  : out std_logic);
end andor;

architecture Behavioral of andor is
component and_gate is
port (X1, X2: in std_logic; Y: out std_logic);
end component and_gate;

component or_gate is
port (X1, X2: in std_logic; Y: out std_logic);
end component or_gate;

-- interconnection signals
signal Y1, Y2: std_logic;

begin
  -- modular XOR implementation
  -- XOR = X1.X2' + X1'.X2  
  -- first layer (and gates)
  gate1: and_gate port map (X1 => X(0), X2 => not X(1), Y=> Y1);
  gate2: and_gate port map (X1 => not X(0), X2 => X(1), Y=> Y2);
  -- second layer (or gate)
  gate3: or_gate  port map (X1 => Y1, X2 => Y2, Y => Y);

end architecture Behavioral;
