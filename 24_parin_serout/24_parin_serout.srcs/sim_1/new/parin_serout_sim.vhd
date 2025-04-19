-- SIMULATION PARALLEL IN SERIAL OUT SHIFT REGISTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity parin_serout_sim is
--  Port ( );
end parin_serout_sim;

architecture Behavioral of parin_serout_sim is

COMPONENT parin_serout
Port (      
    serin  : in STD_LOGIC;
    resetn : in STD_LOGIC;
    sh_ldn : in STD_LOGIC;
    clk    : in STD_LOGIC;
    clken  : in STD_LOGIC;
    d      : in std_logic_vector(7 downto 0);
    Q      : out STD_LOGIC
    
    );
END COMPONENT;
--Inputs
signal serin    : std_logic := '0';
signal sh_ldn   : std_logic := '0';
signal resetn   : std_logic := '0';
signal clk      : std_logic := '0';
signal clken    : std_logic := '0';
signal d        : std_logic_vector (7 downto 0) := (others => '0');

--Outputs
signal q  : std_logic;

-- Clock period definitions
constant clk_period : time := 10 ns;

begin

-- Instantiate the Unit Under Test (UUT)
uut: parin_serout PORT MAP (
serin  => serin,
clk    => clk,
clken  => clken,
sh_ldn => sh_ldn,
resetn => resetn,
d      => d,
Q      => Q

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
    -- wait for stabilization
    wait for clk_period*2;
	-- stop reset, enable clock, serin='1' 
    resetn <= '1'; 
    serin  <= '1';  
    clken  <= '1';  
	-- stimulate parallel data input
    for i in 0 to 7 loop
        d <= std_logic_vector(to_unsigned(i, d'length));
        sh_ldn <= '0'; -- load data
        wait for clk_period;
        sh_ldn <= '1'; -- shift data
        wait for clk_period*8;
		-- all data bits are sent, continue with the next
    end loop;
    -- load data
    d <= x"AA";
    sh_ldn <= '0';
    wait for clk_period;
	-- shift data
    sh_ldn <= '1';
    wait for clk_period*2;
	-- halt shifting
    clken <= '0';
    wait for clk_period*4;
	-- continue shifting
    clken <= '1';
    serin <= '0';
    wait for clk_period*8;
    -- reset device
    serin <= '1';
    resetn <= '0';
    wait for clk_period*2;
	-- continue normal operation
    resetn <= '1';
    wait for clk_period*8;
      
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
