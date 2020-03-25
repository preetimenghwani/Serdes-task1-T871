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

ENTITY serdestoptb IS
END serdestoptb;

ARCHITECTURE behavior OF serdestoptb IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT serdestop
		PORT (
			clk_in         : IN std_logic;
			reset_ser      : IN std_logic;
			reset_deser    : IN std_logic;
			depth_sel      : IN std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');
			data_in        : IN std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');
			data_out       : OUT std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');
			clk_out        : OUT std_logic;
			ready_final    : OUT std_logic;
			ser_str        : OUT std_logic
			);
 
 
		END COMPONENT;
 

		--Inputs
		SIGNAL clk_in       : std_logic := '0';
                SIGNAL reset_ser    : std_logic := '0';
		SIGNAL reset_deser  : std_logic := '0';
		SIGNAL depth_sel    : std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');
		SIGNAL data_in      : std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');

		--Outputs
		SIGNAL data_out     : std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');
		SIGNAL clk_out      : std_logic;
		SIGNAL ready_final  : std_logic;
		SIGNAL ser_str      : std_logic;

		CONSTANT clk_in_period : TIME := 3.333 ns;

	BEGIN
		-- Instantiate the Unit Under Test (UUT)
		uut : serdestop
		PORT MAP(
			clk_in        => clk_in, 
			reset_ser     => reset_ser, 
			reset_deser   => reset_deser, 
			depth_sel     => depth_sel, 
			data_in       => data_in, 
			data_out      => data_out, 
			clk_out       => clk_out, 
			ready_final   => ready_final, 
			ser_str       => ser_str
		);

		-- Clock process definitions
		clk_in_serial_process : PROCESS
		BEGIN
			clk_in <= '1';
			WAIT FOR clk_in_period/2;
			clk_in <= '0';
			WAIT FOR clk_in_period/2;
		END PROCESS;
 
		depth_sel <= "000";

		-- Stimulus process
		stim_proc : PROCESS
		BEGIN
			reset_deser <= '1';
			reset_ser <= '1';
 
			WAIT FOR 35ns;
			reset_ser <= '0';
			WAIT FOR 20ns;
			reset_deser <= '0';
			WAIT UNTIL ready_final = '1';
 
			data_in <= "001100000000";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "101011010100";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "111111110100";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "100111110010";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "100011100010";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "011111010010";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "111110101100";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "111111110000";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "111111101111";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "001111111111";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "001100000000";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "001101010111";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "001101110100";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "001100100000";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000011100010";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000001010010";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000010101100";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000011110000";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000011101111";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000011111111";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000000000000";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000001010111";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000001110100";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000000110010";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000011100010";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000001010010";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000010101100";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000011110000";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000011101111";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000011111111";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000000000000";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000001010111";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000001110100";
			WAIT UNTIL rising_edge(clk_out);
			data_in <= "000000110010";
			WAIT UNTIL rising_edge(clk_out);
			WAIT;
		END PROCESS;

END;
