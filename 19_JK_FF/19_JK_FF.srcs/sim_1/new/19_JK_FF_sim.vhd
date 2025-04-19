-- SIMULATION JK FLIP-FLOP
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity JK_FF_sim is
--  Port ( );
end JK_FF_sim;

architecture Behavioral of JK_FF_sim is

COMPONENT JK_FF
Port (      
    J    : in std_logic;
    K    : in std_logic;
    clk  : in std_logic;
    Q    : out std_logic;
    Qp   : out std_logic
    
    );
END COMPONENT;    
--Inputs
signal J   : std_logic := '0';
signal K   : std_logic := '0';
signal clk : std_logic := '0';
signal input : std_logic_vector (1 downto 0) := "00";

--Outputs
signal Q    : std_logic;
signal Qp   : std_logic;

-- Clock period definitions
constant clk_period : time := 40 ns;

begin

-- Instantiate the Unit Under Test (UUT)
uut: JK_FF PORT MAP (
J   => J,
K   => K,
clk => clk,
Q   => Q,
Qp  => Qp
);

J <= input(1);
K <= input(0);

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
    wait for clk_period*2.5;
	-- stimulate inputs
    for i in 0 to 7 loop
        input <= std_logic_vector(to_unsigned(i, input'length));
        wait for clk_period;
    end loop;
    
	-- Toggle state
    input <= "11";
    wait for clk_period*3;
    
	-- Hold state
    input <= "00";
    wait for clk_period*2;
    
	-- Toggle state
    input <= "11";
    wait for clk_period*3;
    
	-- Hold state
    input <= "00";
    wait for clk_period*5;

    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
