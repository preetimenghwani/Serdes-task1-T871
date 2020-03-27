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
     signal din_ser             : std_logic_vector(11 downto 0) := (others => '0');
     signal dout_deser          : std_logic_vector(11 downto 0):= (others => '0');
     signal din_deser           : std_logic :='0';
     signal ready               : std_logic:='0';
  
    constant test_pattern      : std_logic_vector (11 downto 0) := "101110101111";
    signal sel                 : std_logic_vector(3 downto 0) := (others => '0');
    signal counter             : std_logic_vector(2 downto 0) := (others => '0');
    signal din                 : std_logic_vector(11 downto 0) :=(others => '0');
    signal bit_depth           : integer;
    signal clk_out_deser       : std_logic:='0';

   component deserializer 
    port(
         clk_in_deser        : in  std_logic:='0';
         reset_deser         : in  std_logic:='0';
         din_deser           : in  std_logic:='0';
         depth_sel           : in  std_logic_vector(2 downto 0):=(others=>'0');
         clk_out_deser       : out std_logic:='0';
         link_trained        : out std_logic:='0';
         dout_deser          : out std_logic_vector(11 downto 0):=(others=>'0')
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
      
    process (clk_in_ser)
      begin
         if rising_edge(clk_in_ser)  then
          if (reset_ser = '1') then
             clk_out_ser <= '0';       
         else
             if (counter = "101" - depth_sel(2 downto 1) ) then
                   clk_out_ser <= '1';           
            elsif (counter = "011" - depth_sel(2 downto 1)) then
                   clk_out_ser <= '0';            
            end if;
         end if;
      end if;
    end process;
      
    process (clk_in_ser, reset_ser)
    begin
      if (rising_edge(clk_in_ser)) then
        if (reset_ser = '1') then
          counter    <=  (others => '0');
        else
          if (counter = 5 - bit_depth/2) then
            counter <=  (others => '0');
          else
            counter <=  counter + 1;
          end if;
        end if;
      end if;
      end process;
 
    bit_depth <=  to_integer(unsigned(depth_sel));
    sel   <=  counter & (not clk_in_ser);
    
---------------------------------------------------------------------------------------
--p_clk_out process for assigning input data as test pattern when link is not trained  
---------------------------------------------------------------------------------------
  
    p_clk_out : process (clk_out_ser)
    begin
      if (rising_edge(clk_out_ser)) then
        if (reset_ser = '1') then
          din <= "000000000000"; 
        else
          if (ready = '1') then
                din(11 downto bit_depth) <= din_ser(11 - bit_depth downto 0);
          else
                din(11 downto bit_depth) <= test_pattern(11 - bit_depth downto 0);
          end if;
        end if;
      end if;
    end process;
          
---------------------------------------------------------------------------    
--process for samling output of serializer using a dmux
---------------------------------------------------------------------------
  
    process (sel,din)
      begin
        case sel is
            when"0000" => din_deser <= din(11);
            when"0001" => din_deser <= din(10);
            when"0010" => din_deser <= din(9);
            when"0011" => din_deser <= din(8);
            when"0100" => din_deser <= din(7);
            when"0101" => din_deser <= din(6);
            when"0110" => din_deser <= din(5);
            when"0111" => din_deser <= din(4);
            when"1000" => din_deser <= din(3);
            when"1001" => din_deser <= din(2);
            when"1010" => din_deser <= din(1);
            when"1011" => din_deser <= din(0);
            when others => 
              din_deser <= '0';
          end case;
    end process;
end;
