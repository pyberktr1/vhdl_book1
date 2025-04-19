-- SIMULATION 4-BIT BINARY COUNTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity binary_counter_sim is
--  Port ( );
end binary_counter_sim;

architecture Behavioral of binary_counter_sim is
component binary_counter is
    Port ( 
    q      : out std_logic_vector(3 downto 0);
    clk    : in STD_LOGIC;
    resetn : in STD_LOGIC
           );
end component;

--Inputs
signal resetn   : std_logic := '0';
signal clk      : std_logic := '0';
signal cnt      : std_logic_vector (3 downto 0) := (others => '0');

--Outputs
signal q : std_logic_vector (3 downto 0);

-- Clock period definitions
constant clk_period : time := 10 ns;

begin
-- Instantiate the Unit Under Test (UUT)
uut: binary_counter PORT MAP (
q      => q,
clk    => clk,
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
	-- start counting
    resetn <= '1';
    wait for clk_period*22;
	-- reset device
    resetn <= '0';
    wait for clk_period*3;
	-- start counting
    resetn <= '1';
    wait for clk_period*4;
    
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
