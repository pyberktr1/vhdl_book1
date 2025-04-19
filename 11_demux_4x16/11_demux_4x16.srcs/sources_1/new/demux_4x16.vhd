-- 4-LINE TO 16-LINE DEMULTIPLEXER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity demux_4x16 is
    Port ( 
    X  : in std_logic_vector (3 downto 0);
    EN : in std_logic;
    Y  : out std_logic_vector (15 downto 0)
    
    );
end demux_4x16;

architecture Behavioral of demux_4x16 is

begin
  -- generate expression that builds the demux structure
  -- through the use of for loop
  gen_demux: for i in 0 to 15 generate
    Y(i) <= EN when to_integer(unsigned(X)) = i else '0';
  end generate gen_demux;

end Behavioral;
