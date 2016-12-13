----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:17:11 11/10/2016 
-- Design Name: 
-- Module Name:    Program_counter - Behavioral 
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
use IEEE.STD_LOGIC_Arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Program_counter is
port ( clk: in std_logic;
       reset: in std_logic;
		 pc_out: out std_logic_vector(31 downto 0);
		 pc_out_plus1: out std_logic_vector(31 downto 0);
		 pc_in : in std_logic_vector(31 downto 0)
		 );
end Program_counter;

architecture Behavioral of Program_counter is
signal count: std_logic_vector(31 downto 0);
begin
process(clk,reset,count)
begin 
if(reset='1') then
count<=X"00000000";
elsif(rising_edge(clk)) then
count<=pc_in;
end if;
end process;

pc_out<=count;
pc_out_plus1<=count+'1';
end Behavioral;

