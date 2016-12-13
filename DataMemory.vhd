----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:10:45 11/28/2016 
-- Design Name: 
-- Module Name:    data_memory - Behavioral 
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataMemory is
  port(
		 clk: in std_logic;
       Address: in std_logic_vector(31 downto 0);
       WriteData: in std_logic_vector(31 downto 0);
		 MemRead: in std_logic; --control signal from Decode Unit, load word
		 MemWrite: in std_logic; --control signal from Decode Unit, store word
		 ReadData: out std_logic_vector(31 downto 0);
		 cyphertext : out std_logic_vector(63 downto 0);
		 plaintext  : out std_logic_vector(63 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is
--create RAM, and initially set them to 0
type RAM_256x32 is array(0 to 63) of std_logic_vector(31 downto 0);--assume starts at 0x000000000
signal DM: RAM_256x32 :=( x"00000010",
x"00000001",
--X"9BBBD8C8",
-- X"1A37F7FB",
-- X"46F8E8C5",
-- X"460C6085",
-- X"70F83B8A",
-- X"284B8303",
-- X"513E1454",
-- X"F621ED22",
-- X"3125065D",
-- X"11A83A5D",
-- X"D427686B",
-- X"713AD82D",
-- X"4B792F99",
-- X"2799A4DD",
-- X"A7901C49",
-- X"DEDE871A",
-- X"36C03196",
-- X"A7EFC249",
-- X"61A78BB8",
-- X"3B0A1D2B",
-- X"4DBFCA76",
-- X"AE162167",
-- X"30D76B0A",
-- X"43192304",
-- X"F6CC1431", 
-- X"65046380",

 X"B7E15163",--1
 X"5618CB1C",--2
 X"F45044D5",--3
 x"9287BE8E",--4
 X"30BF3847",--5
 X"CEF6B200",--6
 X"6D2E2BB9",--7
 X"0B65A572",--8
 X"A99D1F2B",--9
 X"47D498E4",--10
 X"E60C129D",--11
 X"84438C56",--12
 X"227B060F",--13
 X"C0B27FC8",--14
 X"5EE9F981",--15
 X"FD21733A",--16
 X"9B58ECF3",--17
 X"399066AC",--18
 X"D7C7E065",--19
 X"75FF5A1E",--20
 X"1436D3D7",--21
 X"B26E4D90",--22
 X"50A5C749",--23
 X"EEDD3562",--24
 X"8D14BABB",--25
 X"2B4C3474",--26

--"10011011101110111101100011001000",--1
--"00011010001101111111011111111011",--2
--"01000110111110001110100011000101",--3
--"01000110000011000110000010000101",--4
--"01110000111110000011101110001010",--5
--"00101000010010111000001100000011",--6
--"01010001001111100001010001010111",--7
--"11110110001000011110110100100010",--8
--"00110001001001010000011001011101",--9
--"00010001101010000011101001011101",--10
--"11010100001001110110100001101011",--11
--"01110001001110101101100000101101",--12
--"01001011011110010010111110011001",--13
--"00100111100110011010010011011101",--14
--"10100111100100000001110001001001",--15
--"11011110110111101000011100011010",--16
--"00110110110000000011000110010110",--17
--"10100111111011111100001001001001",--18
--"01100001101001111000101110111000",--19
--"00111011000010100001110100101011",--20
--"01001101101111111100101001110110",--21
--"10101110000101100010000101100111",--22
--"00110000110101110110101100001010",--23
--"01000011000110010010001100000100",--24
--"11110110110011000001010000110001",--25
--"01100101000001000110001110000000",--26

                         x"00000000",x"00000000",x"00000000",x"00000000",
                			 x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000"								 
								
							
								 );                     								 

begin

	process(MemWrite,clk)
	begin
		IF(Rising_edge(clk)) THEN
			if(MemWrite='1') then
				DM(conv_integer(Address(5 downto 0))) <= WriteData;
			end if;
		END IF;	 
	end process;

	process(MemRead, DM, Address)
	begin
		if(MemRead='1') then
			ReadData <= DM(conv_integer(Address(5 downto 0)));
		end if;
	end process;
	
	cyphertext <= DM(32)&DM(33);
	plainttext <=DM(34)&DM(35);
	end Behavioral;

