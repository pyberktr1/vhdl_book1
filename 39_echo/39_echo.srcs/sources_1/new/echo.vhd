-- ECHO MIKE DESIGN
-- 20.03.2025 (DD.MM.YYYY) by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Signed arithmetic library
use IEEE.STD_LOGIC_SIGNED.ALL;

entity echo is
    -- define code adapting constants in the Generic body
    Generic (
    -- define number of input port bits here
    nbits : integer := 16;
    -- sample frequency (hz)
    fs    : integer := 48000;
	-- gain input bit depth
	ngain : integer := 5;
	-- delay line elements (td = ndelay/fs seconds)
	ndelay : integer := 4800
	
    );
    Port ( 
	  reset : in  STD_LOGIC; -- master reset
	  clk   : in  STD_LOGIC; -- clock
	  -- input
	  din   : in  STD_LOGIC_VECTOR(nbits-1 downto 0); 
	  -- gain
	  gain  : in  STD_LOGIC_VECTOR(ngain-1 downto 0); 
	  -- output
	  dout  : out STD_LOGIC_VECTOR(nbits-1 downto 0)  
           );
end echo;

architecture Behavioral of echo is

signal delay_out : STD_LOGIC_VECTOR(nbits-1 downto 0)       := (others => '0');
signal gain_out  : STD_LOGIC_VECTOR(nbits+ngain-1 downto 0) := (others => '0');
signal adder_in  : STD_LOGIC_VECTOR(nbits-1 downto 0)       := (others => '0');
signal adder_out : STD_LOGIC_VECTOR(nbits downto 0)         := (others => '0');

begin
-- interconnections 
-- adder's gain stage input 
-- truncate 21-bits result to 16-bits
adder_in <= gain_out(nbits+ngain-1 downto ngain);
-- truncate 17-bit result to 16-bit
dout <= adder_out(nbits downto 1);
-- delay module
delayline_inst: entity work.delayline
generic map
  (
  nbits  => nbits,
  fs     => fs,
  -- we assume an additional delay on gain module
  -- since it uses a registered output
  ndelay => ndelay-1
  )
port map
  (
  reset => reset,
  clk   => clk,
  din   => din,
  dout  => delay_out
  );
-- gain module 
gain_inst: entity work.gain
generic map
  (
  nbits  => nbits,
  ngain  => ngain
  )
port map
  (
  reset => reset,
  clk   => clk,
  din   => delay_out,
  gain  => gain,
  dout  => gain_out
  );
-- adder module 
adder_inst: entity work.adder
generic map
  (
  nbits  => nbits
  )
port map
  (
  reset => reset,
  clk   => clk,
  din1   => din,
  din2   => adder_in,
  dout   => adder_out
  );

end Behavioral;
