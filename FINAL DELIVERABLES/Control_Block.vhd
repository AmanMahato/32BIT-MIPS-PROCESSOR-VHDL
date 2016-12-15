----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:45:46 12/03/2016 
-- Design Name: 
-- Module Name:    Control_Block - Behavioral 
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

entity Control_Block is
port ( opcode : in std_logic_vector(5 downto 0);
       alu_cntrl : out std_logic;
		 des_reg_sel : out std_logic;
		 jmp_sel : out std_logic;
		 branch_sel: out std_logic;
		 mem_read_sel : out std_logic;
		 mem_reg_sel  : out std_logic;
		 mem_write    : out std_logic;
		 reg_write    : out std_logic;
		 halt         : out std_logic
		 		 );
end Control_Block;

architecture RTL of Control_Block is
signal y : integer;
signal halt1,reg_write1,alu_cntrl1,des_reg_sel1,jmp_sel1,branch_sel1,mem_read_sel1,mem_reg_sel1,mem_write1 : std_logic:='0';
begin
process(opcode,y)
begin
y<= conv_integer(opcode);
case y is 
when 0 => halt1<='0';reg_write1<='1'; des_reg_sel1 <= '1'; ALU_cntrl1 <= '0'; mem_read_sel1 <= '0'; mem_reg_sel1 <= '0'; mem_write1 <= '0'; branch_sel1 <= '0'; jmp_sel1 <= '0'; 
when 1 to 6 => halt1<='0';reg_write1<='1';des_reg_sel1 <= '0'; ALU_cntrl1 <= '1'; mem_read_sel1 <= '0'; mem_reg_sel1 <= '0'; mem_write1 <= '0'; branch_sel1 <= '0'; jmp_sel1 <= '0';
when 7 => halt1<='0';reg_write1<='1';mem_read_sel1 <= '1'; mem_reg_sel1 <= '1';des_reg_sel1 <= '0'; ALU_cntrl1 <= '1'; mem_write1 <= '0'; branch_sel1 <= '0'; jmp_sel1 <= '0';
when 8 => halt1<='0';reg_write1<='0';mem_write1 <= '1'; ALU_cntrl1 <= '1';des_reg_sel1<='0'; mem_read_sel1 <= '0'; mem_reg_sel1 <= '0'; branch_sel1 <= '0'; jmp_sel1 <= '0';
when 9 to 11 => halt1<='0';reg_write1<='0';branch_sel1 <= '1'; ALU_cntrl1 <= '0'; mem_read_sel1 <= '0'; mem_reg_sel1 <= '0'; mem_write1 <= '0'; jmp_sel1 <= '0'; des_reg_sel1 <= '0';
when 12 => halt1<='0';reg_write1<='0';jmp_sel1 <= '1'; ALU_cntrl1 <= '0'; mem_read_sel1 <= '0'; mem_reg_sel1 <= '0'; mem_write1 <= '0'; branch_sel1 <= '0';des_reg_sel1 <= '0';
when 63 => halt1<='1';reg_write1<='0';jmp_sel1 <= '0'; ALU_cntrl1 <= '0'; mem_read_sel1 <= '0'; mem_reg_sel1 <= '0'; mem_write1 <= '0'; branch_sel1 <= '0';des_reg_sel1 <= '0'; 
when others => halt1<='0';reg_write1<='0';ALU_cntrl1 <= '0'; mem_read_sel1 <= '0'; mem_reg_sel1 <= '0'; mem_write1 <= '0'; branch_sel1 <= '0'; jmp_sel1 <= '0';des_reg_sel1 <= '0';
end case;
end process;
alu_cntrl<=alu_cntrl1;
des_reg_sel<=des_reg_sel1;
jmp_sel<=jmp_sel1;
branch_sel<=branch_sel1;
mem_read_sel<=mem_read_sel1;
mem_reg_sel<=mem_reg_sel1;
mem_write<=mem_write1;
reg_write<=reg_write1;
halt<=halt1;
end RTL;

