----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:02:39 11/12/2016 
-- Design Name: 
-- Module Name:    uProcessor - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uProcessor is
port ( clk, reset : in std_logic
     );
end uProcessor;

architecture Behavioral of uProcessor is

signal pc_out,pc_in,inst_out,out_data,sel_a2,a1,a2,sign_ext,ALU_out,pc_out_plus1,jmp_address,Branch_inst,jmp_branch,Read_data_out : std_logic_vector(31 downto 0);
signal alu_cntrl,des_reg_sel,jmp_sel,branch_sel,mem_read_sel,mem_reg_sel,mem_write,reg_write,zero,branch : std_logic;
signal write_reg : std_logic_vector(4 downto 0);
 COMPONENT ALU
    PORT(
	      Reset : in std_logic;
         a1 : IN  std_logic_vector(31 downto 0);
         a2 : IN  std_logic_vector(31 downto 0);
         ALUFunc : IN  std_logic_vector(5 downto 0);
         ALUOp : IN  std_logic_vector(5 downto 0);
         ALUResult : OUT  std_logic_vector(31 downto 0);
         zero : OUT  std_logic
        );
    END COMPONENT;
	 
    COMPONENT Control_Block
    PORT(
         opcode : IN  std_logic_vector(5 downto 0);
         alu_cntrl : OUT  std_logic;
         des_reg_sel : OUT  std_logic;
         jmp_sel : OUT  std_logic;
         branch_sel : OUT  std_logic;
         mem_read_sel : OUT  std_logic;
         mem_reg_sel : OUT  std_logic;
         mem_write : OUT  std_logic;
			reg_write    : out std_logic
        );
    END COMPONENT;
    
	   COMPONENT DataMemory
    PORT(
	      clk     : IN std_logic;
         Address : IN  std_logic_vector(31 downto 0);
         WriteData : IN  std_logic_vector(31 downto 0);
         MemRead : IN  std_logic;
         MemWrite : IN  std_logic;
         ReadData : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	
    COMPONENT InstructionMemory
    PORT(
         PC : IN  std_logic_vector(31 downto 0);
         instruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
 
    COMPONENT MUX32
    PORT(
         in1 : IN  std_logic_vector(31 downto 0);
         in2 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
	     COMPONENT MUX5
    PORT(
         in1 : IN  std_logic_vector(4 downto 0);
         in2 : IN  std_logic_vector(4 downto 0);
         sel : IN  std_logic;
         output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
	
	 COMPONENT Program_counter
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         pc_out : OUT  std_logic_vector(31 downto 0);
			pc_out_plus1: out std_logic_vector(31 downto 0);
         pc_in : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
	 
	     COMPONENT RegisterMemory
    PORT(
         RegWrite : IN  std_logic;
         clk : IN  std_logic;
         ReadRegister1 : IN  std_logic_vector(4 downto 0);
         ReadRegister2 : IN  std_logic_vector(4 downto 0);
         WriteRegister : IN  std_logic_vector(4 downto 0);
         WriteData : IN  std_logic_vector(31 downto 0);
         ReadData1 : OUT  std_logic_vector(31 downto 0);
         ReadData2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
 
	  COMPONENT SignExtend
    PORT(
         se_in : IN  std_logic_vector(15 downto 0);
         se_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
        
	begin 

u1: Program_counter port map(clk=>clk, reset=>reset, pc_in=>pc_in, pc_out=>pc_out,pc_out_plus1=>pc_out_plus1);
u2: InstructionMemory port map(PC=>pc_out,Instruction=>inst_out);
u3: control_block port map( opcode => inst_out(31 downto 26), alu_cntrl => alu_cntrl, des_reg_sel=>des_reg_sel,
                            jmp_sel=>jmp_sel,branch_sel=>branch_sel,mem_read_sel=>mem_read_sel,mem_reg_sel=>mem_reg_sel,
									  mem_write=>mem_write,reg_write=>reg_write);
u4: MUX5 port map (in1=>inst_out(20 downto 16),in2=>inst_out(15 downto 11),sel=>des_reg_sel,output=>write_reg);
u5: RegisterMemory port map(RegWrite=>reg_write, clk=>clk, ReadRegister1=>inst_out(25 downto 21),ReadRegister2=>inst_out(20 downto 16),
										WriteRegister=>write_reg, WriteData=>out_Data,ReadData1=>a1,ReadData2=>sel_a2);
u6: SignExtend port map( se_in=>inst_out(15 downto 0), se_out=>sign_ext);
u7: MUX32 port map ( in1=>sel_a2,in2=>sign_ext,sel=>alu_cntrl,output=>a2);
u8: ALU port map (Reset=>reset,a1=>a1,a2=>a2,ALUFunc=> inst_out(5 downto 0),ALUOp=>inst_out(31 downto 26),ALUResult=>ALU_out,Zero=>zero);	
u9: DataMemory port map( clk=>clk,address=>ALU_out,WriteData=>sel_a2,MemRead=>mem_read_sel,MemWrite=>mem_write,ReadData=>read_data_out);
u10: MUX32 port map (in1=>ALU_out,in2=>read_data_out,sel=>mem_reg_sel,Output=>out_data);
u11: MUX32 port map(in1=>pc_out_plus1,in2=>branch_inst,sel=>branch,output=>jmp_branch);	
u12: MUX32 port map(in1=>jmp_branch,in2=>jmp_address,sel=>jmp_sel,output=>pc_in);			
jmp_address<= pc_out_plus1(31 downto 26) & inst_out(25 downto 0);
Branch_inst<=pc_out_plus1+inst_out(15 downto 0);
branch<= zero and branch_sel; 

end Behavioral;