----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:59:57 12/05/2016 
-- Design Name: 
-- Module Name:    SignExtend - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;



entity SignExtend is
  port( se_in: in std_logic_vector(15 downto 0);
		  se_out: out std_logic_vector(31 downto 0));
end SignExtend;

architecture Behavioral of SignExtend is

signal output: std_logic_vector(31 downto 0);
signal input: std_logic_vector(15 downto 0);

begin

input <= se_in;
process(input)
  begin
  if(input(15)='0') then
    output <= x"0000" & input;
  else
    output <= x"ffff" & input;
  end if;
end process;
  
se_out <= output;

end Behavioral;

