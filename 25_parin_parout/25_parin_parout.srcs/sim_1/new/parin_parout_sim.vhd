-- SIMULATION PARALLEL IN PARALLEL OUT SHIFT REGISTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity parin_parout_sim is
--  Port ( );
end parin_parout_sim;

architecture Behavioral of parin_parout_sim is

COMPONENT parin_parout
Port (      
    serin  : in STD_LOGIC;
    resetn : in STD_LOGIC;
    sh_ldn : in STD_LOGIC;
    clk    : in STD_LOGIC;
    clken  : in STD_LOGIC;
    d      : in std_logic_vector(7 downto 0);
    Q      : out std_logic_vector(7 downto 0)
    
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
signal Q        : std_logic_vector (7 downto 0);

-- Clock period definitions
constant clk_period : time := 10 ns;

begin

-- Instantiate the Unit Under Test (UUT)
uut: parin_parout PORT MAP (
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
    -- ready to operate
    resetn <= '1'; 
    serin  <= '0';  
    clken  <= '1';  
	-- stimulate inputs
    for i in 0 to 7 loop
        d <= std_logic_vector(to_unsigned(i, d'length));
        sh_ldn <= '0';
        wait for clk_period;
        sh_ldn <= '1';
        wait for clk_period*8;
    end loop;
    -- manual operations
	-- load SR
    serin <= '1';
    d <= x"AA";
    sh_ldn <= '0';
    wait for clk_period;
	-- Shift bits out
    sh_ldn <= '1';
    wait for clk_period*2;
	-- make a pause
    clken <= '0';
    wait for clk_period*4;
	-- Continue shifting
    clken <= '1';
    wait for clk_period*8;
    -- reset device, clear SR
    resetn <= '0';
    wait for clk_period*2;
	-- continue shifting
    resetn <= '1';
    wait for clk_period*8;
      
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
