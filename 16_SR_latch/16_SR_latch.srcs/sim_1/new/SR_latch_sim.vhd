-- SIMULATION SR TRANSPARENT LATCH 
-- 22.02.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SR_latch_sim is
--  Port ( );
end SR_latch_sim;

architecture Behavioral of SR_latch_sim is

COMPONENT SR_latch
Port (      
    S  : in std_logic;
    R  : in std_logic;
    Q  : out std_logic;
    Qp : out std_logic
    
    );
END COMPONENT;
--Inputs
signal input : std_logic_vector (1 downto 0) := "01";

--Outputs
signal output : std_logic_vector (1 downto 0);

-- Clock period definitions
constant clk_period : time := 100 ns;


begin

-- Instantiate the Unit Under Test (UUT)
uut: SR_latch PORT MAP (
S  => input(1),
R  => input(0),
Q  => output(1),
Qp => output(0)
);

stim_proc: process
begin

    for i in 0 to 3 loop
        input <= std_logic_vector(to_unsigned(i, input'length));
        wait for clk_period;
    end loop;
    
    -- Valid operation for a SR-latch 
    -- without an undefined state
    
	-- S=0, R=1 (Reset state)
    input <= "01";
    wait for clk_period;
    -- S=0, R=0 (Hold state)
    input <= "00";
    wait for clk_period;
    -- S=1, R=0 (Set state)
    input <= "10";
    wait for clk_period;
    -- S=0, R=0 (Hold state)
    input <= "00";
    wait for clk_period;
    
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
