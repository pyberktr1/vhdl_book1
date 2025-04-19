-- NERONAURALLOGIX CELL DESIGN
-- 13.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity neronaurallogix is
    Port ( 
	  reset : in  STD_LOGIC; -- master reset
	  clk   : in  STD_LOGIC; -- clock
	  lrn   : in  STD_LOGIC; -- load/run mode select
	  le    : in  STD_LOGIC; -- load enable
	  m1    : in  STD_LOGIC_VECTOR(3 downto 0); -- multiplier input1
	  m2    : in  STD_LOGIC_VECTOR(3 downto 0); -- multiplier input2
	  a1    : in  STD_LOGIC_VECTOR(3 downto 0); -- adder input
	  ldata : in  STD_LOGIC_VECTOR(3 downto 0); -- load data
	  o     : out STD_LOGIC_VECTOR(3 downto 0)  -- neronaurallogix output
           );
end neronaurallogix;

architecture Behavioral of neronaurallogix is

signal q    : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal mode : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal mac  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal mult : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal add  : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');

begin
-- q signal connected to output
o <= q;
-- mode signal derived from lrn&le
mode <= lrn & le;

-- mac = (((m1 * m2) mod 16) + a1) mod 16
mult <= m1 * m2;
add  <= ('0' & a1) + mult(3 downto 0);
mac  <= add(3 downto 0);

-- neronaurallogix cell process
neronaurallogix_proc: process(clk)
begin
  if rising_edge(clk) then
    if (reset = '1') then -- reset device
      q <= (others => '0');
    else
      case mode is
        when "00" => -- run mode
		  q <= mac;
        when "01" => -- run mode
		  q <= mac;
        when "10" => -- hold mode
		  q <= q;
        when "11" => -- load data mode
		  q <= ldata;
		when others => 
		  q <= q;  -- hold mode
	  end case;
	end if;
  end if;
end process;

end Behavioral;
