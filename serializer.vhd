  ----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:44:46 03/19/2020 
-- Design Name: 
-- Module Name:    seri - Behavioral 
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

ENTITY serializer IS
	PORT (
		din_ser            : IN  STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');    
		clk_in_ser         : IN  STD_LOGIC;                                                                                 
		ready              : IN  std_logic := '0';                                     
		reset_ser          : IN  STD_LOGIC;                                        
		depth_sel          : IN  std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');     
		dout_ser           : OUT STD_LOGIC;                                       
		clk_out_ser        : OUT std_logic
 
		);
END serializer;
	
	ARCHITECTURE Behavioral OF serializer IS
	
		CONSTANT test_pattern : std_logic_vector (11 DOWNTO 0) := "101110101111";
		SIGNAL sel            : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
		SIGNAL counter        : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
		SIGNAL Din            : std_logic_vector(11 DOWNTO 0);
		SIGNAL bit_depth      : INTEGER;
		SIGNAL clk_out_sig    : std_logic := '0';


	BEGIN
		clk_out_ser <= clk_out_sig;
      clk_out_sig <= not counter(2);
		 
		 
		PROCESS (clk_in_ser, reset_ser)
		BEGIN
			IF (rising_edge(clk_in_ser)) THEN
				IF (reset_ser = '1') THEN
					counter    <=  (OTHERS => '0');
				ELSE
					IF (counter = 11 - bit_depth) THEN
						counter <=  (OTHERS => '0');
					ELSE
						counter <=  counter + 1;
 
					END IF;
				END IF;
			END IF;
      END PROCESS;
	  
	  
 
		bit_depth <=  to_integer(unsigned(depth_sel));
		sel       <=  counter;
		
		
		p_clk_out : PROCESS (clk_out_sig)
		BEGIN
			IF (rising_edge(clk_out_sig)) THEN
				IF (reset_ser = '1') THEN
					din <= "000000000000"; 
				ELSE
					IF (ready = '1') THEN
						din(11 DOWNTO bit_depth) <= din_ser(11 - bit_depth DOWNTO 0);
					ELSE
						din(11 DOWNTO bit_depth) <= test_pattern(11 - bit_depth DOWNTO 0);
					END IF;
				END IF;
			END IF;
		END PROCESS;
	
	
		
		PROCESS (DIN, sel)
			BEGIN
				CASE sel IS
					WHEN"0000" => dout_ser <= DIN(11);
					WHEN"0001" => dout_ser <= DIN(10);
					WHEN"0010" => dout_ser <= DIN(9);
					WHEN"0011" => dout_ser <= DIN(8);
					WHEN"0100" => dout_ser <= DIN(7);
					WHEN"0101" => dout_ser <= DIN(6);
					WHEN"0110" => dout_ser <= DIN(5);
					WHEN"0111" => dout_ser <= DIN(4);
					WHEN"1000" => dout_ser <= DIN(3);
					WHEN"1001" => dout_ser <= DIN(2);
					WHEN"1010" => dout_ser <= DIN(1);
					WHEN"1011" => dout_ser <= DIN(0);
					WHEN OTHERS => 
						dout_ser <= '0';
				END CASE;
			END PROCESS;
			
	
	
END behavioral;
