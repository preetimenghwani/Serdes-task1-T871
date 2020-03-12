----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:44:33 03/09/2020 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
entity deserializer is
	port( clk				:	in std_logic;
			reset				:	in std_logic;
			DIN2				:	in std_logic;
			DOUT2				:	out std_logic_vector(7 downto 0):=(others=>'0');
			clk_out1       :  out std_logic
	    );
end deserializer;

architecture Behavioral of deserializer is

	signal counter		:	std_logic_vector(2 downto 0);
	signal sel    		:	std_logic_vector(2 downto 0);
	signal DOUT    	:  std_logic_vector(7 downto 0) := (others => '0');
	signal clk_out	   :  std_logic:='0';
begin
	process(clk,reset)
   begin
		if(rising_edge(clk)) then
			if(reset='1') then
	      counter<= "000";
		else
         counter <= counter + 1;
			end if;
		end if;
	end process;
	
	sel<=counter;
   
   dout <= (din2 & dout(7 downto 1))  when (sel="000") else
            (dout(0) & din2 & dout(2) & dout(3) & dout(4) & dout(5) & dout(6) & dout(7)) when (sel="001") else
            (dout(0) & dout(1) & din2 & dout(3) & dout(4) & dout(5) & dout(6) & dout(7)) when (sel="010") else
            (dout(0) & dout(1) & dout(2) & din2 & dout(4) & dout(5) & dout(6) & dout(7)) when (sel="011") else
            (dout(0) & dout(1) & dout(2) & dout(3) & din2 & dout(5) & dout(6) & dout(7)) when (sel="100") else
            (dout(0) & dout(1) & dout(2) & dout(3) & dout(4) & din2 & dout(6) & dout(7)) when (sel="101") else
            (dout(0) & dout(1) & dout(2) & dout(3) & dout(4) & dout(5) & din2 & dout(7)) when (sel="110") else
            (dout(0) & dout(1) & dout(2) & dout(3) & dout(4) & dout(5) & dout(6) & din2) when (sel="111") ;
				
	
clk_out <= not counter(2);
clk_out1<=clk_out;
      p_clk_out:process(clk_out,reset)
		begin		
		if(rising_edge(clk_out)) then
			if(reset='1') then 
					dout2<="00000000";
			else 
				dout2<=dout;
			end if;
		end if;
		end process;
				
end Behavioral;

