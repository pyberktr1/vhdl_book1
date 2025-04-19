-- SIMULATION NERONAURALLOGIX CELL DESIGN
-- 13.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity neronaurallogix_sim is
--  Port ( );
end neronaurallogix_sim;

architecture Behavioral of neronaurallogix_sim is
COMPONENT neronaurallogix
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
END COMPONENT;
--Inputs
signal input : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal mode  : STD_LOGIC_VECTOR(1 downto 0)  := (others => '0');
signal ldata : STD_LOGIC_VECTOR(3 downto 0)  := (others => '0');
signal m1    : STD_LOGIC_VECTOR(3 downto 0)  := (others => '0');
signal m2    : STD_LOGIC_VECTOR(3 downto 0)  := (others => '0');
signal a1    : STD_LOGIC_VECTOR(3 downto 0)  := (others => '0');
signal mac   : STD_LOGIC_VECTOR(3 downto 0)  := (others => '0');
signal mult  : STD_LOGIC_VECTOR(7 downto 0)  := (others => '0');
signal add   : STD_LOGIC_VECTOR(4 downto 0)  := (others => '0');
signal reset : STD_LOGIC := '1';
signal clk   : STD_LOGIC := '0';

--Outputs
signal output : STD_LOGIC_VECTOR(3 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: neronaurallogix PORT MAP (
reset => reset,
clk   => clk,
lrn   => mode(1),
le    => mode(0),
m1    => m1,
m2    => m2,
a1    => a1,
ldata => ldata,
o     => output
);
m1  <= input(11 downto 8);
m2  <= input(7 downto 4);
a1  <= input(3 downto 0);

-- calculate desired value
-- mac = (((m1 * m2) mod 16) + a1) mod 16
mult <= m1 * m2;
add  <= mult(3 downto 0) + ('0' & a1);
mac  <= add(3 downto 0);

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
variable i : integer := 0;

begin
  wait for clk_period*2;
  -- generate stimulus and check all input codes for m1,m2,a1
  -- there are 4096 codes (0-4095) for 12-bit input
  -- remove reset, mode = run
  reset <= '0';
  mode <= "00";
  
  while (i <= 4095) loop
    -- send stimulus to input
    input <= std_logic_vector(to_unsigned(i, input'length));
    -- wait for next cycle   
    wait for clk_period;
    -- test for the code      
    assert (output = mac) 
      report "actual: " & integer'image(to_integer(unsigned(output))) & 
             " desired: " & integer'image(to_integer(unsigned(mac))) severity ERROR;
    -- increment counter
	i := i + 1;
  end loop;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process;
end Behavioral;
