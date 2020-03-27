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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity serdestoptb is
end serdestoptb;

architecture behavior of serdestoptb is
		
	signal depth_sel           : std_logic_vector(2 downto 0) := (others => '0');
        constant clk_in_ser_period : time := 3.3333 ns;
	signal clk_in_ser          : std_logic := '0';
        signal clk_in_ser_90       : std_logic := '0';
        signal reset_ser           : std_logic := '0';
	signal reset_deser         : std_logic := '0';
	signal clk_out_ser         : std_logic:='0';
	signal din_ser     	   : std_logic_vector(11 downto 0) := (others => '0');
	signal dout_deser          : std_logic_vector(11 downto 0):= (others => '0');
	signal din_deser       	   : std_logic :='0';
	signal ready               : std_logic:='0';
	
	constant test_pattern      : std_logic_vector (11 downto 0) := "101110101111";
	signal sel                 : std_logic_vector(3 downto 0) := (others => '0');
	signal counter             : std_logic_vector(2 downto 0) := (others => '0');
	signal din                 : std_logic_vector(11 downto 0) :=(others => '0');
	signal bit_depth           : integer;
	signal clk_out_deser       : std_logic:='0';

    component deserializer 
    port(
          clk_in_deser 	     : in  std_logic:='0';
          reset_deser        : in  std_logic:='0';
          din_deser 	     : in  std_logic:='0';
	  depth_sel          : in  std_logic_vector(2 downto 0):=(others=>'0');
          clk_out_deser      : out std_logic:='0';
	  link_trained       : out std_logic:='0';
          dout_deser         : out std_logic_vector(11 downto 0):=(others=>'0')
			);
    end component;
	 
--instantiate the unit under test(uut) : deserializer

deser_inst: deserializer
port map(
	  clk_in_deser  => clk_in_ser_90,
	  reset_deser   => reset_deser,
	  din_deser     => din_deser,
	  depth_sel     => depth_sel,
	  clk_out_deser => clk_out_deser,
	  link_trained  => ready,
	  dout_deser    => dout_deser
	 );
	 
begin
-----------------------------------------------------------------------
		-- clock process definitions
		--clk_in_ser_90 : 90 degree shifted clock for implementing ddr 
----------------------------------------------------------------------		
		
 clk_in_serial_process : process
 	begin
	   clk_in_ser_90 <= '0';
	   clk_in_ser <= '1';
	   wait for clk_in_ser_period/2;
	   clk_in_ser <= '0';
	   clk_in_ser_90 <= '1';
	   wait for clk_in_ser_period/2;
	end process;

		
	depth_sel <= "000";

	-- stimulus process
		
stim_proc : process
	begin
		reset_deser <= '1';
		reset_ser <= '1';
 
		wait for 35ns;
		reset_ser <= '0';
		wait for 20ns;
		reset_deser <= '0';		
		wait until ready = '1';
		wait until rising_edge(clk_out_ser); 
		din_ser <= "001100000000";
		wait until rising_edge(clk_out_ser);
		din_ser <= "101011010100";
		wait until rising_edge(clk_out_ser);
		din_ser <= "111111110100";
		wait until rising_edge(clk_out_ser);
		din_ser <= "100111110010";
		wait until rising_edge(clk_out_ser);
		din_ser <= "100011100010";
		wait until rising_edge(clk_out_ser);
		din_ser <= "011111010010";
		wait until rising_edge(clk_out_ser);
		din_ser <= "111110101100";
		wait until rising_edge(clk_out_ser);
		din_ser <= "111111110000";
		wait until rising_edge(clk_out_ser);
		din_ser <= "111111101111";
		wait until rising_edge(clk_out_ser);
		din_ser <= "001111111111";
		wait until rising_edge(clk_out_ser);
		din_ser <= "001100000000";
		wait until rising_edge(clk_out_ser);
		din_ser <= "001101010111";
		wait until rising_edge(clk_out_ser);
		din_ser <= "001101110100";
		wait until rising_edge(clk_out_ser);
		din_ser <= "001100100000";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000011100010";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000001010010";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000010101100";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000011110000";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000011101111";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000011111111";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000000000000";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000001010111";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000001110100";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000000110010";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000011100010";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000001010010";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000010101100";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000011110000";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000011101111";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000011111111";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000000000000";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000001010111";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000001110100";
		wait until rising_edge(clk_out_ser);
		din_ser <= "000000110010";
		wait until rising_edge(clk_out_ser);
		wait;
	end process;

----------------------------------------------------------------------
--serializer for testing deserializer
----------------------------------------------------------------------	
		      
PROCESS (clk_in_ser)
      BEGIN
	IF rising_edge(clk_in_ser) THEN
		IF (reset_ser = '1') THEN
			clk_out_ser <= '0'; 
		ELSE
			IF (counter = "101" - depth_sel(2 DOWNTO 1)) THEN
				clk_out_ser <= '1';
 
			ELSIF (counter = "011" - depth_sel(2 DOWNTO 1)) THEN
				clk_out_ser <= '0';
 
			END IF;
		END IF;
	END IF;
END PROCESS;
 
PROCESS (clk_in_ser, reset_ser)
BEGIN
	IF (rising_edge(clk_in_ser)) THEN
		IF (reset_ser = '1') THEN
			counter <= (OTHERS => '0');
		ELSE
			IF (counter = 5 - bit_depth/2) THEN
				counter <= (OTHERS => '0');
			ELSE
				counter <= counter + 1;

			END IF;
		END IF;
	END IF;
END PROCESS;
 
 

bit_depth <= to_integer(unsigned(depth_sel));
sel <= counter & (NOT clk_in_ser);
 
---------------------------------------------------------------------------------------
--p_clk_out process for assigning input data as test pattern when link is not trained 
---------------------------------------------------------------------------------------
 
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
--------------------------------------------------------------------------- 
--process for samling output of serializer using a dmux
---------------------------------------------------------------------------
 
PROCESS (sel, din)
	BEGIN
		CASE sel IS
			WHEN"0000" => din_deser <= din(11);
			WHEN"0001" => din_deser <= din(10);
			WHEN"0010" => din_deser <= din(9);
			WHEN"0011" => din_deser <= din(8);
			WHEN"0100" => din_deser <= din(7);
			WHEN"0101" => din_deser <= din(6);
			WHEN"0110" => din_deser <= din(5);
			WHEN"0111" => din_deser <= din(4);
			WHEN"1000" => din_deser <= din(3);
			WHEN"1001" => din_deser <= din(2);
			WHEN"1010" => din_deser <= din(1);
			WHEN"1011" => din_deser <= din(0);
			WHEN OTHERS => 
				din_deser <= '0';
		END CASE;
	END PROCESS;
END;
