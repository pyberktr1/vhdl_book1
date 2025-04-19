-- SIMULATION 5-BIT PARITY CHECKER/GENERATOR
-- 21.02.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity parity_sim is
--  Port ( );
end parity_sim;

architecture Behavioral of parity_sim is

COMPONENT parity
Port (      
    D  : in  std_logic_vector(3 downto 0);
	-- parity in is used as cascading input for 
	-- generator mode while it is parity bit input for
	-- parity checker mode.
    P  : in  std_logic; -- parity in
    PE : out std_logic; -- even parity output 
    PO : out std_logic  -- odd parity output
            );
END COMPONENT;
--Inputs
signal inD : std_logic_vector (7 downto 0) := x"00";
signal inP : std_logic := '0'; -- LSB cascade input

--Outputs
-- LSB parity generator outputs
signal OP0   : std_logic;
signal EP0   : std_logic;

-- MSB parity generator outputs
signal OP1   : std_logic;
signal EP1   : std_logic;

-- LSB parity checker outputs
signal OPC0   : std_logic;
signal EPC0   : std_logic;

-- MSB parity checker outputs
signal OPC1   : std_logic;
signal EPC1   : std_logic;

-- Clock period definitions
constant clk_period : time := 100 ns;

begin

-- Instantiate the Unit Under Test (UUT)
-- Parity generator (LSB)
inst_pg0: parity PORT MAP (
D  => inD(3 downto 0),
P  => inP,
PE => EP0,
PO => OP0

);

-- Parity generator (MSB)
inst_pg1: parity PORT MAP (
D  => inD(7 downto 4),
P  => EP0,
PE => EP1,
PO => OP1

);

-- Parity checker (LSB)
inst_pc0: parity PORT MAP (
D  => inD(3 downto 0),
P  => EP1, -- set to even parity checking
PE => EPC0,
PO => OPC0

);

-- Parity checker (MSB)
inst_pc1: parity PORT MAP (
D  => inD(7 downto 4),
P  => EPC0,
PE => EPC1,
PO => OPC1

);

-- Stimulus process
stim_proc: process
-- there are 2^8 = 256 combinations for a 8-bit bus
variable i : integer range 0 to 2**8 := 0;

begin
    for i in 0 to 255 loop
        inD <= std_logic_vector(to_unsigned(i, inD'length));
       
        wait for clk_period;
	    -- evaluate responses
        -- test for the code      
        assert (EPC1 = '0') 
         report "there is error on input code : " & 
		   integer'image(i) severity ERROR;
        
     end loop;

-- simulation stops completely
assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
