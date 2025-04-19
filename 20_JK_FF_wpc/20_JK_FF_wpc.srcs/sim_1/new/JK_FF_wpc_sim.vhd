-- SIMULATION JK FLIP-FLOP WITH PRESET AND CLEAR
-- 25.02.2025 by Bilgehan ERKAL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity JK_FF_wpc_sim is
--  Port ( );
end JK_FF_wpc_sim;

architecture Behavioral of JK_FF_wpc_sim is

COMPONENT JK_FF_wpc
Port ( 
    pre  : in STD_LOGIC;
    clr  : in STD_LOGIC;     
    J    : in std_logic;
    K    : in std_logic;
    clk  : in std_logic;
    Q    : out std_logic;
    Qp   : out std_logic
    
    );
END COMPONENT;    
--Inputs
signal pre : std_logic := '1';
signal clr : std_logic := '1';
signal J   : std_logic := '0';
signal K   : std_logic := '0';
signal clk : std_logic := '0';
signal input : std_logic_vector (3 downto 0) := "1100";

--Outputs
signal Q            : std_logic;
signal Qp           : std_logic;
signal output       : std_logic_vector(1 downto 0):= "01";
signal output_old   : std_logic_vector(1 downto 0):= "01";

-- Clock period definitions
constant clk_period : time := 40 ns;

begin
-- bus bundle
output <= Q & Qp;

-- Instantiate the Unit Under Test (UUT)
uut: JK_FF_wpc PORT MAP (
pre => pre,
clr => clr,
J   => J,
K   => K,
clk => clk,
Q   => Q,
Qp  => Qp
);

pre <= input(3);
clr <= input(2);
J   <= input(1);
K   <= input(0);

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
    for i in 0 to 15 loop
		output_old <= output; -- register previous value
        input <= std_logic_vector(to_unsigned(i, input'length));
        wait for clk_period;
		-- evaluate input and output of the uut, 
		-- report error if actual outputs
        -- does not comply with the expected outputs		
        case i is
		  when 0 to 7 => assert (output="10") 
		    report "error on preset, input: " & integer'image(i) 
			severity error; -- preset state
			
		  when 8 to 11 => assert (output="01") 
		    report "error on clear, input: " & integer'image(i) 
			severity error; -- clear state
			
		  when 12 => assert (output=output_old) 
		    report "error on hold, out: " & 
			integer'image(to_integer(unsigned(output))) & 
			"out_old: " & 
			integer'image(to_integer(unsigned(output_old)))
			severity error; -- hold state
			
		  when 13 => assert (output="01") 
		    report "error on reset, out: " & 
			integer'image(to_integer(unsigned(output))) 
			severity error; -- reset state
			
		  when 14 => assert (output="10") 
		    report "error on set, out: " & 
			integer'image(to_integer(unsigned(output)))
			severity error; -- set state
			
		  when 15 => assert 
		   (((output = "01") AND (output_old = "10")) OR 
            ((output = "10") AND (output_old = "01"))) 
		    report "error on toggle, out: " & 
			integer'image(to_integer(unsigned(output))) &
			"output_old: " & 
			integer'image(to_integer(unsigned(output_old)))
			severity error; -- toggle state
            
          when others => assert (output="00") 
			report "error on others, input: " & integer'image(i)
			severity error;
          end case;

    end loop;

    assert false report "test finished!" severity FAILURE;

end process;

end Behavioral;
