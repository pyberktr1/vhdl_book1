-- SIMULATION SERIAL IN PARALLEL OUT SHIFT REGISTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity serin_parout_sim is
--  Port ( );
end serin_parout_sim;

architecture Behavioral of serin_parout_sim is
COMPONENT serin_parout
Port (      
    din   : in std_logic;
    reset : in std_logic;
    clk   : in std_logic;
    dout  : out std_logic_vector(7 downto 0)
    
    );
END COMPONENT;
--Inputs
signal din   : std_logic := '0';
signal clk   : std_logic := '0';
signal reset : std_logic := '0';
signal input : std_logic_vector (7 downto 0) := (others => '0');

--Outputs
signal dout  : std_logic_vector (7 downto 0);

-- Clock period definitions
constant clk_period : time := 10 ns;

begin

-- Instantiate the Unit Under Test (UUT)
uut: serin_parout PORT MAP (
din   => din,
clk   => clk,
reset => reset,
dout  => dout

);

-- Clock process definitions
clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

-- set serial in as LSB of input
din <= input(0);
stim_proc: process
begin
    -- wait for stabilization
    wait for clk_period*2;
    -- stimulate input
    for i in 0 to 15 loop
        input <= std_logic_vector(to_unsigned(i, input'length));
        wait for clk_period;
    end loop;
	
    wait for clk_period*2;
	-- reset all outputs
    reset <= '1';
    wait for clk_period*2;
	-- end reset
    reset <= '0';
    -- stimulate input
    for i in 1 to 14 loop
        input <= std_logic_vector(to_unsigned(i, input'length));
        wait for clk_period;
    end loop;
    
    wait for clk_period*2;
	-- reset all outputs
    reset <= '1';
    wait for clk_period*2;
    -- end simulation
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
