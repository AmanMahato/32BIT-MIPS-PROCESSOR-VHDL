----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:28:55 12/13/2016 
-- Design Name: 
-- Module Name:    FPGA_MAP_uPRocessor - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FPGA_MAP_uPRocessor is
      port (sel         : in std_logic_vector(1 downto 0);
		     BTN				: in 	 std_logic;
           CLK_FPGA 		: in   STD_LOGIC;
           SSEG_CA 		: out  STD_LOGIC_VECTOR (7 downto 0);
           SSEG_AN 		: out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end FPGA_MAP_uPRocessor;

architecture Behavioral of FPGA_MAP_uPRocessor is


component Hex2LED 
port (CLK: in STD_LOGIC; X: in STD_LOGIC_VECTOR (3 downto 0); Y: out STD_LOGIC_VECTOR (7 downto 0)); 
end component; 

COMPONENT uProcessor
	PORT(
		clk, reset : in std_logic;
       out_cyphertext : out std_logic_vector(63 downto 0);
		 out_plaintext  : out std_logic_vector(63 downto 0)
		);
	END COMPONENT;

type arr is array(0 to 22) of std_logic_vector(7 downto 0);
signal NAME: arr;

constant CNTR_MAX : std_logic_vector(23 downto 0) := x"030D40"; --100,000,000 = clk cycles per second
constant VAL_MAX : std_logic_vector(3 downto 0) := "1001"; --9

constant RESET_CNTR_MAX : std_logic_vector(17 downto 0) := "110000110101000000";-- 100,000,000 * 0.002 = 200,000 = clk cycles per 2 ms

--signals i defined
		signal cypherOut	: STD_LOGIC_VECTOR(63 DOWNTO 0); -- 64-bit output
	   signal plainOut	: STD_LOGIC_VECTOR(63 DOWNTO 0);  -- 64-bit output
	   signal dispval: std_logic_vector(31 downto 0);--for led display 
		


--This is used to determine when the 7-segment display should be
--incremented
signal Cntr : std_logic_vector(26 downto 0) := (others => '0');

--This counter keeps track of which number is currently being displayed
--on the 7-segment.
signal Val : std_logic_vector(3 downto 0) := (others => '0');

--This is the signal that holds the hex value to be diplayed
signal hexval: std_logic_vector(31 downto 0):=x"0123ABCD";


signal clk_cntr_reg : std_logic_vector (4 downto 0) := (others=>'0'); 
signal cnt: std_logic_vector(3 downto 0);
signal clk1,clk2 : std_logic;
begin

----------------------------------------------------------
------              RC5 Control                -------
----------------------------------------------------------

process(CLK_FPGA,BTN)
begin
if(BTN ='1') then
clk2<= '0';
cnt<= (others => '0');
elsif(rising_edge(CLK_FPGA)) then
if(cnt="0001") then
cnt<=(others =>'0');
clk2<= not(clk2);
else 
cnt<= cnt + '1';
end if;
end if;
end process;
clk1 <= clk2;


process(sel)
begin
if( sel = "00") then
	   dispval <= cypherOut(63 downto 32);
elsif(sel="01") then
      dispval <= cypherOut(31 downto 0);
elsif(sel="10") then
		dispval <= plainOut(63 downto 32);
elsif(sel="11") then
	   dispval <= plainOut(31 downto 0);
end if;
end process;



----------------------------------------------------------
------           7-Seg Display Control             -------
----------------------------------------------------------
--Digits are incremented every second, and are blanked in
--response to button presses.

--This process controls the counter that triggers the 7-segment
--to be incremented. It counts 100,000,000 and then resets.		  
timer_counter_process : process (CLK_FPGA)
begin
	if (rising_edge(CLK_FPGA)) then
		if ((Cntr = CNTR_MAX) or (BTN = '1')) then
			Cntr <= (others => '0');
		else
			Cntr <= Cntr + 1;
		end if;
	end if;
end process;

--This process increments the digit being displayed on the 
--7-segment display every second.
timer_inc_process : process (CLK_FPGA)
begin
	if (rising_edge(CLK_FPGA)) then
		if (BTN = '1') then
			Val <= (others => '0');
		elsif (Cntr = CNTR_MAX) then
			if (Val = VAL_MAX) then
				Val <= (others => '0');
			else
				Val <= Val + 1;
			end if;
		end if;
	end if;
end process;

--This select statement selects the 7-segment diplay anode. 
with Val select
	SSEG_AN <= "01111111" when "0001",
				  "10111111" when "0010",
				  "11011111" when "0011",
				  "11101111" when "0100",
				  "11110111" when "0101",
				  "11111011" when "0110",
				  "11111101" when "0111",
				  "11111110" when "1000",
				  "11111111" when others;

--This select statement selects the value of HexVal to the necessary
--cathode signals to display it on the 7-segment
with Val select
	SSEG_CA <= NAME(0) when "0001",
				  NAME(1) when "0010",
				  NAME(2)when "0011",
				  NAME(3) when "0100",
				  NAME(4) when "0101",
				  NAME(5) when "0110",
				  NAME(6) when "0111",
				  NAME(7) when "1000",
				  NAME(0) when others;


CONV1: Hex2LED port map (CLK => CLK_FPGA, X => dispval(31 downto 28), Y => NAME(0));
CONV2: Hex2LED port map (CLK => CLK_FPGA, X => dispval(27 downto 24), Y => NAME(1));
CONV3: Hex2LED port map (CLK => CLK_FPGA, X => dispval(23 downto 20), Y => NAME(2));
CONV4: Hex2LED port map (CLK => CLK_FPGA, X => dispval(19 downto 16), Y => NAME(3));		
CONV5: Hex2LED port map (CLK => CLK_FPGA, X => dispval(15 downto 12), Y => NAME(4));
CONV6: Hex2LED port map (CLK => CLK_FPGA, X => dispval(11 downto 8), Y => NAME(5));
CONV7: Hex2LED port map (CLK => CLK_FPGA, X => dispval(7 downto 4), Y => NAME(6));
CONV8: Hex2LED port map (CLK => CLK_FPGA, X => dispval(3 downto 0), Y => NAME(7));
x1: uProcessor PORT MAP(reset => BTN,clk => clk1,out_cyphertext => cypherOut,out_plaintext => plainOut);

end Behavioral;
