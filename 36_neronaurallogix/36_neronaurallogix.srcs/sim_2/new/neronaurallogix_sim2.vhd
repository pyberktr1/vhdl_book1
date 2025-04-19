-- SIMULATION NERONAURALLOGIX CELL DESIGN
-- 13.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity neronaurallogix_sim2 is
--  Port ( );
end neronaurallogix_sim2;

architecture Behavioral of neronaurallogix_sim2 is
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

begin
  wait for clk_period*2;
  -- remove reset, mode = run
  -- (out = x"7")
  reset <= '0';
  mode  <= "00";
  m1    <= x"5";
  m2    <= x"4";
  a1    <= x"3";
  wait for clk_period;
  -- mode = run2 (out = x"a")
  mode <= "01";
  m1   <= x"3";
  m2   <= x"7";
  a1   <= x"5";
  wait for clk_period;
  -- mode = hold
  -- out = out
  mode <= "10";
  m1   <= x"1";
  m2   <= x"7";
  a1   <= x"7";
  wait for clk_period*2;
  -- mode = load
  -- out = ldata = x"8"
  mode  <= "11";
  m1    <= x"1";
  m2    <= x"7";
  a1    <= x"7";
  ldata <= x"8";
  wait for clk_period;
  -- mode = run
  -- reset device
  -- out = x"0"
  reset <= '1';
  mode  <= "00";
  m1    <= x"1";
  m2    <= x"7";
  a1    <= x"7";
  wait for clk_period*2;
  -- mode = run
  -- remove reset
  -- out = x"e"
  reset <= '0';
  mode  <= "00";
  m1    <= x"1";
  m2    <= x"7";
  a1    <= x"7";
  wait for clk_period*2;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process;
end Behavioral;
