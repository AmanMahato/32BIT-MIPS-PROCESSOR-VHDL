----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:36:42 12/03/2016 
-- Design Name: 
-- Module Name:    MUX32 - Behavioral 
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

entity MUX32 is
port ( in1,in2 : in std_logic_vector(31 downto 0);
       sel     : in std_logic;
		 output : out std_logic_vector(31 downto 0)
		 );
		 
end MUX32;

architecture Behavioral of MUX32 is
signal output1 : std_logic_vector(31 downto 0);
begin
with sel select
output1<=in1 when '0',
       in2 when '1',
		 output1 when others;
		 
output<=output1;		 
end Behavioral;

