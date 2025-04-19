-- SIMULATION D-TYPE LATCH
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity D_latch_sim is
--  Port ( );
end D_latch_sim;

architecture Behavioral of D_latch_sim is

COMPONENT D_latch
Port (      
    D  : in std_logic;
    EN : in std_logic;
    Q  : inout std_logic;
    Qp : inout std_logic
    
    );
END COMPONENT;
--Inputs
signal input : std_logic_vector (1 downto 0) := "11";

--Outputs
signal output : std_logic_vector (1 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;

begin

-- Instantiate the Unit Under Test (UUT)
uut: D_latch PORT MAP (
D  => input(1),
EN => input(0),
Q  => output(1),
Qp => output(0)
);

stim_proc: process
begin

    for i in 1 to 7 loop
        input <= std_logic_vector(to_unsigned(i, input'length));
        wait for clk_period;
    end loop;
    
	-- Data state
    input <= "01";
    wait for clk_period;
    
	-- Hold state
    input <= "00";
    wait for clk_period;
    
	-- Data state
    input <= "11";
    wait for clk_period;
    
	-- Hold state
    input <= "00";
    wait for clk_period;
    
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
