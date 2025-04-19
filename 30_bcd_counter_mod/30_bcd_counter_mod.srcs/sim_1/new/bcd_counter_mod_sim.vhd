-- SIMULATION MODIFIED 4-BIT BCD COUNTER
-- 04.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_counter_sim is
--  Port ( );
end bcd_counter_sim;

architecture Behavioral of bcd_counter_sim is
component bcd_counter_mod is
    Port ( 
    q      : out std_logic_vector(3 downto 0);
    clk    : in  STD_LOGIC;
    co     : out STD_LOGIC;
    ci     : in  STD_LOGIC;
    resetn : in  STD_LOGIC
           );
end component;

--Inputs
signal resetn   : std_logic := '0';
signal clk      : std_logic := '0';
signal co       : std_logic := '0';
signal ci       : std_logic := '1';

--Outputs
signal q : std_logic_vector (3 downto 0);

-- Clock period definitions
constant clk_period : time := 10 ns;

begin
-- Instantiate the Unit Under Test (UUT)
uut: bcd_counter_mod PORT MAP (
q      => q,
clk    => clk,
co     => co,
ci     => ci,
resetn => resetn
);

-- Clock process definitions
clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;
-- stimulation process
stim_proc: process
begin
    -- reset device
    resetn <= '0';
    wait for clk_period*2;
	-- count for a couple of clock cycles
    resetn <= '1';
    wait for clk_period*22;
	-- reset device
    resetn <= '0';
    wait for clk_period*3;
	-- count up
    resetn <= '1';
    wait for clk_period*4;
    
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
