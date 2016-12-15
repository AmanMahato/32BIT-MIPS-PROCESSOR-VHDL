----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:34:36 12/05/2016 
-- Design Name: 
-- Module Name:    RegisterMemory - Behavioral 
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY RegisterMemory IS
 PORT  (RegWrite: IN STD_LOGIC;
 clk: IN STD_LOGIC;
ReadRegister1: IN STD_LOGIC_VECTOR(4 DOWNTO 0); 
ReadRegister2: IN STD_LOGIC_VECTOR(4 DOWNTO 0); 
WriteRegister: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
WriteData: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
ReadData1: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
ReadData2: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)); 
END RegisterMemory;

ARCHITECTURE RTL OF RegisterMemory IS

TYPE ram IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
Signal registers: ram :=(x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
                         x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000",
								 x"00000000",x"00000000",x"00000000",x"00000000");
BEGIN 

PROCESS(clk, RegWrite)  
BEGIN
IF(rising_edge(clk))  THEN 
   if (RegWrite ='1') then registers(CONV_INTEGER(WriteRegister)) <= WriteData; end if;
	
END IF; 
END PROCESS;

ReadData1<=registers(CONV_INTEGER(ReadRegister1));
ReadData2<=registers(CONV_INTEGER(ReadRegister2));

END RTL;