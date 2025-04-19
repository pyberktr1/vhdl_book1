-- CODELOCK FINITE STATE MACHINE
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity codelock is
    Port ( key    : in STD_LOGIC_VECTOR (3 downto 0);
           resetn : in STD_LOGIC;
           clk    : in STD_LOGIC;
           strobe : in STD_LOGIC;
           code   : in STD_LOGIC_VECTOR (15 downto 0);
           digit  : out std_logic_vector(1 downto 0);
           lock   : out STD_LOGIC
           );
end codelock;

architecture Behavioral of codelock is
signal strobe_old : std_logic := '0';
signal state      : std_logic_vector(2 downto 0) := "000";
signal cnt        : std_logic_vector(3 downto 0) := (others => '0');

begin

lock  <= state(2);
digit <= state(1 downto 0);

key_proc: process(clk)
begin
  if rising_edge(clk) then
    if (resetn = '0') then -- there is a reset signal
      state <= (others => '0');
      strobe_old <= '0';
      cnt <= (others => '0');
    else
      strobe_old <= strobe;-- sample strobe in for edge detection
	  -- rising edge of the strobe signal detected (a key just pressed)
      if (strobe_old = '0' and strobe = '1') then 
        case state is
          when "000" => -- first wait state (reset state)
            if (key = code(15 downto 12)) then -- key code matches
              state <= state + 1;-- proceed to next match state
            else
              state <= "000"; -- no match, start all over
            end if;
            cnt <= cnt;-- no pause or time delay
          when "001" => -- second digit 
            if (key = code(11 downto 8)) then -- key code matches
              state <= state + 1;-- proceed to next match state
            else
              state <= "000"; -- no match, start all over
            end if;
            cnt <= cnt;-- no pause or time delay
          when "010" => -- third digit
            if (key = code(7 downto 4)) then -- key code matches
              state <= state + 1;-- proceed to next match state
            else
              state <= "000"; -- no match, start all over
            end if;
            cnt <= cnt;-- no pause or time delay
          when "011" => -- fourth digit 
            if (key = code(3 downto 0)) then -- key code matches
              state <= state + 1;-- proceed to next match state
            else
              state <= "000"; -- no match, start all over
            end if;
            cnt <= cnt;-- no pause or time delay
          when "100" => -- code okey, open the door
            if (cnt(3) = '1') then -- reset door lock
              state <= "000";
              cnt   <= (others => '0');
            else
              state <= state;-- wait for door to open (1 second)
              cnt   <= cnt + 1;
            end if;
          when others => -- wrong state, reset system
            state <= "000"; -- reset state
            cnt   <= (others => '0');
        end case;
      else-- no new key to match
        if (state = "100") then -- door lock open
          if (cnt(3) = '1') then -- reset door lock
            state <= "000";
            cnt   <= (others => '0');
          else
            state <= state;-- wait for door to open (1 second)
            cnt   <= cnt + 1;
          end if;
        else -- no door to open, may be a wrong state
		  if (state(2) = '0') then -- correct state, hold states
            state <= state;
            cnt   <= cnt;
		  else -- wrong state, reset states
            state <= "000";
            cnt   <= (others => '0');
		  end if;-- handle wrong states
        end if;-- door lock
      end if;-- new key
    end if;-- resetn
  end if;-- clock    
end process;

end Behavioral;
