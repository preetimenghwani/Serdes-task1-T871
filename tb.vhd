--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:48:10 03/19/2020
-- Design Name:   
-- Module Name:   /home/preeti/testtask/tb.vhd
-- Project Name:  testtask
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: deser
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
use ieee.std_logic_unsigned.all;

ENTITY tb IS
END tb;


 
ARCHITECTURE behavior OF tb IS 
constant testpattern : std_logic_vector(11 downto 0):= "101011001111";

 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT serealisercomb
    PORT(
         DIN1 : IN  std_logic_vector(11 downto 0):=(others=>'0');
			ready: in std_logic:='0';
         clk : IN  std_logic:='0';
			depth_sel:integer;
			clk_out : IN  std_logic:='0';
         reset : IN  std_logic:='0';
         DOUT1 : OUT  std_logic:='0'
			--link_trained:in std_logic;
			
        );
    END COMPONENT;
	 
	 COMPONENT deserializer 
    PORT(
         clk 	: IN  std_logic:='0';
         reset : IN  std_logic:='0';
         DIN2 	: IN  std_logic:='0';
         DOUT2 : OUT  std_logic_vector(11 downto 0);
         clk_out1 : out std_logic:='0';
	      link_trained :  out std_logic:='0';
			dout3    :out std_logic_vector(11 downto 0)
			);
    END COMPONENT;
    

   --Inputs
   signal DIN1   	: std_logic_vector(11 downto 0) := (others => '0');
   signal clk    	: std_logic := '0';
   signal reset  	: std_logic := '1';
	signal reset2  	: std_logic := '1';
	signal DIN2   	: std_logic :='0';
	signal ready   : std_logic:='0';
	--signal bit_depth : std_logic_vector(3 downto 0);

 	--Outputs
   signal DOUT1 : std_logic:='0';
	signal DOUT2 : std_logic_vector(11 downto 0):= (others => '0');
	
  
  signal clk_out1  :  std_logic:='0';
  signal link_trained: std_logic:='0';
  signal counter:	std_logic_vector(3 downto 0):= (others => '0');
  signal sel    :	std_logic_vector(3 downto 0):= (others => '0');
  signal DOUT    :  std_logic_vector(11 downto 0) := (others => '0');
  signal clk_out	   :  std_logic:='0';
  signal sync_rst   :  std_logic:='0';
  signal linked     :  std_logic:='0';
  signal counter2   :  std_logic_vector(1 downto 0):=(others=>'0');
  signal dout3      :  std_logic_vector(11 downto 0);
  signal depth_sel  :  integer;
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: serealisercomb PORT MAP (
          DIN1 => DIN1,
          clk => clk,
			 clk_out => clk_out,
          reset => reset2,
          DOUT1 => DOUT1,
			 ready=>ready,
			 depth_sel=>depth_sel
			-- link_trained=>link_trained

        );
		  
  -- uut2: deserializer PORT MAP (
        -- clk => clk,
        -- reset => reset,
        -- DIN2 => DIN2,
        -- DOUT2 => DOUT2,
		  --clk_out1=>clk_out1,
		  --link_trained=>link_trained
			
 			-- );
   -- Clock process definitions
	din2<=dout1;
	ready<=link_trained;
	--bit_depth<="1100";
	
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	--bit_depth<="0111";
	depth_sel<=0;

  -- Stimulus process
   stim_proc: process
   begin	
		
   reset <= '1';
	reset2 <= '1';
	
	wait for 35ns;
	reset2 <= '0';
	wait for 20ns;
	reset <= '0';
	wait until ready = '1';
   --wait for 80ns;
	
 -- DIN1<="111000100000";
  -- wait for 80ns;
	--DIN1<="010100100000";
  -- wait for 80ns;
	--DIN1<="101011000000";
  -- wait for 80ns;
	--DIN1<="001111110000";
 --  wait for 80ns;
	--DIN1<="001111101111";
   --wait for 80ns;
	--DIN1<="001111111111";
   --wait for 80ns;
	DIN1<="111100000000";
   wait for 120ns;
	DIN1<="111111010111";
   wait for 120ns;
	DIN1<="111111110100";
   wait for 120ns;
	DIN1<="111111110010";
   wait for 120ns;
	DIN1<="111111100010";
   wait for 120ns;
	DIN1<="111111010010";
   wait for 120ns;
	DIN1<="111110101100";
   wait for 120ns;
	DIN1<="111111110000";
   wait for 120ns;
	DIN1<="111111101111";
   wait for 120ns;
	DIN1<="001111111111";
   wait for 120ns;
	DIN1<="001100000000";
   wait for 120ns;
	DIN1<="001101010111";
   wait for 120ns;
	DIN1<="001101110100";
   wait for 120ns;
	DIN1<="001100100000";
   wait for 120ns;
	DIN1<="000011100010";
   wait for 120ns;
	DIN1<="000001010010";
   wait for 120ns;
	DIN1<="000010101100";
   wait for 120ns;
	DIN1<="000011110000";
   wait for 120ns;
	DIN1<="000011101111";
   wait for 120ns;
	DIN1<="000011111111";
   wait for 120ns;
	DIN1<="000000000000";
   wait for 120ns;
	DIN1<="000001010111";
   wait for 120ns;
	DIN1<="000001110100";
   wait for 120ns;
	DIN1<="000000110010";
   wait for 120ns;
	DIN1<="000011100010";
   wait for 120ns;
	DIN1<="000001010010";
   wait for 120ns;
	DIN1<="000010101100";
   wait for 120ns;
	DIN1<="000011110000";
   wait for 120ns;
	DIN1<="000011101111";
   wait for 120ns;
	DIN1<="000011111111";
   wait for 100ns;
	DIN1<="000000000000";
   wait for 120ns;
	DIN1<="000001010111";
   wait for 120ns;
	DIN1<="000001110100";
   wait for 100ns;
	DIN1<="000000110010";
   wait for 100ns;
	
     wait;
	end process;

