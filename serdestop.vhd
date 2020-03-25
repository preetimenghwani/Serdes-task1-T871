----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:26:56 03/21/2020 
-- Design Name: 
-- Module Name:    serdestop - Behavioral 
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

library unisim;
use unisim.vcomponents.all;

entity serdestop is
port(
                clk_in                   : in std_logic;
		reset_ser      : in std_logic;
		reset_deser    : in std_logic;
		depth_sel      : in std_logic_vector(2 downto 0):=(others=>'0');
		data_in        : in std_logic_vector(11 downto 0):=(others=>'0');
		data_out       : out std_logic_vector(11 downto 0):=(others=>'0');
		clk_out        : out std_logic;
		ready_final    : out std_logic:='0';
		ser_str        : out std_logic
		);
end serdestop;

architecture rtl of serdestop is
COMPONENT serializer
    port(
         din_ser        : IN  std_logic_vector(11 downto 0):=(others=>'0');
         ready          : in std_logic:='0';
         clk_in_ser     : IN  std_logic:='0';
         depth_sel      : in std_logic_vector(2 downto 0):=(others=>'0');
	 clk_out_ser    : out  std_logic:='0';
         reset_ser      : IN  std_logic:='0';
         dout_ser       : OUT  std_logic:='0'
			
        );
    END COMPONENT;
	 
	 COMPONENT deserializer 
    port(
         clk_in_deser 	     : IN  std_logic:='0';
         reset_deser         : IN  std_logic:='0';
         DIN_deser 	     : IN  std_logic:='0';
	 depth_sel           : in  std_logic_vector(2 downto 0):=(others=>'0');
         clk_out_deser       : out std_logic:='0';
	 link_trained        : out std_logic:='0';
         dout_deser          : out std_logic_vector(11 downto 0):=(others=>'0')
			);
    END COMPONENT;
	 
   
   signal din_ser     	          : std_logic_vector(11 downto 0) := (others => '0');
   signal clk_in_ser              : std_logic := '0';
	signal clk_in_deser       : std_logic:='0';
	signal clk_out_ser        : std_logic:='0';
	signal DIN_deser       	  : std_logic :='0';
	signal ready              : std_logic:='0';

 	--Outputs
   signal dout_ser                : std_logic:='0';
	signal dout_deser         : std_logic_vector(11 downto 0):= (others => '0');
	signal clk_out_deser      : std_logic:='0';
	signal link_trained       : std_logic:='0';




begin

ser_str <= dout_ser;
ser_inst : serializer
port map(
                  din_ser      => din_ser,
		  ready        => ready,
		  clk_in_ser   => clk_in_ser,
		  depth_sel    => depth_sel,
		  clk_out_ser  => clk_out_ser,
		  reset_ser    => reset_ser,
		  dout_ser     => dout_ser
		  );
deser_inst: deserializer
port map(
			clk_in_deser  => clk_in_deser,
			reset_deser   => reset_deser,
			din_deser     => din_deser,
			depth_sel     => depth_sel,
			clk_out_deser => clk_out_deser,
			link_trained  => link_trained,
			dout_deser    => dout_deser
			);
			
			din_deser     <= dout_ser;
			ready         <= link_trained;
			ready_final   <= link_trained;
			din_ser       <= data_in;
			data_out      <= dout_deser;
			clk_in_ser    <= clk_in;
			clk_in_deser  <= clk_in;
			clk_out       <= clk_out_deser;

end rtl;

