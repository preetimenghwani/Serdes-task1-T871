--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:03:04 03/26/2020
-- Design Name:   
-- Module Name:   /home/preeti/pm/final/testbench.vhd
-- Project Name:  final
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
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY serdestoptb IS
END serdestoptb;

ARCHITECTURE behavior OF serdestoptb IS

 

		--Inputs
      
		
		SIGNAL depth_sel           : std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');

		--Outputs
		CONSTANT clk_in_ser_period : TIME := 3.33 ns;
		
      signal clk_in_ser          : std_logic := '0';
		SIGNAL reset_ser           : std_logic := '0';
		SIGNAL reset_deser         : std_logic := '0';
	   signal clk_out_ser         : std_logic:='0';
		signal din_ser     	      : std_logic_vector(11 downto 0) := (others => '0');
		signal dout_deser          : std_logic_vector(11 downto 0):= (others => '0');
	   signal DIN_deser       	   : std_logic :='0';
	   signal ready               : std_logic:='0';
		signal debug1              : std_logic_vector(11 downto 0);
		signal debug2              : std_logic_vector(3 downto 0);
		signal debug3              : std_logic_vector(11 downto 0);
	
		CONSTANT test_pattern : std_logic_vector (11 DOWNTO 0) := "101110101111";
		SIGNAL sel            : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
		SIGNAL counter        : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
		SIGNAL Din            : std_logic_vector(11 DOWNTO 0) :=(others => '0');
		SIGNAL bit_depth      : INTEGER;
		--signal debug          : std_logic_vector(11 downto 0);
	   signal clk_out_deser  : std_logic:='0';

	 COMPONENT deserializer 
    port(
         clk_in_deser 	     : IN  std_logic:='0';
         reset_deser         : IN  std_logic:='0';
         DIN_deser 	        : IN  std_logic:='0';
	      depth_sel           : in  std_logic_vector(2 downto 0):=(others=>'0');
         clk_out_deser       : out std_logic:='0';
	      link_trained        : out std_logic:='0';
			debug1              : out std_logic_vector(11 downto 0);
			debug2              : out std_logic_vector(3 downto 0);
			debug3              : out std_logic_vector(11 downto 0);
         dout_deser          : out std_logic_vector(11 downto 0):=(others=>'0')
			);
    END COMPONENT;
	 
	BEGIN

		-- Clock process definitions
		clk_in_serial_process : PROCESS
		BEGIN
			clk_in_ser <= '1';
			WAIT FOR clk_in_ser_period/2;
			clk_in_ser <= '0';
			WAIT FOR clk_in_ser_period/2;
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
			
			WAIT UNTIL ready = '1';
			WAIT UNTIL rising_edge(clk_out_ser); 
			din_ser <= "001100000000";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "101011010100";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "111111110100";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "100111110010";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "100011100010";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "011111010010";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "111110101100";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "111111110000";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "111111101111";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "001111111111";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "001100000000";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "001101010111";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "001101110100";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "001100100000";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000011100010";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000001010010";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000010101100";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000011110000";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000011101111";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000011111111";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000000000000";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000001010111";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000001110100";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000000110010";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000011100010";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000001010010";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000010101100";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000011110000";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000011101111";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000011111111";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000000000000";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000001010111";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000001110100";
			WAIT UNTIL rising_edge(clk_out_ser);
			din_ser <= "000000110010";
			WAIT UNTIL rising_edge(clk_out_ser);
			WAIT;
		END PROCESS;


----------------------------------------------------------------------
 		
		
      
		process (clk_in_ser)
      begin
         if rising_edge(clk_in_ser)	then
			    if (reset_ser = '1') then
				     clk_out_ser <= '0';
				 
				 else
				     if (counter = "1011" - depth_sel ) then
		               clk_out_ser <= '1';
							
					  elsif (counter = "0101" - depth_sel(2 downto 1)) then
		               clk_out_ser <= '0';
					  
					  end if;
				 end if;
			end if;
		end process;
		 
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
		
		
		p_clk_out : PROCESS (clk_out_ser)
		BEGIN
			IF (rising_edge(clk_out_ser)) THEN
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
	
	
		
		PROCESS (clk_in_ser)
			BEGIN
			if rising_edge(clk_in_ser) then
				if reset_ser = '1' then
				   din_deser <= '0';
				
				else
					CASE sel IS
						WHEN"0000" => din_deser <= DIN(11);
						WHEN"0001" => din_deser <= DIN(10);
						WHEN"0010" => din_deser <= DIN(9);
						WHEN"0011" => din_deser <= DIN(8);
						WHEN"0100" => din_deser <= DIN(7);
						WHEN"0101" => din_deser <= DIN(6);
						WHEN"0110" => din_deser <= DIN(5);
						WHEN"0111" => din_deser <= DIN(4);
						WHEN"1000" => din_deser <= DIN(3);
						WHEN"1001" => din_deser <= DIN(2);
						WHEN"1010" => din_deser <= DIN(1);
						WHEN"1011" => din_deser <= DIN(0);
						WHEN OTHERS => 
							din_deser <= '0';
					END CASE;
				end if;
			end if;
		END PROCESS;

deser_inst: deserializer
port map(
			clk_in_deser  => clk_in_ser,
			reset_deser   => reset_deser,
			din_deser     => din_deser,
			depth_sel     => depth_sel,
			clk_out_deser => clk_out_deser,
			link_trained  => ready,
			debug1        => debug1,
			debug2        => debug2,
			debug3        =>  debug3,
			dout_deser    => dout_deser
			);

			


END;