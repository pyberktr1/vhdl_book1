-- SIMULATION 2-BIT COMPARATOR
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comp_2bit_sim is
--  Port ( );
end comp_2bit_sim;

architecture Behavioral of comp_2bit_sim is

COMPONENT comp_2bit
Port (      
    A  : in STD_LOGIC_VECTOR (1 downto 0);
    B  : in STD_LOGIC_VECTOR (1 downto 0);
    eqi  : in std_logic;
    asbi : in std_logic;
    abbi : in std_logic;
    eqo  : out std_logic;
    asbo : out std_logic;
    abbo : out std_logic
            );
END COMPONENT;

--Inputs
signal input  : std_logic_vector (3 downto 0) := "0000";
signal inputA : std_logic_vector (1 downto 0) := "00";
signal inputB : std_logic_vector (1 downto 0) := "00";
-- simulate an error here
signal eqi  : std_logic := '1';
signal asbi : std_logic := '0';
signal abbi : std_logic := '0';

--Outputs
signal eqo  : std_logic;
signal asbo : std_logic;
signal abbo : std_logic;

-- Clock period definitions
constant clk_period : time := 100 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: comp_2bit PORT MAP (
A    => inputA,
B    => inputB,
eqi  => eqi,
abbi => abbi,
asbi => asbi,
eqo  => eqo,
abbo => abbo,
asbo => asbo
);
-- set inputs A,B by resolving the input signal
inputA <= input(1 downto 0);
inputB <= input(3 downto 2);

-- Stimulus process
stim_proc: process
-- there are 16 possible combinations for all inputs
variable i : integer range 0 to 16 := 0;
begin

     while (i <= 15) loop
       input <= std_logic_vector(to_unsigned(i, input'length));
       
	   -- increment counter
       i := i + 1;
       wait for clk_period;

     end loop;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
