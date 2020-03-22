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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity deser is
  port(
         clk 	              : IN  std_logic:='0';
         reset_deser         : IN  std_logic:='0';
         DIN_deser 	        : IN  std_logic:='0';
			depth_sel           : in std_logic_vector(1 downto 0):=(others=>'0');
         clk_out             : out std_logic:='0';
	      link_trained        : out std_logic:='0';
			dout_deser          : out std_logic_vector(11 downto 0):=(others=>'0')
			);
end deser;

architecture Behavioral of deser is

signal DOUT           : std_logic_vector(11 downto 0):=(others=>'0');
signal DOUT2          : std_logic_vector(11 downto 0):=(others=>'0');
signal counter        :	std_logic_vector(3 downto 0):= (others => '0');
signal sel            :	std_logic_vector(3 downto 0):= (others => '0');
signal counter_bit    : std_logic_vector(1 downto 0):=(others=>'0');
signal linked         : std_logic:='0';
signal clk_in         : std_logic:='0';
CONSTANT test_pattern : std_logic_vector (11 DOWNTO 0) := "101011001111";
signal bit_depth: integer;

begin

--sync_rst <= reset when rising_edge(clk);
link_trained<=linked;

bitslip_proc : process(clk) 
	begin
    if rising_edge(clk) then

		if reset_deser='1' then
			counter<="0000";
			linked <= '0';
		else
			  if counter=11-bit_depth then
			     counter<="0000";
	   else 
	      if linked = '1' then
			    counter<=counter+1;
			else
			   if counter_bit="01" and counter="0000" then
					if Dout2(11-bit_depth downto 0)=test_pattern(11-bit_depth downto 0) then
					    linked <= '1';
						 
					else 
					    linked <= linked;
					
					end if;
					counter <= counter + '1';
					
				elsif counter_bit = "11" and counter="0001" then
				   counter <= counter+2;	
				
				else 
				   counter <= counter + '1';
				end if;
	      end if;
	   end if;
	end if;
end if;
	end process;
	
	newcounter_proc: process(counter,clk)
		begin
			if rising_edge(clk) then
				if(counter= "0111") then
					counter_bit<=counter_bit+1;
		      end if;
			end if;
	 end process;
				
bit_depth<= to_integer(unsigned(depth_sel));	
		
	
	sel<=counter;
   
   dout <=  (din_deser  & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0))  when (sel="0000") else
            (dout(11)  & din_deser & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0001") else
            (dout(11) & dout(10) & din_deser & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0010") else
            (dout(11)  & dout(10) & dout(9) &din_deser & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0011") else
            (dout(11)  & dout(10) & dout(9) & dout(8) & din_deser & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0100") else
            (dout(11)  & dout(10) & dout(9) & dout(8) & dout(7) & din_deser & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0101") else
            (dout(11) & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & din_deser & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0110") else
            (dout(11) & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & din_deser& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0111") else
				(dout(11)  & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& din_deser& dout(2)& dout(1)& dout(0)) when (sel="1000") else
				(dout(11)  & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& din_deser& dout(1)& dout(0)) when (sel="1001") else
				(dout(11)  & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& din_deser& dout(0)) when (sel="1010") else
				(dout(11)  & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& din_deser) when (sel="1011"); 
				
				
	
clk_out <= not counter(2);
clk_in<= not counter(2);
--clk_out<=clk_in;
      p_clk_out:process(clk_in,reset_deser)
		begin		
		if(rising_edge(clk_in)) then
			if(reset_deser='1') then 
					dout2<= (others => '0');
			else 
				dout2(11-bit_depth downto 0)<=dout(11 downto bit_depth);
			end if;
		end if;
		end process;
		
    finalout:process(dout2,linked)
	 begin
	 if(linked='0') then 
		dout_deser<= (others => '0');
	 else 
	   dout_deser<=dout2;
	 end if;
	 end process;
	 




end Behavioral;

