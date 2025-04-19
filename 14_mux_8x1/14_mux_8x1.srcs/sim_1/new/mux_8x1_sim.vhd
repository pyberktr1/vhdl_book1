-- SIMULATION 8-TO-1 MULTIPLEXER
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_8x1_sim is
--  Port ( );
end mux_8x1_sim;

architecture Behavioral of mux_8x1_sim is

COMPONENT mux_8x1
Port (      S : in STD_LOGIC_VECTOR (2 downto 0);
            D : in STD_LOGIC_VECTOR (7 downto 0);
            EN: in std_logic;
            Y : out std_logic
            );
END COMPONENT;
--Inputs
signal inS : std_logic_vector (2 downto 0) := "000";
signal inD : std_logic_vector (7 downto 0) := "10101010";
signal EN  : std_logic := '1';

--Outputs
signal output : std_logic;

-- Clock period definitions
constant clk_period : time := 100 ns;

begin

-- Instantiate the Unit Under Test (UUT)
uut: mux_8x1 PORT MAP (
S  => inS,
D  => inD,
EN => EN,
Y  => output

);

-- Stimulus process
stim_proc: process
begin
  for i in 7 downto 0 loop
    inS <= std_logic_vector(to_unsigned(i, inS'length));
       
    wait for clk_period;
        
  end loop;

  -- simulation stops completely
  assert false report "test finished!" severity FAILURE;

end process;


end Behavioral;
