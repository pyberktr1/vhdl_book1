-- INFINITE ECHO DESIGN
-- 27.03.2025 (DD.MM.YYYY) by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Signed arithmetic library
use IEEE.STD_LOGIC_SIGNED.ALL;

entity echo_inf is
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
end echo_inf;

architecture Behavioral of echo_inf is
-- delayline input, echo output (dout)
signal echo_out  : STD_LOGIC_VECTOR(nbits-1 downto 0)       := (others => '0');
-- delayline output
signal delay_out : STD_LOGIC_VECTOR(nbits-1 downto 0)       := (others => '0');
-- gain block output
signal gain_out  : STD_LOGIC_VECTOR(nbits+ngain-1 downto 0) := (others => '0');
-- adder output
signal adder_out : STD_LOGIC_VECTOR(nbits downto 0)         := (others => '0');
-- adder input from gain block
signal adder_in2 : STD_LOGIC_VECTOR(nbits-1 downto 0)       := (others => '0');

begin
-- Module interconnections
-- leftshift and truncating extra sign bit of gain block 
-- before applying to adder input adder_in2
-- we will truncate 2 MSBs and 3 LSBs preserving the sign bit (MSB)
-- take sign bit (MSB) put it at 4th MSB and truncate 3 LSBs
adder_in2 <= gain_out(nbits+ngain-1) & gain_out(nbits+ngain-4 downto 3);
-- truncate 17-bit result to 16-bit by truncating 1 LSB 
echo_out <= adder_out(nbits downto 1);
dout     <= echo_out;


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
  din   => echo_out,
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
  reset  => reset,
  clk    => clk,
  din1   => din,
  din2   => adder_in2,
  dout   => adder_out
  );

end Behavioral;
