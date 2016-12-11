----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:00:40 12/04/2016 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
port(
Reset : in std_logic;
a1: in std_logic_vector(31 downto 0);
a2: in std_logic_vector(31 downto 0);
ALUFunc: in std_logic_vector(5 downto 0);
ALUOp: in std_logic_vector(5 downto 0);
ALUResult: out std_logic_vector(31 downto 0);
zero: out std_logic
);
end ALU;

architecture Behavioral of ALU is

signal ALUOutput: std_logic_vector(31 downto 0);
signal func: std_logic_vector(7 downto 0);
signal op: std_logic_vector(7 downto 0);

begin

func <= "00" & ALUFunc;
op <= "00" & ALUOp;

process(func,op, a1, a2, ALUOutput)
begin
if(Reset='1')then
ALUOutput<=X"00000000";
else
case op is 
   when x"00" =>
	  case func is
	    when x"10" =>
		   ALUOutput <= a1 + a2;
	    when x"11"	=>
		   ALUOutput <= a1 - a2;
		 when x"12" =>
		   ALUOutput <= a1 and a2;
		 when x"13" =>
		   ALUOutput <= a1 or a2;
		 when x"14" =>
         ALUOutput <= a1 nor a2;
		 when others => 
			ALUOutput <= x"ffffffff";
       end case;
		 
	  when x"01" =>
		   ALUOutput <= a1 + a2;
	  when x"02" =>
		   ALUOutput <= a1 - a2;
	  when x"03" =>
		   ALUOutput <= a1 and a2;
	  when x"04" =>
		   ALUOutput <=  a1 or a2;
	  when x"05" => 
		CASE a2(4 DOWNTO 0) IS
			WHEN "00001"=> ALUOutput<= a1(30 DOWNTO 0)&a1(31);
         WHEN "00010"=> ALUOutput<=a1(29 DOWNTO 0)&a1(31DOWNTO 30); 
         WHEN "00011"=> ALUOutput<= a1(28 DOWNTO 0) & a1(31 DOWNTO 29);
			WHEN "00100"=> ALUOutput<= a1(27 DOWNTO 0) & a1(31 DOWNTO 28);
			WHEN "00101"=> ALUOutput<= a1(26 DOWNTO 0) & a1(31 DOWNTO 27);
			WHEN "00110"=> ALUOutput<= a1(25 DOWNTO 0) & a1(31 DOWNTO 26);
			WHEN "00111" => ALUOutput<= a1(24 DOWNTO 0) & a1(31 DOWNTO 25);
			WHEN "01000" => ALUOutput<= a1(23 DOWNTO 0) & a1(31 DOWNTO 24);
			WHEN "01001" => ALUOutput<= a1(22 DOWNTO 0) & a1(31 DOWNTO 23);
			WHEN "01010" => ALUOutput<= a1(21 DOWNTO 0) & a1(31 DOWNTO 22);
			WHEN "01011" => ALUOutput<= a1(20 DOWNTO 0) & a1(31 DOWNTO 21);
			WHEN "01100" => ALUOutput<= a1(19 DOWNTO 0) & a1(31 DOWNTO 20);
			WHEN "01101" => ALUOutput<= a1(18 DOWNTO 0) & a1(31 DOWNTO 19);
			WHEN "01110" => ALUOutput<= a1(17 DOWNTO 0) & a1(31 DOWNTO 18);
			WHEN "01111" => ALUOutput<= a1(16 DOWNTO 0) & a1(31 DOWNTO 17);
			WHEN "10000" => ALUOutput<= a1(15 DOWNTO 0) & a1(31 DOWNTO 16);
			WHEN "10001" =>ALUOutput<= a1(14 DOWNTO 0) & a1(31 DOWNTO 15);
			WHEN "10010" =>ALUOutput<= a1(13 DOWNTO 0) & a1(31 DOWNTO 14);
			WHEN "10011" =>ALUOutput<= a1(12 DOWNTO 0) & a1(31 DOWNTO 13);
			WHEN "10100" =>ALUOutput<= a1(11 DOWNTO 0) & a1(31 DOWNTO 12);
			WHEN "10101" =>ALUOutput<= a1(10 DOWNTO 0) & a1(31 DOWNTO 11);
			WHEN "10110" =>ALUOutput<= a1(9 DOWNTO 0) & a1(31 DOWNTO 10);
			WHEN "10111" =>ALUOutput<= a1(8 DOWNTO 0) & a1(31 DOWNTO 9);
			WHEN "11000" =>ALUOutput<= a1(7 DOWNTO 0) & a1(31 DOWNTO 8);
			WHEN "11001" =>ALUOutput<= a1(6 DOWNTO 0) & a1(31 DOWNTO 7);
			WHEN "11010" =>ALUOutput<= a1(5 DOWNTO 0) & a1(31 DOWNTO 6);
			WHEN "11011" =>ALUOutput<= a1(4 DOWNTO 0) & a1(31 DOWNTO 5);
			WHEN "11100" =>ALUOutput<= a1(3 DOWNTO 0) & a1(31 DOWNTO 4);
			WHEN "11101" =>ALUOutput<= a1(2 DOWNTO 0) & a1(31 DOWNTO 3);
			WHEN "11110" =>ALUOutput<= a1(1 DOWNTO 0) & a1(31 DOWNTO 2);
			WHEN "11111" =>ALUOutput<= a1(0) & a1(31 DOWNTO 1);
			WHEN OTHERS =>ALUOutput<=a1;
			END CASE;
			
	  when x"06" =>
		CASE a2(4 DOWNTO 0) IS
			WHEN "00001"=> ALUOutput<= a1(0) & a1(31 DOWNTO 1);
			WHEN "00010"=> ALUOutput<=a1(1 DOWNTO 0) & a1(31 DOWNTO 2); 
         WHEN "00011"=> ALUOutput<= a1(2 DOWNTO 0) & a1(31 DOWNTO 3);
			WHEN "00100"=> ALUOutput<= a1(3 DOWNTO 0) & a1(31 DOWNTO 4);
			WHEN "00101"=> ALUOutput<= a1(4 DOWNTO 0) & a1(31 DOWNTO 5);
			WHEN "00110"=> ALUOutput<= a1(5 DOWNTO 0) & a1(31 DOWNTO 6);
			WHEN "00111" => ALUOutput<= a1(6 DOWNTO 0) & a1(31 DOWNTO 7);
			WHEN "01000" => ALUOutput<= a1(7 DOWNTO 0) & a1(31 DOWNTO 8);
			WHEN "01001" => ALUOutput<= a1(8 DOWNTO 0) & a1(31 DOWNTO 9);
			WHEN "01010" => ALUOutput<= a1(9 DOWNTO 0) & a1(31 DOWNTO 10);
			WHEN "01011" => ALUOutput<= a1(10 DOWNTO 0) & a1(31 DOWNTO 11);
			WHEN "01100" => ALUOutput<= a1(11 DOWNTO 0) & a1(31 DOWNTO 12);
			WHEN "01101" => ALUOutput<= a1(12 DOWNTO 0) & a1(31 DOWNTO 13);
			WHEN "01110" => ALUOutput<= a1(13 DOWNTO 0) & a1(31 DOWNTO 14);
			WHEN "01111" => ALUOutput<= a1(14 DOWNTO 0) & a1(31 DOWNTO 15);
			WHEN "10000" => ALUOutput<= a1(15 DOWNTO 0) & a1(31 DOWNTO 16);
			WHEN "10001" => ALUOutput<= a1(16 DOWNTO 0) & a1(31 DOWNTO 17);
			WHEN "10010" => ALUOutput<= a1(17 DOWNTO 0) & a1(31 DOWNTO 18);
			WHEN "10011" => ALUOutput<= a1(18 DOWNTO 0) & a1(31 DOWNTO 19);
			WHEN "10100" => ALUOutput<= a1(19 DOWNTO 0) & a1(31 DOWNTO 20);
			WHEN "10101" => ALUOutput<= a1(20 DOWNTO 0) & a1(31 DOWNTO 21);
			WHEN "10110" => ALUOutput<= a1(21 DOWNTO 0) & a1(31 DOWNTO 22);
			WHEN "10111" => ALUOutput<= a1(22 DOWNTO 0) & a1(31 DOWNTO 23);
			WHEN "11000" => ALUOutput<= a1(23 DOWNTO 0) & a1(31 DOWNTO 24);
			WHEN "11001" => ALUOutput<= a1(24 DOWNTO 0) & a1(31 DOWNTO 25);
			WHEN "11010" => ALUOutput<= a1(25 DOWNTO 0) & a1(31 DOWNTO 26);
			WHEN "11011" => ALUOutput<= a1(26 DOWNTO 0) & a1(31 DOWNTO 27);
			WHEN "11100" => ALUOutput<= a1(27 DOWNTO 0) & a1(31 DOWNTO 28);
			WHEN "11101" => ALUOutput<= a1(28 DOWNTO 0) & a1(31 DOWNTO 29);
			WHEN "11110" => ALUOutput<= a1(29 DOWNTO 0) & a1(31 DOWNTO 30);
			WHEN "11111" => ALUOutput<= a1(30 DOWNTO 0) & a1(31);
			WHEN OTHERS => ALUOutput<=a1;
			END CASE;
		when x"07" =>
		  ALUOutput <= a1 + a2;
		when x"08" =>
		  ALUOutput <= a1 + a2;
		when x"09" =>
		  if(a1 < a2) then
		    ALUOutput <= x"00000000";
		  else
		    ALUOutput <= x"ffffffff";
		  end if;
		when x"0A" =>
		  if(a1 = a2) then
		    ALUOutput <= x"00000000";
		  else
		    ALUOutput <= x"ffffffff";	
        end if;			 
	   when x"0B" =>
		  if(a1 = a2) then
		    ALUOutput <= x"ffffffff";
		  else
		    ALUOutput <= x"00000000";	
        end if;			 
		when others =>
		  ALUOutput <= x"FFFFFFFF";
		
	   end case;	
end if;
end process;
		
	ALUResult <= ALUOutput;
	zero<= '1' when ALUOutput = x"00000000" else
	       '0';

end Behavioral;


