-- 8-TO-1 MULTIPLEXER 
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_8x1 is
    Port ( 
    S  : in  std_logic_vector(2 downto 0);
    D  : in  std_logic_vector(7 downto 0);
    EN : in  std_logic;
    Y  : out std_logic
    );
end mux_8x1;

architecture Behavioral of mux_8x1 is

begin

  Y <= D(to_integer(unsigned(S))) and EN;

end Behavioral;
