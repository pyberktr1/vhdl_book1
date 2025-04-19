-- JK FLIP-FLOP WITH PRESET AND CLEAR
-- 25.02.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity JK_FF_wpc is
    Port ( 
    pre : in STD_LOGIC; -- negative logic
    clr : in STD_LOGIC; -- negative logic
    J   : in STD_LOGIC;
    K   : in STD_LOGIC;
    clk : in STD_LOGIC;
    Q   : out STD_LOGIC;
    Qp  : out STD_LOGIC
    );
end JK_FF_wpc;

architecture Behavioral of JK_FF_wpc is
-- Intermeditate signals
signal PCJK  : std_logic_vector(3 downto 0) := "0000";
signal QQp   : std_logic_vector(1 downto 0) := "01";

begin
-- Bundle Preset, Clear, J, K inputs in one signal bus
PCJK <= pre & clr & J & K;
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
    case (to_integer(unsigned(PCJK))) is -- we define each state of the FF
	-- we handle the JK FF as an FSM here
	-- Each JK input value excites a different state
        when 0 to 7  => QQp <= "10";     -- preset state ("0000" to "0111")
        when 8 to 11 => QQp <= "01";     -- clear state  ("1000" to "1011")
        when 12 => QQp <= QQp;     -- hold state   ("1100")
        when 13 => QQp <= "01";    -- reset state  ("1101")
        when 14 => QQp <= "10";    -- set state    ("1110")
        when 15 => QQp <= not QQp; -- toggle state ("1111")
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
