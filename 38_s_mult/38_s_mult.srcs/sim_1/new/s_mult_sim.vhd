-- SIMULATION SIGNED MULTIPLICATION DESIGN
-- 19.03.2025 (DD.MM.YYYY) by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Signed arithmetic library
use IEEE.STD_LOGIC_SIGNED.ALL;

entity s_mult_sim is
--  Port ( );
end s_mult_sim;

architecture Behavioral of s_mult_sim is
COMPONENT s_mult
Port (      
	  reset : in  STD_LOGIC; -- master reset
	  clk   : in  STD_LOGIC; -- clock
	  -- multiplier input1 (8-bit signed)
	  m1    : in  STD_LOGIC_VECTOR(7 downto 0); 
	  -- multiplier input2 (5-bit signed)
	  m2    : in  STD_LOGIC_VECTOR(4 downto 0); 
	  -- multiplier output (8-bit signed)
	  o     : out STD_LOGIC_VECTOR(7 downto 0)  
           );
END COMPONENT;
--Inputs
signal m1    : STD_LOGIC_VECTOR(7 downto 0)  := x"80";
signal m2    : STD_LOGIC_VECTOR(4 downto 0)  := '1' & x"0";
signal reset : STD_LOGIC := '1';
signal clk   : STD_LOGIC := '0';

--Outputs
signal output : STD_LOGIC_VECTOR(7 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: s_mult PORT MAP (
reset => reset,
clk   => clk,
m1    => m1,
m2    => m2,
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
-- stimulus variables
variable i,j,i1,j1,result : integer := 0;

begin
  wait for clk_period*2;
  -- generate stimulus and check all input codes for m1 and m2
  -- there are 8192 combinations for 13-bit input
  -- remove reset
  reset <= '0';
  wait for clk_period;
  -- delayed calculation variables
  i1:=-128; j1:=-16;
  for i in -128 to 127 loop
    for j in -16 to 15 loop
    -- send stimulus to inputs
    -- use signed conversion
    m1 <= std_logic_vector(to_signed(i, m1'length));
    m2 <= std_logic_vector(to_signed(j, m2'length));
    -- make calculation according to delayed values
    result := (((i1*j1)-((i1*j1) mod (2**5)))/(2**5));

    wait for clk_period;
    -- test for the code      
    assert (result = to_integer(signed(output))) 
      report "actual: " & 
	         integer'image(to_integer(signed(output))) & 
             " desired: " & integer'image(result) & 
			 " at i: " & integer'image(i) &
			 " j: " & integer'image(j) severity ERROR;
	-- update delayed variables
	i1:=i;
	j1:=j;
	end loop;
  end loop;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process;
end Behavioral;
