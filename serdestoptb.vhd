--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:53:41 03/21/2020
-- Design Name:   
-- Module Name:   /home/preeti/testtask/serdestoptb.vhd
-- Project Name:  testtask
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: serdestop
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
 
ENTITY serdestoptb IS
END serdestoptb;
 
ARCHITECTURE behavior OF serdestoptb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT serdestop
    port(
         clk_in_final    : IN  std_logic;
			clk_in_parallel : in std_logic;
         reset_ser       : IN  std_logic;
         reset_deser     : IN  std_logic;
         depth_sel       : in std_logic_vector(1 downto 0):=(others=>'0');
         data_in         : IN  std_logic_vector(11 downto 0):=(others=>'0');
         data_out        : OUT  std_logic_vector(11 downto 0):=(others=>'0');
         clk_out_final   : OUT  std_logic;
         ready_final     : OUT  std_logic
        );
	
	 
    END COMPONENT;
    

   --Inputs
   signal clk_in_final : std_logic := '0';
	signal clk_in_parallel: std_logic:='0';
   signal reset_ser : std_logic := '0';
   signal reset_deser : std_logic := '0';
   signal depth_sel : std_logic_vector(1 downto 0):=(others=>'0');
   signal data_in : std_logic_vector(11 downto 0):=(others=>'0');

 	--Outputs
   signal data_out      : std_logic_vector(11 downto 0):=(others=>'0');
   signal clk_out_final : std_logic;
   signal ready_final : std_logic;

   -- Clock period definitions
   constant clk_in_final_period : time :=10 ns;
   --constant clk_out_period : time := 10 ns;
	constant clk_in_parallel_period : time :=120 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: serdestop port MAP (
          clk_in_final => clk_in_final,
			 clk_in_parallel=> clk_in_parallel,
          reset_ser => reset_ser,
          reset_deser => reset_deser,
          depth_sel => depth_sel,
          data_in => data_in,
          data_out => data_out,
          clk_out_final => clk_out_final,
          ready_final => ready_final
        );

   -- Clock process definitions
   clk_in_final_process :process
   begin
		clk_in_final <= '0';
		wait for clk_in_final_period/2;
		clk_in_final <= '1';
		wait for clk_in_final_period/2;
   end process;
	
	clk_in_parallel_process :process
   begin
		clk_in_parallel <= '0';
		wait for clk_in_parallel_period/2;
		clk_in_parallel <= '1';
		wait for clk_in_parallel_period/2;
   end process;
 
 

   -- Stimulus process
   
	
	depth_sel<="00";

  -- Stimulus process
   stim_proc: process
   begin	
		
   reset_deser <= '1';
	reset_ser <= '1';
	
	wait for 35ns;
	reset_ser <= '0';
	wait for 20ns;
	reset_deser <= '0';
	wait until ready_final = '1';
  -- wait for 120ns;
	
 -- DIN1<="111000100000";
  -- wait for 80ns;
	--DIN1<="010100100000";
  -- wait for 80ns;
	--DIN1<="101011000000";
  -- wait for 80ns;
	--DIN1<="001111110000";
 --  wait for 80ns;
	--DIN1<="001111101111";
   --wait for 80ns;
	--DIN1<="001111111111";
   --wait for 80ns;
	data_in<="111100000000";
   wait for 120ns;
	data_in<="111111010111";
   wait for 120ns;
	data_in<="111111110100";
   wait for 120ns;
	data_in<="111111110010";
   wait for 120ns;
	data_in<="111111100010";
   wait for 120ns;
	data_in<="111111010010";
   wait for 120ns;
	data_in<="111110101100";
   wait for 120ns;
	data_in<="111111110000";
   wait for 120ns;
	data_in<="111111101111";
   wait for 120ns;
	data_in<="001111111111";
   wait for 120ns;
	data_in<="001100000000";
   wait for 120ns;
	data_in<="001101010111";
   wait for 120ns;
	data_in<="001101110100";
   wait for 120ns;
	data_in<="001100100000";
   wait for 120ns;
	data_in<="000011100010";
   wait for 120ns;
	data_in<="000001010010";
   wait for 120ns;
	data_in<="000010101100";
   wait for 120ns;
   data_in<="000011110000";
   wait for 120ns;
	data_in<="000011101111";
   wait for 120ns;
	data_in<="000011111111";
   wait for 120ns;
	data_in<="000000000000";
   wait for 120ns;
	data_in<="000001010111";
   wait for 120ns;
	data_in<="000001110100";
   wait for 120ns;
	data_in<="000000110010";
   wait for 120ns;
	data_in<="000011100010";
   wait for 120ns;
	data_in<="000001010010";
   wait for 120ns;
	data_in<="000010101100";
   wait for 120ns;
	data_in<="000011110000";
   wait for 120ns;
	data_in<="000011101111";
   wait for 120ns;
	data_in<="000011111111";
   wait for 100ns;
	data_in<="000000000000";
   wait for 120ns;
	data_in<="000001010111";
   wait for 120ns;
	data_in<="000001110100";
   wait for 100ns;
	data_in<="000000110010";
   wait for 100ns;
     wait;
	end process;

END;
