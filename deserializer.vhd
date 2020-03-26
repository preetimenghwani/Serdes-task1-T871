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
		clk_out_deser      : out std_logic := '0';
		link_trained       : OUT std_logic := '0';
		debug1             : out std_logic_vector(11 downto 0);
		debug2             : out std_logic_vector(3 downto 0);
		debug3             : out std_logic_vector(11 downto 0);
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
		signal clk_out_sig_del : std_logic;

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
							IF counter_bit = "01" AND counter = "0011" THEN
								IF Dout2(11 - bit_depth DOWNTO 0) = test_pattern(11 - bit_depth DOWNTO 0) THEN
									linked <= '1';
 
								ELSE
									linked <= linked;
 
								END IF;
								counter <= counter + '1';
 
							ELSIF counter_bit = "11" AND counter = "0011" THEN
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
		--debug<= dout2;
      
		
--   dout <=  (din_deser & dout(10 downto 0))  when (sel="0000") else
--            (dout(11) & din_deser & dout(9 downto 0)) when (sel="0001") else
--            (dout(11 downto 10) & din_deser & dout(8 downto 0)) when (sel="0010") else
--            (dout(11 downto 9) & din_deser & dout(7 downto 0)) when (sel="0011") else
--            (dout(11 downto 8) & din_deser & dout(6 downto 0)) when (sel="0100") else
--            (dout(11 downto 7) & din_deser & dout(5 downto 0)) when (sel="0101") else
--            (dout(11 downto 6) & din_deser & dout(4 downto 0)) when (sel="0110") else
--            (dout(11 downto 5) & din_deser & dout(3 downto 0)) when (sel="0111") else
--            (dout(11 downto 4) & din_deser & dout(2 downto 0)) when (sel="1000") else
--            (dout(11 downto 3) & din_deser & dout(1 downto 0)) when (sel="1001") else
--            (dout(11 downto 2) & din_deser & dout(0)) when (sel="1010") else
--            (dout(11 downto 1) & din_deser) when (sel="1011") else (others => '0');
                
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
			
			--clk_out_deser<=clk_out_sig_del;
			

         --clk_out_sig_del <= (not (not( not (not clk_out_sig))));
	
			process (clk_in_deser)
         begin
         if rising_edge(clk_in_deser)	then
			    if (reset_deser = '1') then
				     clk_out_sig <= '0';
				 
				 else
				     if (counter = "1011" - depth_sel ) then
		               clk_out_sig <= '1';
					  	
					  elsif (counter = "0101" - depth_sel(2 downto 1)) then
		               clk_out_sig <= '0';
					  
					  end if;
				 end if;
			end if;
		end process;
		
		 clk_out_deser <= clk_out_sig_del;
	      process(clk_in_deser)
			begin
			if rising_edge(clk_in_deser) then
				if clk_out_sig = '1' then
				clk_out_sig_del <= '1';
				elsif clk_out_sig = '0' then 
				clk_out_sig_del <= '0';
				end if;
			end if;
			end process;


		
        
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
			debug1<=dout2;
			debug2<=counter;
			debug3<=dout;

 
			finalout : PROCESS (dout2, linked)
			BEGIN
				IF (linked = '0') THEN
					dout_deser <= (OTHERS => '0');
				ELSE
					dout_deser <= dout2;
				END IF;
			END PROCESS;
END Behavioral;