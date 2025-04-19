-- SIMULATION CODELOCK FINITE STATE MACHINE
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity codelock_sim is
--  Port ( );
end codelock_sim;

architecture Behavioral of codelock_sim is

component codelock is
    Port ( key    : in STD_LOGIC_VECTOR (3 downto 0);
           resetn : in STD_LOGIC;
           clk    : in STD_LOGIC;
           strobe : in STD_LOGIC;
           code   : in STD_LOGIC_VECTOR (15 downto 0);
           digit  : out std_logic_vector(1 downto 0);
           lock   : out STD_LOGIC
           );
end component;

--Inputs
signal resetn   : std_logic := '0';
signal clk      : std_logic := '0';
signal strobe   : std_logic := '0';
signal key      : std_logic_vector (3 downto 0) := (others => '0');
signal code     : std_logic_vector (15 downto 0) := (others => '0');

--Outputs
signal lock  : std_logic;
signal digit : std_logic_vector (1 downto 0);

-- Clock period definitions
constant clk_period : time := 10 ns;

begin
-- Instantiate the Unit Under Test (UUT)
uut: codelock PORT MAP (
key    => key,
clk    => clk,
strobe => strobe,
code   => code,
digit  => digit,
resetn => resetn,
lock   => lock

);

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
    -- prepare module, reset device
    resetn <= '0';
    code   <= x"7806";-- code to open door
    strobe <= '0';
    wait for clk_period*2;
	-- enter first digit
    resetn <= '1';
    key    <= x"7";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter second digit
    key    <= x"8";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter third digit
    key    <= x"0";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter fourth digit
    key    <= x"6";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter another digit
    key    <= x"7";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter digit
    key    <= x"8";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter digit
    key    <= x"0";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter digit
    key    <= x"6";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter digit
    key    <= x"0";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter digit
    key    <= x"8";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter digit
    key    <= x"7";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter digit
    key    <= x"8";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter digit
    key    <= x"0";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
    -- enter digit
    key    <= x"7";
    strobe <= '1';
    wait for clk_period;
    strobe <= '0';
    wait for clk_period;
       
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
