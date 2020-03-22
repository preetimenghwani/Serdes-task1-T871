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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity serdestop is
port(
      clk_in_final: in std_logic;
		clk_in_parallel:in std_logic;
		reset_ser:in std_logic;
		reset_deser:in std_logic;
		depth_sel:in std_logic_vector(1 downto 0):=(others=>'0');
		data_in: in std_logic_vector(11 downto 0):=(others=>'0');
		data_out: out std_logic_vector(11 downto 0):=(others=>'0');
		clk_out_final: out std_logic;
		ready_final: out std_logic:='0'
		);
end serdestop;

architecture rtl of serdestop is
COMPONENT serealisercomb
    port(
         din_ser        : IN  std_logic_vector(11 downto 0):=(others=>'0');
			ready          : in std_logic:='0';
         clk            : IN  std_logic:='0';
			depth_sel      : in std_logic_vector(1 downto 0):=(others=>'0');
			clk_in         : IN  std_logic:='0';
         reset_ser      : IN  std_logic:='0';
         dout_ser       : OUT  std_logic:='0'
			
        );
    END COMPONENT;
	 
	 COMPONENT deser 
    port(
         clk 	              : IN  std_logic:='0';
         reset_deser         : IN  std_logic:='0';
         DIN_deser 	        : IN  std_logic:='0';
			depth_sel           : in  std_logic_vector(1 downto 0):=(others=>'0');
         clk_out             : out std_logic:='0';
	      link_trained        : out std_logic:='0';
			dout_deser          : out std_logic_vector(11 downto 0):=(others=>'0')
			);
    END COMPONENT;
	 
   --signal linked: std_logic:='0';
   --signal din_deser_buf : std_logic:='0';
   --signal clk_in1: std_logic:='0';
   signal din_ser     	: std_logic_vector(11 downto 0) := (others => '0');
   signal clk        	: std_logic := '0';
	signal clk_in        : std_logic:='0';
  -- signal reset_deser : std_logic := '1';
  --signal reset_ser  	: std_logic := '1';
	signal DIN_deser   	: std_logic :='0';
	signal ready         : std_logic:='0';
  -- signal depth_sel     : integer;

 	--Outputs
   signal dout_ser    : std_logic:='0';
	signal dout_deser  : std_logic_vector(11 downto 0):= (others => '0');
	signal clk_out     : std_logic:='0';
	signal link_trained: std_logic:='0';




begin

ser_inst : serealisercomb
port map(
        din_ser=>din_ser,
		  ready=>ready,
		  clk=>clk,
		  depth_sel=>depth_sel,
		  clk_in=>clk_in,
		  reset_ser=>reset_ser,
		  dout_ser=>dout_ser
		  );
deser_inst: deser
port map(
			clk=>clk,
			reset_deser=>reset_deser,
			din_deser=>din_deser,
			depth_sel=>depth_sel,
			clk_out=>clk_out,
			link_trained=>link_trained,
			dout_deser=>dout_deser
			);
			
			din_deser<=dout_ser;
			ready<=link_trained;
			ready_final<=link_trained;
			din_ser<=data_in;
			data_out<=dout_deser;
			clk_in<=clk_in_parallel;
			clk<=clk_in_final;
			clk_out_final<=clk_out;

end rtl;

