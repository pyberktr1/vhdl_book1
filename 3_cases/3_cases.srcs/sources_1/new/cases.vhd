-- CASE STRUCTURES
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cases is
    Port ( sel : in  STD_LOGIC_VECTOR (2 downto 0);
           y   : out STD_LOGIC_VECTOR (6 downto 0));
end cases;

architecture Behavioral of cases is

begin
 datasel:process(sel)
  begin
   case sel is
    when "001"  => y <= "0000001";
    when "010"  => y <= "0000010";
    when "011"  => y <= "0000100";
    when "100"  => y <= "0001000";
    when "101"  => y <= "0010000";
    when "110"  => y <= "0100000";
    when "111"  => y <= "1000000";
    when others => y <= "0000000";
   end case;
 
 end process datasel;

end Behavioral;
