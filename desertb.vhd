--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:58:30 03/10/2020
-- Design Name:   
-- Module Name:   /home/preeti/serdestask/desertb.vhd
-- Project Name:  serdestask
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: deserializer
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
use ieee.std_logic_unsigned.all;

ENTITY serealtb IS
END serealtb;


 
ARCHITECTURE behavior OF serealtb IS 

 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT serealisercomb
    PORT(
         DIN1 : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         DOUT1 : OUT  std_logic
			
        );
    END COMPONENT;
	 
	 COMPONENT deserializer 
    PORT(
         clk 	: IN  std_logic;
         reset : IN  std_logic;
         DIN2 	: IN  std_logic;
         DOUT2 : OUT  std_logic_vector(7 downto 0)
			

			
        );
    END COMPONENT;
    

   --Inputs
   signal DIN1   	: std_logic_vector(7 downto 0) := (others => '0');
   signal clk    	: std_logic := '0';
   signal reset  	: std_logic := '0';
	signal DIN2   	: std_logic :='0';

 	--Outputs
   signal DOUT1 : std_logic;
	signal DOUT2 : std_logic_vector(7 downto 0);
	
	

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: serealisercomb PORT MAP (
          DIN1 => DIN1,
          clk => clk,
          reset => reset,
          DOUT1 => DOUT1

        );
		  
   uut2: deserializer PORT MAP (
          clk => clk,
          reset => reset,
          DIN2 => DIN2,
          DOUT2 => DOUT2
			
 			 );
   -- Clock process definitions
	din2<=dout1;
		
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

  -- Stimulus process
   stim_proc: process
   begin		
   reset <= '1';
	wait for 10ns;
	reset <= '0';
	DIN1<= "11001001";  
     wait; 
	end process;
	
	
END;
 

 
    
 
    

