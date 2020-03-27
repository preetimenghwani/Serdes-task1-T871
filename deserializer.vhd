----------------------------------------------------------------------------------
-- company: 
-- engineer: 
-- 
-- create date:    20:01:27 03/26/2020 
-- design name: 
-- module name:    deserializer - behavioral 
-- project name: 
-- target devices: 
-- tool versions: 
-- description: 
--
-- dependencies: 
--
-- revision: 
-- revision 0.01 - file created
-- additional comments: 
--
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- company: 
-- engineer: 
-- 
-- create date:    20:01:27 03/26/2020 
-- design name: 
-- module name:    deserializer - behavioral 
-- project name: 
-- target devices: 
-- tool versions: 
-- description: 
--
-- dependencies: 
--
-- revision: 
-- revision 0.01 - file created
-- additional comments: 
--
----------------------------------------------------------------------------------
-- company: 
-- engineer: 
-- 
-- create date:    17:43:52 03/19/2020 
-- design name: 
-- module name:    deserializer - behavioral 
-- project name: 
-- target devices: 
-- tool versions: 
-- description: 
--
-- dependencies: 
--
-- revision: 
-- revision 0.01 - file created
-- additional comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity deserializer is
port (
  clk_in_deser  : in std_logic := '0';
  reset_deser   : in std_logic := '0';
  din_deser     : in std_logic := '0';
  depth_sel     : in std_logic_vector(2 downto 0) := (others => '0');
  clk_out_deser : out std_logic := '0';
  link_trained  : out std_logic := '0';                                  --assigned '1' when bit slip is adjusted
  dout_deser    : out std_logic_vector(11 downto 0) := (others => '0');
  );
end deserializer;

architecture behavioral of deserializer is

  signal dout              : std_logic_vector(11 downto 0) := (others => '0');
  signal dout2             : std_logic_vector(11 downto 0) := (others => '0');
  signal counter           : std_logic_vector(2 downto 0) := (others => '0');
  signal sel               : std_logic_vector(2 downto 0) := (others => '0');
  signal counter_bit       : std_logic_vector(1 downto 0) := (others => '0');
  signal linked            : std_logic := '0';
  signal clk_out_sig       : std_logic := '0';
  signal bit_depth         : integer;
  signal clk_out_sig_del   : std_logic;
  signal ddr               : std_logic_vector(1 downto 0);        
  signal ddr0              : std_logic;
  signal din               : std_logic_vector(1 downto 0);
  constant test_pattern    : std_logic_vector (11 downto 0) := "101110101111";

begin
  link_trained <= linked;

------------------------------------------------------------------------    
-- ddr implementation using flip flops and latches with reset    
--------------------------------------------------------------------------

  ddr0 <= din_deser when clk_in_deser = '0';
  ddr(1) <= din_deser when falling_edge(clk_in_deser);
  ddr(0) <= ddr0 when falling_edge(clk_in_deser);
  din <= ddr(0) & ddr(1);
  
--------------------------------------------------------------------------
--  bitslip_proc: adjusts the bitslip for link training 
---------------------------------------------------------------------------  
  bitslip_proc : process (clk_in_deser)
  begin
    if rising_edge(clk_in_deser) then

      if reset_deser = '1' then
        counter <= "000";
        linked <= '0';
      else
        if counter = 5 - bit_depth/2 then
          counter <= "000";
        else
          if linked = '1' then
            counter <= counter + 1;
          else
            if counter_bit = "01" and counter = "011" then
              if dout2(11 - bit_depth downto 0) = test_pattern(11 - bit_depth downto 0) then
                linked <= '1';
              else
                linked <= linked;
              end if;
              counter <= counter + '1';

            elsif counter_bit = "11" and counter = "011" then
              counter <= counter + 2;

            else
              counter <= counter + '1';
            end if;
          end if;
        end if;
      end if;
    end if;
  end process;
  
----------------------------------------------------------------------------------------------------------    
--newcounter_proc: for making a new counter which is used for checking whether link is trained or not
----------------------------------------------------------------------------------------------------------

  newcounter_proc : process (counter, clk_in_deser)
  begin
    if rising_edge(clk_in_deser) then
      if (counter = 5 - bit_depth/2) then
        counter_bit <= counter_bit + 1;
      end if;
    end if;
  end process;

  bit_depth <= to_integer(unsigned(depth_sel));

  sel <= counter;
  
  process (clk_in_deser)
    begin
      if (rising_edge(clk_in_deser)) then
        if (reset_deser = '1') then
          dout <= "000000000000";
        else
          if (sel = "000") then
            dout(11 downto 10) <= din;
          elsif (sel = "001") then
            dout(9 downto 8) <= (din);
          elsif (sel = "010") then
            dout(7 downto 6) <= (din);
          elsif (sel = "011") then
            dout(5 downto 4) <= din;
          elsif (sel = "100") then
            dout(3 downto 2) <= din;
          elsif (sel = "101") then
            dout(1 downto 0) <= din;
          end if;
        end if;
      end if;
    end process;

    clk_out_deser <= clk_out_sig_del;
---------------------------------------------------------------------------      
-- process for making a delayed clock signal for output data sampling
----------------------------------------------------------------------------
  process (clk_in_deser)
    begin
      if rising_edge(clk_in_deser) then
        if clk_out_sig = '1' then
          clk_out_sig_del <= '1';
        elsif clk_out_sig = '0' then
          clk_out_sig_del <= '0';
        end if;
      end if;
    end process;


  process (clk_in_deser)
    begin
      if rising_edge(clk_in_deser) then
        if (reset_deser = '1') then
          clk_out_sig <= '0';
        else
          if (counter = "101" - depth_sel(2 downto 1)) then
            clk_out_sig <= '1';

          elsif (counter = "011" - depth_sel(2)) then
            clk_out_sig <= '0';
          end if;
        end if;
      end if;
    end process;
----------------------------------------------------------------------------          
-- sampling of output data
----------------------------------------------------------------------------

  p_clk_out : process (clk_out_sig_del)
    begin
      if (rising_edge(clk_out_sig_del)) then
        if (reset_deser = '1') then
          dout2 <= (others => '0');
        else
          dout2(11 - bit_depth downto 0) <= dout(11 downto bit_depth);
        end if;
      end if;
    end process;  
    
  dout_deser <= dout2;
        
end behavioral;














