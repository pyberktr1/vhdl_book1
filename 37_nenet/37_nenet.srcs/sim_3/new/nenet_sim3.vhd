-- SIMULATION NERONAURALLOGIX NETWORK (NENET) DESIGN
-- Dumping simulation data to files
-- 17.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nenet_sim is
--  Port ( );
end nenet_sim;

architecture Behavioral of nenet_sim is
COMPONENT nenet
    Port ( 
	  reset : in  STD_LOGIC; -- master reset
	  clk   : in  STD_LOGIC; -- clock
	  lrn   : in  STD_LOGIC; -- load/run mode select
	  len   : in  STD_LOGIC; -- load enable
	  ldata : in  STD_LOGIC_VECTOR(3 downto 0); -- load data
	  laddr : in  STD_LOGIC_VECTOR(3 downto 0); -- load data cell address
	  nno   : out STD_LOGIC_VECTOR(3 downto 0)  -- nenet output
           );
END COMPONENT;
--Inputs
type vector_array is array (integer range 0 to 11) of 
     STD_LOGIC_VECTOR(3 downto 0);
constant ndata : vector_array := ( x"3", x"5", x"e", x"9",
                                   x"1", x"a", x"f", x"b",
								   x"2", x"c", x"7", x"d" );
signal ldata : STD_LOGIC_VECTOR(3 downto 0)  := (others => '0');
signal laddr : STD_LOGIC_VECTOR(3 downto 0)  := (others => '0');
signal mode  : STD_LOGIC_VECTOR(1 downto 0)  := "10";
signal reset : STD_LOGIC := '1';
signal clk   : STD_LOGIC := '0';

--Outputs
signal output : STD_LOGIC_VECTOR(3 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: nenet PORT MAP (
reset => reset,
clk   => clk,
lrn   => mode(1),
len   => mode(0),
ldata => ldata,
laddr => laddr,
nno   => output
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
-- bindata file handle 
file bindata      : charf;
-- single character variable for storing 
-- the character write to file
variable indata_c : character;

begin
-- open file "nenet_data.bin" for writing
-- bindata is used as a file handle
file_open(bindata, "D:\fpga\kitap1b\37_nenet\nenet_wav.bin", write_mode);
  wait for clk_period*2;
  -- load nenet and then run to see the output
  -- remove reset, mode = load
  reset <= '0';
  mode  <= "11";
  
  while (i <= 11) loop
    -- load nenet cell
    laddr <= std_logic_vector(to_unsigned(i, laddr'length));
    ldata <= ndata(i);
    -- wait for next cycle   
    wait for clk_period;
    -- increment counter
	i := i + 1;
  end loop;
  -- run the NENET
  i := 0;
  mode <= "00";
  -- dump data to the bindata file char by char 
  while (i<480000) loop
    -- convert output to a character
    indata_c := character'val(to_integer(unsigned(output)));
    -- write a character to file
    write(bindata, indata_c);
    -- wait for next cycle   
    wait for clk_period;
    -- increment counter
	i := i + 1;
  end loop;
  -- close the file
  file_close(bindata);
  -- hold the nenet 
  mode <= "10";
  wait for clk_period*3;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process;
end Behavioral;
