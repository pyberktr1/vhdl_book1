-- SIMULATION D-TYPE FLIP-FLOP
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity D_FF_sim is
--  Port ( );
end D_FF_sim;

architecture Behavioral of D_FF_sim is

COMPONENT D_FF
Port (      
    D   : in std_logic;
    clk : in std_logic;
    pre : in std_logic;
    clr : in std_logic;
    Q   : out std_logic
    
    );
END COMPONENT;
--Inputs
signal D   : std_logic := '0';
signal clk : std_logic := '0';
signal pre : std_logic := '0';
signal clr : std_logic := '0';
signal input : std_logic_vector (2 downto 0) := "000";

--Outputs
signal Q   : std_logic;

-- Clock period definitions
constant clk_period : time := 50 ns;


begin

-- Instantiate the Unit Under Test (UUT)
uut: D_FF PORT MAP (
D => D,
clk => clk,
pre => pre,
clr => clr,
Q => Q
);

D   <= input(0);
clr <= input(1);
pre <= input(2);

-- Clock process definitions
clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

stim_proc: process
begin
    -- wait until system stabilizes
    wait for clk_period*10;
	-- stimulate Inputs
    for i in 0 to 15 loop
        input <= std_logic_vector(to_unsigned(i, input'length));
        wait for clk_period;
    end loop;
    
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
