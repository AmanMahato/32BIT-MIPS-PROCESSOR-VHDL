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
		 ReadData: out std_logic_vector(31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is
--create RAM, and initially set them to 0
type RAM_128x32 is array(0 to 127) of std_logic_vector(31 downto 0);--assume starts at 0x000000000
signal DM: RAM_128x32 :=( x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 
								 x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 
								 x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
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
				DM(conv_integer(Address)) <= WriteData;
			end if;
		END IF;	 
	end process;

	process(MemRead, DM, Address)
	begin
		if(MemRead='1') then
			ReadData <= DM(conv_integer(Address));
		end if;
	end process;
	
end Behavioral;

