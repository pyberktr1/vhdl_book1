-- SIMULATION INFINITE ECHO DESIGN
-- File based simulation
-- 27.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity echo_inf_sim is
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

--  Port ( );
end echo_inf_sim;

architecture Behavioral of echo_inf_sim is

--Inputs
signal din   : STD_LOGIC_VECTOR(nbits-1 downto 0)  
           := (others => '0');
signal gain  : STD_LOGIC_VECTOR(ngain-1 downto 0)  
           := "00111";
signal reset : STD_LOGIC := '1';
signal clk   : STD_LOGIC := '0';

--Outputs
signal dout      : STD_LOGIC_VECTOR(nbits-1 downto 0)  
                := (others => '0');
signal dout_comp : STD_LOGIC_VECTOR(nbits-1 downto 0)
                := (others => '0');

-- Clock period definitions
constant clk_period : time := 20.833 us;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: entity work.echo_inf 
generic MAP (
  nbits  => nbits,
  fs     => fs,
  ngain  => ngain,
  ndelay => ndelay
)

PORT MAP (
reset => reset,
clk   => clk,
din   => din,
dout  => dout,
gain  => gain
);

-- Clock process definitions
clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

-- Stimulus process
stim_proc: process
-- i stimulus variable
variable i          : integer := 0;
-- file definitions
-- character file type definition
type charf is file of character;
-- input waveform file handle 
file a1      : charf;
-- output echo file handle 
file ef      : charf;
-- single character variable for storing 
-- character read from file
variable indata_c : character;
-- byte type definition
subtype t_byte is natural range 0 to 255;
-- byte data variable for audio input
variable indata_b : t_byte;

begin
  -- open file "wform.bin" for reading
  -- a1 is used as a file handle
  file_open(a1, "D:\fpga\kitap1b\40_echo_inf\wform.bin");
  -- open file "echo.bin" for reading
  -- ef is used as a file handle
  file_open(ef, "D:\fpga\kitap1b\40_echo_inf\echo.bin");
  
  wait for clk_period*2;
  -- remove reset, 
  reset <= '0';
  i := 0;
  -- read the a1 file char by char 
  -- until the last character
  while not endfile(a1) loop
    for j in 0 to nbits/8-1 loop
      -- read a character from file
      if not endfile(a1) then
	    read(a1, indata_c);
	  else
	    indata_c := 'a';-- error code!
	  end if;
      -- convert it to a byte
      indata_b := character'pos(indata_c);
	  din(j*8+7 downto j*8) <= 
	    std_logic_vector(to_unsigned(indata_b,8));
	end loop;

	-- read the ef file for comparison
    for j in 0 to nbits/8-1 loop
      -- read a character from file
      if not endfile(ef) then
	    read(ef, indata_c);
	  else
	    indata_c := 'a';-- error code!
	  end if;
      -- convert it to a byte
      indata_b := character'pos(indata_c);
	  dout_comp(j*8+7 downto j*8) <= 
	    std_logic_vector(to_unsigned(indata_b,8));
	end loop;

    -- wait for next cycle   
    wait for clk_period;
	
    -- make comparison
    assert (dout = dout_comp) 
      report " error on i = " & integer'image(i) &
             " actual: " & 
			 integer'image(to_integer(signed(dout))) & 
             " desired: " & 
			 integer'image(to_integer(signed(dout_comp))) 
			 severity ERROR;
    -- increment counter
	i := i + 1;
  end loop;
  -- close the files
  file_close(a1);
  file_close(ef);

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process;
end Behavioral;
