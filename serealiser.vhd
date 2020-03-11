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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity serealisercomb is
	port( DIN1:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			clk :IN STD_LOGIC;
			reset:IN STD_LOGIC;
			DOUT1:OUT STD_LOGIC);
end serealisercomb;
architecture Behavioral of serealisercomb is

signal sel: std_logic_vector(2 downto 0);
signal counter: std_logic_vector(2 downto 0);
begin
	process(clk,reset)
		begin
			if(rising_edge(clk)) then
				if(reset='1' ) then
					counter<= "000";
				else
					counter <= counter + 1;
				end if;
			end if;
	end process;
	
	sel<=counter;
	
	process(DIN1,sel)
	begin
	CASE sel IS
	WHEN"000"=>DOUT1<=DIN1(0);
	WHEN"001"=>DOUT1<=DIN1(1);
	WHEN"010"=>DOUT1<=DIN1(2);
	WHEN"011"=>DOUT1<=DIN1(3);
	WHEN"100"=>DOUT1<=DIN1(4);
	WHEN"101"=>DOUT1<=DIN1(5);
	WHEN"110"=>DOUT1<=DIN1(6);
	WHEN"111"=>DOUT1<=DIN1(7);
	--when"1000"=>DOUT1<=DIN1(8);
	--WHEN"1001"=>DOUT1<=DIN1(9);
	--WHEN"1010"=>DOUT1<=DIN1(10);
	--WHEN"1011"=>DOUT1<=DIN1(11);
	WHEN OTHERS=>
	DOUT1<='Z';
	END CASE;
	END PROCESS;

end behavioral;
