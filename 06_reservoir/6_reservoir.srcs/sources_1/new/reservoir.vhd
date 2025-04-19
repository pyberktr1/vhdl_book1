-- Water Well and Reservoir Controller
-- 10.08.2024 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reservoir is
    Port ( 
	-- Sensor inputs
	-- S(0): well dry when logic 0
	-- S(1): well overflowing when logic 1
	-- S(2): reservoir full when logic 1
	S : in  STD_LOGIC_VECTOR (2 downto 0);
	
	-- Actuator outputs
	-- P: Pump (logic 1 active)
	P : out STD_LOGIC;
	-- V: Valve (direction: to reservoir when logic 1)
    V : out STD_LOGIC
		   );
end reservoir;

architecture Behavioral of reservoir is

begin

 controller:process(S)
 begin
   if (S(0)='0') then-- water well dried!
     -- stop Pump
     -- in each case pump stops, 
	 -- valve position is not important	 
     P <= '0';
   else -- water well has water (may overflow)
     -- look if reservoir is empty
     if (S(2)='0') then-- reservoir is empty
	   -- pump on, valve direction to reservoir
	   P <= '1';
	   V <= '1';	   
	 else -- reservoir is full
	 -- look if well overflowing
	   if (S(1)='1') then-- well overflows
	     -- pump on, valve direction to drain
	     P <= '1';
		 V <= '0';
	   else -- reservoir full but no well overflows
	     -- pump must be stopped to conserve power and water
	     P <= '0'; -- if pump stopped, valve position is not important
	   end if;
	 end if;
   end if;
 
 end process controller;

end Behavioral;
