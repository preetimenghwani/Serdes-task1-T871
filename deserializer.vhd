----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:43:52 03/19/2020 
-- Design Name: 
-- Module Name:    deser - Behavioral 
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
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY deserializer IS
	PORT (
		clk_in_deser       : IN std_logic := '0';
		reset_deser        : IN std_logic := '0';
		din_deser          : IN std_logic := '0';
		depth_sel          : IN std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');
		clk_out_deser      : OUT std_logic := '0';
		link_trained       : OUT std_logic := '0';
		dout_deser         : OUT std_logic_vector(11 DOWNTO 0) := (OTHERS => '0')
		);
	END deserializer;

	ARCHITECTURE Behavioral OF deserializer IS

		SIGNAL DOUT            : std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');
		SIGNAL DOUT2           : std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');
		SIGNAL counter         : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
		SIGNAL sel             : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
		SIGNAL counter_bit     : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
		SIGNAL linked          : std_logic := '0';
		SIGNAL clk_out_sig     : std_logic := '0';
		CONSTANT test_pattern  : std_logic_vector (11 DOWNTO 0) := "101110101111";
		SIGNAL bit_depth       : INTEGER;

	BEGIN
		link_trained <= linked;

		bitslip_proc : PROCESS (clk_in_deser)
		BEGIN
			IF rising_edge(clk_in_deser) THEN

				IF reset_deser = '1' THEN
					counter <= "0000";
					linked <= '0';
				ELSE
					IF counter = 11 - bit_depth THEN
						counter <= "0000";
					ELSE
						IF linked = '1' THEN
							counter <= counter + 1;
						ELSE
							IF counter_bit = "01" AND counter = "0000" THEN
								IF Dout2(11 - bit_depth DOWNTO 0) = test_pattern(11 - bit_depth DOWNTO 0) THEN
									linked <= '1';
 
								ELSE
									linked <= linked;
 
								END IF;
								counter <= counter + '1';
 
							ELSIF counter_bit = "11" AND counter = "0001" THEN
								counter <= counter + 2; 
 
							ELSE
								counter <= counter + '1';
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;
		END PROCESS;
 
		newcounter_proc : PROCESS (counter, clk_in_deser)
		BEGIN
			IF rising_edge(clk_in_deser) THEN
				IF (counter = "0111") THEN
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
						IF (sel = "0000") THEN
							dout(11) <= din_deser;
						ELSIF (sel = "0001") THEN
							dout(10) <= (DIN_deser);
						ELSIF (sel = "0010") THEN
							dout(9) <= (DIN_deser);
						ELSIF (sel = "0011") THEN
							dout(8) <= din_deser;
						ELSIF (sel = "0100") THEN
							dout(7) <= din_deser;
						ELSIF (sel = "0101") THEN
							dout(6) <= din_deser;
						ELSIF (sel = "0110") THEN
							dout(5) <= din_deser;
						ELSIF (sel = "0111") THEN
							dout(4) <= din_deser;
						ELSIF (sel = "1000") THEN
							dout(3) <= din_deser;
						ELSIF (sel = "1001") THEN
							dout(2) <= din_deser;
						ELSIF (sel = "1010") THEN
							dout(1) <= din_deser;
						ELSIF (sel = "1011") THEN
							dout(0) <= din_deser;
						END IF;
					END IF;
				END IF;
			END PROCESS;

 
 
 
			clk_out_deser <= NOT counter(2);
			clk_out_sig <= NOT counter(2);

			p_clk_out : PROCESS (clk_out_sig)
			BEGIN
				IF (rising_edge(clk_out_sig)) THEN
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
 
END Behavioral;