--process(bit_depth)
	--begin
	 --if bit_depth="0111" then depth_sel<=4;
	 --elsif bit_depth="1001" then depth_sel<=2;
	 --elsif bit_depth="1011" then depth_sel<=0;
	 --end if;
	--end process;
	
	
	
sync_rst <= reset when rising_edge(clk);
link_trained<=linked;

bitslip_proc : process(clk) 
	begin
    if rising_edge(clk) then

		if sync_rst='1' then
			counter<="0000";
			linked <= '0';
		else
			  if counter=11-depth_sel then
			     counter<="0000";
	   else 
	      if linked = '1' then
			    counter<=counter+1;
			else
			   if counter2="01" and counter="0000" then
					if Dout2(11-depth_sel downto 0)=testpattern(11-depth_sel downto 0) then
					    linked <= '1';
						 
					else 
					    linked <= linked;
					
					end if;
					counter <= counter + '1';
					
				elsif counter2 = "11" and counter="0001" then
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
					counter2<=counter2+1;
		      end if;
			end if;
	 end process;
				
		
		
		
	
	sel<=counter;
   
   dout <=  (din2  & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0))  when (sel="0000") else
            (dout(11)  & din2 & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0001") else
            (dout(11) & dout(10) & din2 & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0010") else
            (dout(11)  & dout(10) & dout(9) &din2 & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0011") else
            (dout(11)  & dout(10) & dout(9) & dout(8) & din2 & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0100") else
            (dout(11)  & dout(10) & dout(9) & dout(8) & dout(7) & din2 & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0101") else
            (dout(11) & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & din2 & dout(4)& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0110") else
            (dout(11) & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & din2& dout(3)& dout(2)& dout(1)& dout(0)) when (sel="0111") else
				(dout(11)  & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& din2& dout(2)& dout(1)& dout(0)) when (sel="1000") else
				(dout(11)  & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& din2& dout(1)& dout(0)) when (sel="1001") else
				(dout(11)  & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& din2& dout(0)) when (sel="1010") else
				(dout(11)  & dout(10) & dout(9) & dout(8) & dout(7) & dout(6) & dout(5) & dout(4)& dout(3)& dout(2)& dout(1)& din2) when (sel="1011"); 
				
				
	
clk_out <= not counter(2);
clk_out1<=clk_out;
      p_clk_out:process(clk_out,reset)
		begin		
		if(rising_edge(clk_out)) then
			if(reset='1') then 
					dout2<= (others => '0');
			else 
				dout2(11-depth_sel downto 0)<=dout(11 downto depth_sel);
			end if;
		end if;
		end process;
		
    finalout:process(dout2,link_trained)
	 begin
	 if(link_trained='0') then 
		dout3<= (others => '0');
	 else 
	   dout3<=dout2;
	 end if;
	 end process;
	 

				
end Behavior;