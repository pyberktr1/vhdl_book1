-- 2-BIT COMPARATOR Ver2.0
-- 16.02.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comp_2bit_ver2 is
    Port ( 
	-- comparator inputs
    A  : in STD_LOGIC_VECTOR (1 downto 0);
    B  : in STD_LOGIC_VECTOR (1 downto 0);
	-- inputs from lower digit
    eqi  : in std_logic; -- A=B
    asbi : in std_logic; -- A<B
    abbi : in std_logic; -- A>B
    eqo  : out std_logic; -- A=B
    asbo : out std_logic; -- A<B
    abbo : out std_logic  -- A>B
    );
end comp_2bit_ver2;

architecture Behavioral of comp_2bit_ver2 is

-- error checking component
COMPONENT err_comp
PORT(
    eqi  : in std_logic; -- A=B
    asbi : in std_logic; -- A<B 
    abbi : in std_logic; -- A>B
    erro : out std_logic -- error output
);
END COMPONENT;

-- intermediate (temporary) signals
signal err  : std_logic;
signal eqit : std_logic;
signal abbit: std_logic;
signal asbit: std_logic;

begin
 -- signal assignments
 eqit  <= eqi;
 asbit <= asbi;
 abbit <= abbi;

 -- error checking component instantiation
 inst_err_comp: err_comp port map (
   eqi  => eqit,
   asbi => asbit,
   abbi => abbit,
   erro => err     
        
        );
 
 -- comparator process
 comp_proc: process(A, B, eqi, asbi, abbi, err)
 begin 
   if (err='1') then -- error
     eqo  <= '0';
     asbo <= '0';
     abbo <= '0';
   -- no error, we can evaluate input signals       
   elsif (A=B) then -- A equal to B
	 -- pass lower digit compare signals to higher digits
	 eqo  <= eqi;
     asbo <= asbi;
     abbo <= abbi;        
   elsif (A<B) then -- A smaller than B
     eqo  <= '0';
     asbo <= '1';
     abbo <= '0';
   elsif (A>B) then -- A bigger than B
     eqo  <= '0';
     asbo <= '0';
     abbo <= '1';
   else -- generate an error condition
     eqo  <= '0';
     asbo <= '0';
     abbo <= '0';
   end if;      
    
 end process;

end Behavioral;
