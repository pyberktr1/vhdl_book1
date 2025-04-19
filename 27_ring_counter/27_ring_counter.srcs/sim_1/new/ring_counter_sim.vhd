-- SIMULATION RING COUNTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ring_counter_sim is
--  Port ( );
end ring_counter_sim;

architecture Behavioral of ring_counter_sim is
component ring_counter is
    Port ( 
    clk : in STD_LOGIC;
    Q   : out std_logic_vector(3 downto 0)
    );
end component;

--Inputs
signal clk      : std_logic := '0';

--Outputs
signal Q        : std_logic_vector(3 downto 0);

-- Clock period definitions
constant clk_period : time := 10 ns;

begin
-- Instantiate the Unit Under Test (UUT)
uut: ring_counter PORT MAP (
clk => clk,
Q   => Q

);

-- Clock process definitions
clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;
-- stimulate device
stim_proc: process
begin
    -- monitor output for a couple of clock cycles
    wait for clk_period*16;
  
    assert false report "test finished!" severity FAILURE;

end process;


end Behavioral;
