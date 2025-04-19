-- SIMULATION MODIFIED 4-BIT PRELOADED UP-DOWN COUNTER
-- 08.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity up_down_cnt_mod_sim is
--  Port ( );
end up_down_cnt_mod_sim;

architecture Behavioral of up_down_cnt_mod_sim is
component up_down_cnt_mod is
    Port ( 
    q       : out std_logic_vector(3 downto 0);
    d       : in  std_logic_vector(3 downto 0);
    clk     : in  STD_LOGIC;
    ld      : in  STD_LOGIC;
    down    : in  STD_LOGIC; -- down count input
    co      : out STD_LOGIC; -- carry out 
    ci      : in  STD_LOGIC; -- carry in 
    resetn  : in  STD_LOGIC  -- negative logic reset
           );
end component;

--Inputs
signal resetn   : std_logic := '0';
signal clk      : std_logic := '0';
signal ld       : std_logic := '0';
signal ld1      : std_logic := '0';-- primary ld source
signal div_by_n : std_logic := '0';-- div_by_n mode selector
signal down     : std_logic := '0';
signal ci       : std_logic := '0';
signal co       : std_logic := '0';
signal d        : std_logic_vector (3 downto 0) := (others => '0');

--Outputs
signal q : std_logic_vector (3 downto 0);

-- Clock period definitions
constant clk_period : time := 10 ns;

begin
-- Instantiate the Unit Under Test (UUT)
uut: up_down_cnt_mod PORT MAP (
q      => q,
d      => d,
clk    => clk,
ld     => ld,
down   => down,
ci     => ci,
co     => co,
resetn => resetn
);
-- ld pin source selector
with div_by_n select
    ld        <= ld1 when '0',
                 co  when '1',
                 co when others;

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
    -- prepare the counter
    d      <= x"9"; -- data
    div_by_n <= '0';
    ld1    <= '0';  -- no load
    down   <= '0';  -- up count 
    resetn <= '0';  -- reset active
    ci     <= '1';  -- carry in active
    wait for clk_period*2;
	-- count up
    resetn <= '1';
    wait for clk_period*18;
	-- count down
    down   <= '1';
    wait for clk_period*22;
    -- reset device
    resetn <= '0';
    wait for clk_period;
	-- div by 10 mode
	-- load with data (x"9")
    resetn <= '1';
    ld1    <= '1';
	wait for clk_period;
    div_by_n     <= '1';
    wait for clk_period*30;
    
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
