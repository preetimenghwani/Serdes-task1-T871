----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:45:40 03/09/2020 
-- Design Name: 
-- Module Name:    serealiser - Behavioral 
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
        DIN1  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        clk   : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        DOUT1 : OUT STD_LOGIC;
        ready : in std_logic :='0'-- Link trained input from Deserializer
        --sel2 : out std_logic_vector(2 downto 0)
    );
END serealisercomb;
ARCHITECTURE Behavioral OF serealisercomb IS

    SIGNAL sel     : std_logic_vector(2 DOWNTO 0):=(others=>'0');
    SIGNAL counter : std_logic_vector(2 DOWNTO 0):=(others=>'0');
    SIGNAL clk_out : std_logic;
    SIGNAL Din     : std_logic_vector(7 DOWNTO 0):=(others=>'0');
    --signal linked_buf : std_logic := '0';
    SIGNAL sync_rst : std_logic := '0';
    CONSTANT test_pattern : std_logic_vector (7 DOWNTO 0) := "10101100";

BEGIN
    sync_rst <= reset WHEN rising_edge(clk);

    PROCESS (clk, reset)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (sync_rst = '1') THEN
                counter <= "000";
            ELSE
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS;
 
    sel <= counter;
    clk_out <= counter(2);
    p_clk_out : PROCESS (clk_out, reset)
    BEGIN
        IF (rising_edge(clk_out)) THEN
            IF (sync_rst = '0') THEN
					if(ready='1') then
						din <= din1; 
					else 
						din<=test_pattern;
					end if;
            END IF;
        END IF;
    END PROCESS;
 
 
    PROCESS (DIN1, sel)
        BEGIN
            CASE sel IS
                WHEN"000" => DOUT1 <= DIN(7);
                WHEN"001" => DOUT1 <= DIN(6);
                WHEN"010" => DOUT1 <= DIN(5);
                WHEN"011" => DOUT1 <= DIN(4);
                WHEN"100" => DOUT1 <= DIN(3);
                WHEN"101" => DOUT1 <= DIN(2);
                WHEN"110" => DOUT1 <= DIN(1);
                WHEN"111" => DOUT1 <= DIN(0);
                --when"1000"=>DOUT1<=DIN1(8);
                --WHEN"1001"=>DOUT1<=DIN1(9);
                --WHEN"1010"=>DOUT1<=DIN1(10);
                --WHEN"1011"=>DOUT1<=DIN1(11);
                WHEN OTHERS => 
                    DOUT1 <= 'Z';
            END CASE;
        END PROCESS;
 

END behavioral;