-- BCD TO DECIMAL DECODER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcd2dec is
    Port ( 
    X : in  std_logic_vector(3 downto 0);
    Y : out std_logic_vector(9 downto 0)
    
    );
end bcd2dec;

architecture Behavioral of bcd2dec is

begin
  -- We use a generate statement to produce a decoder structure
  gen_demux: for i in 0 to 9 generate
    Y(i) <= '0' when to_integer(unsigned(X)) = i else '1';
  end generate gen_demux;

end Behavioral;
