-- D-TYPE FLIP-FLOP
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FF is
    Port ( 
    D   : in STD_LOGIC := '0'; -- Data in
    clk : in STD_LOGIC;        -- edge trigger in
    pre : in STD_LOGIC;        -- preset in (negative logic)
    clr : in STD_LOGIC;        -- clear in (negative logic)
    Q   : out STD_LOGIC := '1' -- Data out
    );
end D_FF;

architecture Behavioral of D_FF is

begin

D_FF_process: process
-- there should be at least a clock signal in the sensitivity list
-- but wait statement in the process body does not permit a 
-- sensitivity list in the process.
-- wait statements are not allowed in processes with
-- a sensitivity list.
begin
 -- hold the process execution until 
 -- a rising edge occurs on clk input (clock signal)
 wait until rising_edge (clk);
 if pre = '1' then -- no preset
    if clr = '1' then -- no clear
        if D = '1' then -- set output
            Q <= '1';
        else
            Q <= '0'; -- reset output
        end if;
    else -- clear output
        Q <= '0';
    end if;
 else -- preset output
    Q <= '1';
 end if;
end process;

end Behavioral;
