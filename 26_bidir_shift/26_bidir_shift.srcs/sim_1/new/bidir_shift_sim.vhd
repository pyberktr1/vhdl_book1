-- SIMULATION BI-DIRECTIONAL SHIFT REGISTER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bidir_shift_sim is
--  Port ( );
end bidir_shift_sim;

architecture Behavioral of bidir_shift_sim is
component bidir_shift is
    Port ( 
    lserin : in STD_LOGIC; -- left shift serin
    rserin : in STD_LOGIC; -- right shift serin
    resetn : in STD_LOGIC; -- negative logic
	-- mode select input
    s      : in std_logic_vector(1 downto 0);
    clk    : in STD_LOGIC; -- clock input
    clken  : in STD_LOGIC; -- clock enable input
	-- Data I/O buses
    d      : in std_logic_vector(7 downto 0);
    Q      : out std_logic_vector(7 downto 0)
    );
end component;
--Inputs
signal lserin    : std_logic := '0';
signal rserin    : std_logic := '0';
signal s         : std_logic_vector(1 downto 0):= "00";
signal resetn    : std_logic := '0';
signal clk       : std_logic := '0';
signal clken     : std_logic := '0';
signal d         : std_logic_vector (7 downto 0) := (others => '0');

--Outputs
signal Q         : std_logic_vector (7 downto 0);

-- Clock period definitions
constant clk_period : time := 10 ns;

begin

-- Instantiate the Unit Under Test (UUT)
uut: bidir_shift PORT MAP (
lserin => lserin,
rserin => rserin,
clk    => clk,
clken  => clken,
s      => s,
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
-- Stimulation process
stim_proc: process
begin
    -- ready to shift
    clken <= '1';
	-- wait for stabilization
    wait for clk_period*2;
	-- load SR
    resetn <= '1';
    d <= "00010000";
    s <= "11";--load
    wait for clk_period;
	-- Make a shift right
    lserin <= '1';
    rserin <= '0';
    s <= "01";--shift right
    wait for clk_period*4;
	-- Make a shift left
    s <= "10";--shift left
    wait for clk_period*6;
	-- Pause shifting
    s <= "00";--hold state
    wait for clk_period*4;
	-- Clear SR
    resetn <= '0';
    wait for clk_period*4;
    
    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
