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
use ieee.numeric_std.all;



ENTITY serealisercomb IS
    port (
        din_ser    : IN STD_LOGIC_VECTOR(11 DOWNTO 0):=(others=>'0'); --input to serializer
        clk        : IN STD_LOGIC;                     --high speed input clocl
		  clk_in     : in std_logic;                     --low speed input clock 
        reset_ser  : IN STD_LOGIC;                     --reset signal for serializer
		  depth_sel  : in std_logic_vector(1 downto 0):=(others=>'0');                          --for selecting bit depth depth_sel 4=> 8 bit ,2=> 10 bit, 0=> 12 bit                        
        dout_ser   : OUT STD_LOGIC;                    --output of serializer
        ready      : in std_logic :='0'                -- Link trained input from Deserializer
        
    );
END serealisercomb;
ARCHITECTURE Behavioral OF serealisercomb IS

    SIGNAL sel        : std_logic_vector(3 DOWNTO 0):=(others=>'0');
    SIGNAL counter    : std_logic_vector(3 DOWNTO 0):=(others=>'0');
    --SIGNAL clk_out : std_logic;
    SIGNAL Din       : std_logic_vector(11 DOWNTO 0);
	 signal bit_depth : integer;
    --signal linked_buf : std_logic := '0';
    --SIGNAL sync_rst : std_logic := '0';
    CONSTANT test_pattern : std_logic_vector (11 DOWNTO 0) := "101011001111";
	 --signal depth_sel: integer;
  

BEGIN

    PROCESS (clk, reset_ser)
    BEGIN
        if (rising_edge(clk)) THEN
            if (reset_ser = '1') THEN
                counter <= (others => '0');
			   elsif(counter="1011"-depth_sel) then
					counter<= (others => '0');
            else 
                counter <= counter + 1;
            END if;
			 end if;
		
    END PROCESS;
	 
bit_depth<= to_integer(unsigned(depth_sel));
    sel <= counter;
    p_clk_out : PROCESS (clk_in)
    BEGIN
        IF (rising_edge(clk_in)) THEN
		   if(reset_ser='1') then
					din<="000000000000";	
            else
					if(ready='1') then
						din(11 downto bit_depth) <= din_ser(11-bit_depth downto 0); 
					else 
						din(11 downto bit_depth)<=test_pattern(11-bit_depth downto 0);
					end if;
            END IF;
        END IF;
    END PROCESS;
	 
	 --doutser clked =doutser rising edge of clock
 
 
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
                when"1000" => dout_ser <= DIN(3);
                WHEN"1001" => dout_ser <= DIN(2);
                WHEN"1010" => dout_ser <= DIN(1);
                WHEN"1011" => dout_ser <= DIN(0);
                WHEN OTHERS => 
                    dout_ser <= '0';
            END CASE;
        END PROCESS;
 

END behavioral;