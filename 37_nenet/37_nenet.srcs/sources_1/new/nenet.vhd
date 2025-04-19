-- NERONAURALLOGIX NET (NENET) DESIGN
-- 15.03.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nenet is
    Port ( 
	  reset : in  STD_LOGIC; -- master reset
	  clk   : in  STD_LOGIC; -- clock
	  lrn   : in  STD_LOGIC; -- load/run mode select
	  len   : in  STD_LOGIC; -- load enable
	  ldata : in  STD_LOGIC_VECTOR(3 downto 0); -- load data
	  laddr : in  STD_LOGIC_VECTOR(3 downto 0); -- load data cell address
	  nno   : out STD_LOGIC_VECTOR(3 downto 0)  -- nenet output
           );
end nenet;

architecture Behavioral of nenet is

component neronaurallogix is
    Port ( 
	  reset : in  STD_LOGIC; -- master reset
	  clk   : in  STD_LOGIC; -- clock
	  lrn   : in  STD_LOGIC; -- load/run mode select
	  le    : in  STD_LOGIC; -- load enable
	  m1    : in  STD_LOGIC_VECTOR(3 downto 0); -- multiplier input1
	  m2    : in  STD_LOGIC_VECTOR(3 downto 0); -- multiplier input2
	  a1    : in  STD_LOGIC_VECTOR(3 downto 0); -- adder input
	  ldata : in  STD_LOGIC_VECTOR(3 downto 0); -- load data
	  o     : out STD_LOGIC_VECTOR(3 downto 0)  -- neronaurallogix output
           );
end component neronaurallogix;

component demux_4x16 is
    Port ( 
      X  : in  std_logic_vector (3 downto 0);
      EN : in  std_logic;
      Y  : out std_logic_vector (15 downto 0)
        );
end component demux_4x16;

-- 2-D array type definitions
type vector_array_2D is array 
  ( integer range <>, integer range <>) of 
    STD_LOGIC_VECTOR(3 downto 0);
  
-- input output signals for 
-- row=2 by column=3 array of neronaurallogix
signal q     : vector_array_2D(0 to 2, 0 to 3) 
             := (others => (others =>(others => '0')));
			 
signal le    : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

begin

-- address decoder
addr_decode_inst : demux_4x16
  port map
  (
    X  => laddr,
	EN => len,
	Y  => le
  );
  
-- q signal connected to output
nno <= q(0,3);
-- neronaurallogix net (nenet)
-- generate statement
nenet_gen :

  for i in 0 to 2 generate   
    begin
	row_gen:
	  for j in 0 to 3 generate
	    begin
          neron_inst : neronaurallogix 
	       port map   
           (
		   o     => q(i,j),
	       reset => reset,
           clk   => clk,
           lrn   => lrn,
           le    => le(4*i+j),
           m1    => q(i,(j+3) mod 4),
           m2    => q((i+1) mod 3,j),
           a1    => q((i+2) mod 3,j),
           ldata => ldata
			);  
		end generate row_gen;
    end generate nenet_gen;

end Behavioral;
