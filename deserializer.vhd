--------------------------------------------------------------------------------
-- Company: Apertus
-- Engineer: Preeti Menghwani
--
-- Create Date:    20:01:27 03/26/2020 
-- Design Name:    Deserializer
-- Module Name:    deserializer - behavioral 
-- Project Name:   Serdes_Task1_T871
-- Target Devices: xc7z020-3clg484
-- Description: 
-- In this module the input data is a DDR bit stream. Bitslip processis used 
-- for link training. When training, the input to deserializer must be a the 
-- testpattern equal to  "0xBAF". The counter skips one count during link 
-- training so the output suffers a bit slip, this continues until we get the 
-- test pattern on output port. Once the testpattern is obtained the counter 
-- works normally and resets after a count of 5-bit_depth/2. 
-- Bit_depth="000" for 12 bit, "010" for 10 bit, "100" for 8 bit data input to 
-- the serializer. It samples input at high speed clock, and when counter is '1'
-- it takes the first two bits of input data and so on..
-- It gives deserialized output at low speed clock.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity top is
    port (
        clk_in_deser  : in  std_logic := '0';
        reset_deser   : in  std_logic := '0';
        din_deser     : in  std_logic := '0';
        depth_sel     : in  std_logic_vector(2 downto 0)  := (others => '0');
        clk_out_deser : out std_logic := '0';
        link_trained  : out std_logic := '0'; -- assigned '1' when bit slip is adjusted
        dout_deser    : out std_logic_vector(11 downto 0) := (others => '0')
    );
end top;

architecture behavioral of top is

    signal dout            : std_logic_vector(11 downto 0) := (others => '0');
    signal dout_buf        : std_logic_vector(11 downto 0) := (others => '0');
    signal counter         : std_logic_vector(2 downto 0) := (others => '0');
    signal sel             : std_logic_vector(2 downto 0) := (others => '0');
    signal counter_word    : std_logic_vector(1 downto 0) := (others => '0');
    signal linked          : std_logic := '0';
    signal clk_out_sig     : std_logic := '0';
    signal bit_depth       : integer;
    signal ddr             : std_logic_vector(1 downto 0);
    signal ddr0            : std_logic;
    signal din             : std_logic_vector(1 downto 0);
    signal test_pattern  : std_logic_vector(11 downto 0) := "101110101111";

begin

    link_trained <= linked;

    ----------------------------------------------------------------------------
    -- DDR implementation using flip flops and a latch    
    ----------------------------------------------------------------------------
    ddr0 <= din_deser when falling_edge(clk_in_deser);
    ddr(1) <= ddr0 when rising_edge(clk_in_deser);
    ddr(0) <= din_deser when rising_edge(clk_in_deser); 
    din  <= ddr;
     
    ----------------------------------------------------------------------------
    -- bitslip_proc: Adjusts the bitslip for link training 
    ---------------------------------------------------------------------------- 
    bitslip_proc : process (clk_in_deser)
    begin
        if rising_edge(clk_in_deser) then
            if reset_deser = '1' then
                counter <= "000";
                linked  <= '0';

            else
                if counter = 5 - bit_depth/2 then
                    counter <= "000";

                else
                    if linked = '1' then
                        counter <= counter + 1;

                    else
                        if counter_word = "01" and counter = "001" then
                            if dout_buf(11 - bit_depth downto 0) =
                                test_pattern(11 - bit_depth downto 0) then
                                linked <= '1';

                            else
                                linked <= linked;

                            end if;
                            counter <= counter + 1;

                        elsif counter_word = "11" and counter = "001" then
                            counter <= counter + 2;

                        else
                            counter <= counter + 1;

                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

    ----------------------------------------------------------------------------
    -- word_counter_proc: Making a word counter which is used for give gap 
    --                    between bit slip words.
    ----------------------------------------------------------------------------
    word_counter_proc : process (clk_in_deser)
    begin
        if rising_edge(clk_in_deser) then
            if counter = 5 - bit_depth/2 then
                counter_word <= counter_word + 1;

            end if;
        end if;
    end process;

    bit_depth <= to_integer(unsigned(depth_sel));
    sel <= counter;

    ----------------------------------------------------------------------------
    -- deser_proc : Takes two bit DDR words and deseriazes them in bit depth 
    --              sized words
    ----------------------------------------------------------------------------
    deser_proc : process (clk_in_deser)
    begin
        if rising_edge(clk_in_deser) then
            if reset_deser = '1' then
                dout <= (others => '0');

            else
                if sel = "000" then
                    dout(11 downto 10) <= din;
                    dout_buf((11 - bit_depth) downto 0) <= dout(11 downto bit_depth);

                elsif sel = "001" then
                    dout(9 downto 8) <= din;

                elsif sel = "010" then
                    dout(7 downto 6) <= din;

                elsif sel = "011" then
                    dout(5 downto 4) <= din;

                elsif sel = "100" then
                    dout(3 downto 2) <= din;
                          
                elsif sel = "101" then
                    dout(1 downto 0) <= din;

                end if;
            end if;
        end if;
    end process;
     
    dout_deser <= dout_buf;
     
    ----------------------------------------------------------------------------
    -- slow_clk_gen_proc : Generates slow speed output clock
    ----------------------------------------------------------------------------
    slow_clk_gen_proc : process (clk_in_deser)
    begin
        if rising_edge(clk_in_deser) then
            if reset_deser = '1' then
                clk_out_sig <= '0';

            else
                if counter = "101" - depth_sel(2 downto 1) then
                    clk_out_sig <= '1';

                elsif counter = "011" - depth_sel(2) then
                    clk_out_sig <= '0';

                end if;
            end if;
        end if;
    end process;
	 clk_out_deser <= clk_out_sig; 

end behavioral;
