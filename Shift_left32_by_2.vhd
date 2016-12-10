----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:57:04 12/04/2016 
-- Design Name: 
-- Module Name:    Shift_left32_by_2 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Shift_left32_by_2 is
port ( input26 : in std_logic_vector(25 downto 0);
       output28 : out std_logic_vector(27 downto 0)
		 );
end Shift_left32_by_2;

architecture Behavioral of Shift_left32_by_2 is

begin
output28<=input26 & "00";
end Behavioral;

