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
ENTITY serealisercomb IS
    PORT (
        DIN1    : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        clk     : IN STD_LOGIC;
		  clk_out : in std_logic;
        reset   : IN STD_LOGIC;
		  depth_sel: integer;
        DOUT1   : OUT STD_LOGIC;
        ready   : in std_logic :='0'-- Link trained input from Deserializer
        --sel2 : out std_logic_vector(2 downto 0)
    );
END serealisercomb;
ARCHITECTURE Behavioral OF serealisercomb IS

    SIGNAL sel     : std_logic_vector(3 DOWNTO 0):=(others=>'0');
    SIGNAL counter : std_logic_vector(3 DOWNTO 0):=(others=>'0');
    --SIGNAL clk_out : std_logic;
    SIGNAL Din     : std_logic_vector(11 DOWNTO 0):=(others=>'0');
    --signal linked_buf : std_logic := '0';
    SIGNAL sync_rst : std_logic := '0';
    CONSTANT test_pattern : std_logic_vector (11 DOWNTO 0) := "101011001111";
	 --signal depth_sel: integer;

BEGIN
    sync_rst <= reset WHEN rising_edge(clk);

    PROCESS (clk, reset)
    BEGIN
        if (rising_edge(clk)) THEN
            if (sync_rst = '1') THEN
                counter <= (others => '0');
			   elsif(counter=11-depth_sel) then
					counter<= (others => '0');
            else 
                counter <= counter + 1;
            END if;
			 end if;
		
    END PROCESS;
 
    sel <= counter;
    --clk_out <= counter(2);
    p_clk_out : PROCESS (clk_out, reset)
    BEGIN
        IF (rising_edge(clk_out)) THEN
            IF (sync_rst = '0') THEN
					if(ready='1') then
						din(11 downto depth_sel) <= din1(11-depth_sel downto 0); 
					else 
						din(11 downto depth_sel)<=test_pattern(11-depth_sel downto 0);
					end if;
            END IF;
        END IF;
    END PROCESS;
 
 
    PROCESS (DIN, sel)
        BEGIN
            CASE sel IS
                WHEN"0000" => DOUT1 <= DIN(11);
                WHEN"0001" => DOUT1 <= DIN(10);
                WHEN"0010" => DOUT1 <= DIN(9);
                WHEN"0011" => DOUT1 <= DIN(8);
                WHEN"0100" => DOUT1 <= DIN(7);
                WHEN"0101" => DOUT1 <= DIN(6);
                WHEN"0110" => DOUT1 <= DIN(5);
                WHEN"0111" => DOUT1 <= DIN(4);
                when"1000" => DOUT1 <= DIN(3);
                WHEN"1001" => DOUT1 <= DIN(2);
                WHEN"1010" => DOUT1 <= DIN(1);
                WHEN"1011" => DOUT1 <= DIN(0);
                WHEN OTHERS => 
                    DOUT1 <= 'Z';
            END CASE;
        END PROCESS;
 

END behavioral;