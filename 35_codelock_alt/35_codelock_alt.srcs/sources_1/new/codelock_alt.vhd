-- ALTERNATIVE CODELOCK FINITE STATE MACHINE
-- 10.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity codelock_alt is
    Port ( key    : in STD_LOGIC_VECTOR (3 downto 0);
           resetn : in STD_LOGIC;
           clk    : in STD_LOGIC;
           strobe : in STD_LOGIC;
           code   : in STD_LOGIC_VECTOR (15 downto 0);
           digit  : out std_logic_vector(3 downto 0);
           lock   : out STD_LOGIC
           );
end codelock_alt;

architecture Behavioral of codelock_alt is
signal strobe_old : std_logic := '0';
signal key_in     : std_logic_vector(15 downto 0) := (others => '0');
signal cnt        : std_logic_vector(3 downto 0) := (others => '0');
-- state enumaration
type state_type is (reset, key1, key2, key3, key4, door_open);
signal state      : state_type := reset;

begin
-- key digit indicator process
key_digit_proc: process(state)
begin 
  case state is
    when reset     => digit <= "0000";
    when key1      => digit <= "1000";
	when key2      => digit <= "1100";
	when key3      => digit <= "1110";
	when key4      => digit <= "1111";
	when door_open => digit <= "1111";
	when others    => digit <= "1001";-- error
  end case;
end process;
-- door opener process
door_proc: process(state)
begin
  if (state = door_open) then
    lock <= '1';  
  else
    lock <= '0'; 
  end if;
end process;
-- key input evaluation process
key_proc: process(clk)
begin
  if rising_edge(clk) then
    if (resetn = '0') then -- there is a reset signal
      state      <= reset;
      strobe_old <= '0';
      cnt        <= (others => '0');
      key_in     <= (others => '0');
    else
      strobe_old <= strobe;-- sample strobe in for edge detection
	  -- rising edge of the strobe signal detected (a key just pressed)
      if (strobe_old = '0' and strobe = '1') then 
        case state is
          when reset => -- first wait state (reset state)
		    state  <= key1;
			key_in <= key & key_in(11 downto 0);
            cnt    <= (others => '0');-- no pause or time delay
          when key1 => -- wait second digit 
		    state  <= key2;
			key_in <= key_in(15 downto 12) & key & key_in(7 downto 0);
            cnt    <= (others => '0');-- no pause or time delay
          when key2 => -- wait third digit
		    state  <= key3;
			key_in <= key_in(15 downto 8) & key & key_in(3 downto 0);
            cnt    <= (others => '0');-- no pause or time delay
          when key3 => -- wait fourth digit 
		    state  <= key4;
			key_in <= key_in(15 downto 4) & key;
            cnt    <= (others => '0');-- no pause or time delay
          when key4 => -- code okey?, then open the door
            if (key_in = code) then -- open door lock
              state  <= door_open;
              cnt    <= (others => '0');
            else
              state  <= reset;-- go back and retry
              cnt    <= (others => '0');
            end if;
            key_in <= (others => '0');
          when door_open => -- open the door
            if (cnt(3) = '1') then -- timeout, reset door lock
              state  <= reset;
              cnt    <= (others => '0');
            else
              state  <= door_open;-- wait for door to open (1 second)
              cnt    <= cnt + 1;
            end if;
            key_in <= (others => '0');
          when others => -- wrong state, reset system
            state  <= reset; -- reset state
            cnt    <= (others => '0');
            key_in <= (others => '0');
        end case;
      else-- no new key to match
        if (state = door_open) then -- door lock open
          if (cnt(3) = '1') then -- timeout, reset door lock
            state  <= reset;
            cnt    <= (others => '0');
          else
            state  <= door_open;-- wait for door to open (1 second)
            cnt    <= cnt + 1;
          end if;
          key_in <= (others => '0');
        else -- no door to open,
		  if (state > door_open) then -- wrong state, reset device
            state  <= reset;
            cnt    <= (others => '0');
            key_in <= (others => '0');
		  else -- valid state, hold state
            state  <= state;
            cnt    <= cnt;
            key_in <= key_in;
		  end if;-- handle wrong state
        end if;-- door lock
      end if;-- new key
    end if;-- resetn
  end if;-- clock    
end process;

end Behavioral;
