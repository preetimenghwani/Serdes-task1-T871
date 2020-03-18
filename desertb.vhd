--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:58:30 03/10/2020
-- Design Name:   
-- Module Name:   /home/preeti/serdestask/desertb.vhd
-- Project Name:  serdestask
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
use ieee.std_logic_unsigned.all;

ENTITY serealtb IS
END serealtb;


 
ARCHITECTURE behavior OF serealtb IS 
constant testpattern : std_logic_vector(7 downto 0):= "10101100";

 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT serealisercomb
    PORT(
         DIN1 : IN  std_logic_vector(7 downto 0):=(others=>'0');
			ready: in std_logic:='0';
         clk : IN  std_logic:='0';
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
         DOUT2 : OUT  std_logic_vector(7 downto 0);
         clk_out1      :  out std_logic:='0';
	link_trained   :  out std_logic:='0'
			

			
        );
    END COMPONENT;
    

   --Inputs
   signal DIN1   	: std_logic_vector(7 downto 0) := (others => '0');
   signal clk    	: std_logic := '0';
   signal reset  	: std_logic := '0';
	signal DIN2   	: std_logic :='0';
	signal ready   : std_logic:='0';

 	--Outputs
   signal DOUT1 : std_logic:='0';
	signal DOUT2 : std_logic_vector(7 downto 0):= (others => '0');
	
  
  signal clk_out1  :  std_logic:='0';
  signal link_trained: std_logic:='0';
  signal counter:	std_logic_vector(2 downto 0):= (others => '0');
  signal sel    :	std_logic_vector(2 downto 0):= (others => '0');
  signal DOUT    :  std_logic_vector(7 downto 0) := (others => '0');
  signal clk_out	   :  std_logic:='0';
  signal sync_rst   :  std_logic:='0';
  signal linked     :  std_logic:='0';
  signal counter2   :  std_logic_vector(2 downto 0):=(others=>'0');
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: serealisercomb PORT MAP (
          DIN1 => DIN1,
          clk => clk,
          reset => reset,
          DOUT1 => DOUT1,
			 ready=>ready
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
	
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

  -- Stimulus process
   stim_proc: process
   begin	
		
   reset <= '1';
	wait for 10ns;
	reset <= '0';
	
	DIN1<="11100010";
  
     wait;
	end process;
	
	
	
	
	
	
	
	
	
sync_rst <= reset when rising_edge(clk);
link_trained<=linked;

bitslip_proc : process(clk) 
	begin
    if rising_edge(clk) then
		if sync_rst='1' then
			counter<="000";
			linked <= '0';
	 else if Dout2(7 downto 0)=testpattern and counter="001" and linked='0' and counter2="010"then
		linked<='1';
		counter<="001";  --syncing counter
	else if Dout2(7 downto 0) /= testpattern and counter="011" and counter2="100" then
		counter<=counter+2;	
	else 
		counter<=counter+1;
	end if;
	end if;
	end if;
		end if;
	end process;
	
	newcounter_proc: process(counter,clk)
		begin
			if rising_edge(clk) then
				if(counter= "111") then
					counter2<=counter2+1;
		      end if;
			end if;
	 end process;
				
		
		
		
	
	sel<=counter;
   
   dout <=  (din2  & dout(6) & dout(5) & dout(4) & dout(3) & dout(2) & dout(1) & dout(0))  when (sel="000") else
            (dout(7) &  din2 & dout(5) & dout(4) & dout(3) & dout(2) & dout(1) & dout(0)) when (sel="001") else
            (dout(7) & dout(6) &  din2 & dout(4) & dout(3) & dout(2) & dout(1) & dout(0)) when (sel="010") else
            (dout(7) & dout(6) & dout(5) & din2 & dout(3) & dout(2) & dout(1) & dout(0)) when (sel="011") else
            (dout(7) & dout(6) & dout(5) & dout(4) & din2 & dout(2) & dout(1) & dout(0)) when (sel="100") else
            (dout(7) & dout(6) & dout(5) & dout(4) & dout(3) & din2  & dout(1) & dout(0)) when (sel="101") else
            (dout(7) & dout(6) & dout(5) & dout(4) & dout(3) & dout(2) & din2 & dout(0)) when (sel="110") else
            (dout(7) & dout(6) & dout(5) & dout(4) & dout(3) & dout(2) & dout(1) & din2) when (sel="111") ;
				
				
	
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
				
end Behavior;

	

	

 
