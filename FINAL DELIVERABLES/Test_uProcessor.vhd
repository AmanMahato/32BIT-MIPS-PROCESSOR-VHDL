--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:26:57 12/13/2016
-- Design Name:   
-- Module Name:   D:/SEM 2/AHD/Assignments/Assignment 4/LAB_4__mg5127_VHDL Codes/LAB_4_mg5127_Codes/Push_button/Test_uProcessor.vhd
-- Project Name:  Push_Button
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: uProcessor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test_uProcessor IS
END Test_uProcessor;
 
ARCHITECTURE behavior OF Test_uProcessor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT uProcessor
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         out_cyphertext : OUT  std_logic_vector(63 downto 0);
         out_plaintext : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal out_cyphertext : std_logic_vector(63 downto 0);
   signal out_plaintext : std_logic_vector(63 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: uProcessor PORT MAP (
          clk => clk,
          reset => reset,
          out_cyphertext => out_cyphertext,
          out_plaintext => out_plaintext
        );

   -- Clock process definitions
 

   -- Stimulus process
 process
   begin
     clk<='0';	
          wait for 5 ns;	
    clk<='1';
      wait for 5 ns;
		end process;

      -- insert stimulus here 
process
begin
  reset<= '1';
  wait for 10 ns;
  reset<= '0';
      wait;
   end process;

END;
