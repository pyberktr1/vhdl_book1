-- JK FLIP-FLOP
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity JK_FF is
    Port ( 
    J   : in STD_LOGIC;
    K   : in STD_LOGIC;
    clk : in STD_LOGIC;
    Q   : out STD_LOGIC;
    Qp  : out STD_LOGIC
    );
end JK_FF;

architecture Behavioral of JK_FF is
-- Intermeditate signals
signal JK  : std_logic_vector(1 downto 0) := "00";
signal QQp : std_logic_vector(1 downto 0) := "01";

begin
-- Bundle J, K inputs in one signal bus
JK <= J & K;
-- Resolve QQp signal to outputs
Q  <= QQp(1);
Qp <= QQp(0);

JK_FF_process: process(clk)
-- we use a sensitivity list with clk in it
begin
  -- we use falling_edge() edge detector function
  -- to detect falling edge of clk signal
  if falling_edge(clk) then
    -- we use a case structure instead of nested ifs
    case JK is -- we define each state of the FF
	-- we handle the JK FF a FSM here
	-- Each JK input value excites a different state
        when "00" => QQp <= QQp;     -- hold state
        when "01" => QQp <= "01";    -- reset state
        when "10" => QQp <= "10";    -- set state
        when "11" => QQp <= not QQp; -- toggle state
		-- there is no undefined state
		-- however we define a default entry to be sure
		-- Usually the default action in an FSM is
		-- to hold the actual state but the behavior 
		-- may be different in different applications
        when others => QQp <= QQp;   -- hold state
     end case;
  end if;
end process;
end Behavioral;
