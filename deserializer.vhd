----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:01:27 03/26/2020 
-- Design Name: 
-- Module Name:    deserializer - Behavioral 
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY deserializer IS
	PORT (
		clk_in_deser  : IN std_logic := '0';
		reset_deser   : IN std_logic := '0';
		din_deser     : IN std_logic := '0';
		depth_sel     : IN std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');
		clk_out_deser : OUT std_logic := '0';
		link_trained  : OUT std_logic := '0';                                  --assigned '1' when bit slip is adjusted
		dout_deser    : OUT std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');
		);
	END deserializer;

	ARCHITECTURE behavioral OF deserializer IS

		SIGNAL dout              : std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');
		SIGNAL dout2             : std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');
		SIGNAL counter           : std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');
		SIGNAL sel               : std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');
		SIGNAL counter_bit       : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
		SIGNAL linked            : std_logic := '0';
		SIGNAL clk_out_sig       : std_logic := '0';
		SIGNAL bit_depth         : INTEGER;
		SIGNAL clk_out_sig_del   : std_logic;
		SIGNAL ddr               : std_logic_vector(1 DOWNTO 0);        
		SIGNAL ddr0              : std_logic;
		SIGNAL din               : std_logic_vector(1 DOWNTO 0);
		CONSTANT test_pattern    : std_logic_vector (11 DOWNTO 0) := "101110101111";

	BEGIN
		link_trained <= linked;
------------------------------------------------------------------------		
-- DDR implementation using flip flops and latches with reset		
--------------------------------------------------------------------------
 
		ddr0 <= din_deser WHEN clk_in_deser = '0';
		ddr(1) <= din_deser WHEN falling_edge(clk_in_deser);
		ddr(0) <= ddr0 WHEN falling_edge(clk_in_deser);
		din <= ddr(0) & ddr(1);
		
--------------------------------------------------------------------------
--	bitslip_proc: Adjusts the bitslip for link training 
---------------------------------------------------------------------------	
		bitslip_proc : PROCESS (clk_in_deser)
		BEGIN
			IF rising_edge(clk_in_deser) THEN

				IF reset_deser = '1' THEN
					counter <= "000";
					linked <= '0';
				ELSE
					IF counter = 5 - bit_depth/2 THEN
						counter <= "000";
					ELSE
						IF linked = '1' THEN
							counter <= counter + 1;
						ELSE
							IF counter_bit = "01" AND counter = "011" THEN
								IF dout2(11 - bit_depth DOWNTO 0) = test_pattern(11 - bit_depth DOWNTO 0) THEN
									linked <= '1';

								ELSE
									linked <= linked;

								END IF;
								counter <= counter + '1';

							ELSIF counter_bit = "11" AND counter = "011" THEN
								counter <= counter + 2;

							ELSE
								counter <= counter + '1';
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;
		END PROCESS;
		
----------------------------------------------------------------------------------------------------------		
--newcounter_proc: for making a new counter which is used for checking whether link is trained or not
----------------------------------------------------------------------------------------------------------

		newcounter_proc : PROCESS (counter, clk_in_deser)
		BEGIN
			IF rising_edge(clk_in_deser) THEN
				IF (counter = 5 - bit_depth/2) THEN
					counter_bit <= counter_bit + 1;
				END IF;
			END IF;
		END PROCESS;

		bit_depth <= to_integer(unsigned(depth_sel));

 
		sel <= counter;
		
		PROCESS (clk_in_deser)
			BEGIN
				IF (rising_edge(clk_in_deser)) THEN
					IF (reset_deser = '1') THEN
						dout <= "000000000000";
					ELSE
						IF (sel = "000") THEN
							dout(11 DOWNTO 10) <= din;
						ELSIF (sel = "001") THEN
							dout(9 DOWNTO 8) <= (din);
						ELSIF (sel = "010") THEN
							dout(7 DOWNTO 6) <= (din);
						ELSIF (sel = "011") THEN
							dout(5 DOWNTO 4) <= din;
						ELSIF (sel = "100") THEN
							dout(3 DOWNTO 2) <= din;
						ELSIF (sel = "101") THEN
							dout(1 DOWNTO 0) <= din;
						END IF;
					END IF;
				END IF;
			END PROCESS;

			clk_out_deser <= clk_out_sig_del;
---------------------------------------------------------------------------			
-- process for making a delayed clock signal for output data sampling
----------------------------------------------------------------------------
			PROCESS (clk_in_deser)
				BEGIN
					IF rising_edge(clk_in_deser) THEN
						IF clk_out_sig = '1' THEN
							clk_out_sig_del <= '1';
						ELSIF clk_out_sig = '0' THEN
							clk_out_sig_del <= '0';
						END IF;
					END IF;
				END PROCESS;

--
				PROCESS (clk_in_deser)
					BEGIN
						IF rising_edge(clk_in_deser) THEN
							IF (reset_deser = '1') THEN
								clk_out_sig <= '0';
 
							ELSE
								IF (counter = "101" - depth_sel(2 DOWNTO 1)) THEN
									clk_out_sig <= '1';
 
								ELSIF (counter = "011" - depth_sel(2)) THEN
									clk_out_sig <= '0';
 
								END IF;
							END IF;
						END IF;
					END PROCESS;
----------------------------------------------------------------------------					
-- sampling of output data
----------------------------------------------------------------------------

					p_clk_out : PROCESS (clk_out_sig_del)
					BEGIN
						IF (rising_edge(clk_out_sig_del)) THEN
							IF (reset_deser = '1') THEN
								dout2 <= (OTHERS => '0');
							ELSE
								dout2(11 - bit_depth DOWNTO 0) <= dout(11 DOWNTO bit_depth);
							END IF;
						END IF;
					END PROCESS;
					
					finalout : PROCESS (dout2, linked)
					BEGIN
						IF (linked = '0') THEN
							dout_deser <= (OTHERS => '0');
						ELSE
							dout_deser <= dout2;
						END IF;
					END PROCESS;
					
END behavioral;
