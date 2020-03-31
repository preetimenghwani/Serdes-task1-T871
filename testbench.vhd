--------------------------------------------------------------------------------
-- Company: Apertus
-- Engineer: Preeti Menghwani
--
-- Create Date:   20:53:41 03/21/2020
-- Design Name:   
-- Module Name:   testbench.vhd
-- Project Name:  Serdes_task_1_T871
-- Target Device: ZYNQ 7020 (xc7z020-3clg484)  
-- Description:   
-- This module is the testbench to test the deserializer and acts as a 
-- serializer. It serializes the input data at high speed DDR clock using a 
-- multiplexer, takes ready signal as input from deserializer for choosing 
-- between training pattern and the data. Hence assumes test pattern as input 
-- data when ready is '0' otherwise takes the user input value. 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity serdestoptb is
end serdestoptb;

architecture behavior of serdestoptb is

    constant clk_in_ser_period : time := 3.333 ns;
    constant test_pattern : std_logic_vector (11 downto 0) := "101110101111";
    -- Clocks and resets
    signal clk_in_ser    : std_logic := '0';
    signal clk_in_ser_90 : std_logic := '0';
    signal clk_out_ser   : std_logic := '0';
    signal clk_out_deser : std_logic := '0';
    signal reset_ser     : std_logic := '0';
    signal reset_deser   : std_logic := '0';
    -- Data signals
    signal din        : std_logic_vector(11 downto 0) := (others => '0');
    signal din_ser    : std_logic_vector(11 downto 0) := (others => '0');
    signal din_deser  : std_logic := '0';
    signal dout_deser : std_logic_vector(11 downto 0) := (others => '0');
    -- Control Signals
    signal depth_sel : std_logic_vector(2 downto 0) := (others => '0');
    signal ready     : std_logic := '0';
    signal bit_depth : integer;
    -- Internl signals
    signal sel     : std_logic_vector(3 downto 0) := (others => '0');
    signal counter : std_logic_vector(2 downto 0) := (others => '0');

    component deserializer
        port(
            clk_in_deser  : in  std_logic := '0';
            reset_deser   : in  std_logic := '0';
            din_deser     : in  std_logic := '0';
            depth_sel     : in  std_logic_vector(2 downto 0);
            clk_out_deser : out std_logic := '0';
            link_trained  : out std_logic := '0';
            dout_deser    : out std_logic_vector(11 downto 0)
        );
    end component;

begin

    ----------------------------------------------------------------------------
    -- deser_int : Instantion of Serial to Parallel Converter i.e. Deserializer
    ----------------------------------------------------------------------------
    deser_inst : deserializer
        port map(
            clk_in_deser  => clk_in_ser_90,
            reset_deser   => reset_deser,
            din_deser     => din_deser,
            depth_sel     => depth_sel,
            clk_out_deser => clk_out_deser,
            link_trained  => ready,
            dout_deser    => dout_deser
        );

    ----------------------------------------------------------------------------
    -- serial_clk_gen_proc : High speed clock at 0 degree and phase shifted 
    --                       clock for implementing DDR 
    ----------------------------------------------------------------------------
    serial_clk_gen_proc : process
    begin
        clk_in_ser    <= '1';
        wait for clk_in_ser_period*0/8;
        clk_in_ser_90 <= '1';
        wait for clk_in_ser_period*4/8;

        clk_in_ser    <= '0';
        wait for clk_in_ser_period*0/8;
        clk_in_ser_90 <= '0';
        wait for clk_in_ser_period*4/8;

    end process;

    depth_sel <= "000";

    ----------------------------------------------------------------------------
    -- stim_data_gen_proc : Data generation for serialization
    ----------------------------------------------------------------------------
    stim_data_gen_proc : process
    begin
        reset_deser <= '1';
        reset_ser   <= '1';
        wait for 35 ns;

        reset_ser <= '0';
        wait for 20 ns;
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

    ----------------------------------------------------------------------------
    -- input_clk_gen_proc : Deserialized input data receive clock generator
    ----------------------------------------------------------------------------
    input_clk_gen_proc : process(clk_in_ser)
    begin
        if rising_edge(clk_in_ser) then
            if (reset_ser = '1') then
                clk_out_ser <= '0';

            else
                if (counter = "101" - depth_sel(2 downto 1)) then
                    clk_out_ser <= '1';

                elsif (counter = "011" - depth_sel(2 downto 1)) then
                    clk_out_ser <= '0';

                end if;
            end if;
        end if;
    end process;

    ----------------------------------------------------------------------------
    -- counter_proc : Counter for indexing the multiplexer
    ----------------------------------------------------------------------------
    counter_proc : process(clk_in_ser)
    begin
        if (rising_edge(clk_in_ser)) then
            if (reset_ser = '1') then
                counter <= (others => '0');

            else
                if (counter = 5 - bit_depth/2) then
                    counter <= (others => '0');

                else
                    counter <= counter + 1;

                end if;
            end if;
        end if;
    end process;

    bit_depth <= to_integer(unsigned(depth_sel));
    sel <= counter & (not clk_in_ser);

    ----------------------------------------------------------------------------
    -- traning_data_proc : Assigns input data as test pattern when link is
    --                     not trained 
    ----------------------------------------------------------------------------
    traning_data_proc : process (clk_out_ser)
    begin
        if (rising_edge(clk_out_ser)) then
            if (reset_ser = '1') then
                din <= (others => '0');

            else
                if (ready = '1') then
                    din(11 downto bit_depth) <= din_ser(11 - bit_depth downto 0);

                else
                    din(11 downto bit_depth) <= test_pattern(11 - bit_depth downto 0);

                end if;
            end if;
        end if;
    end process;

    ----------------------------------------------------------------------------
    -- serializing_mux_proc : Samples output of serializer using a multiplexer
    ----------------------------------------------------------------------------
    serializing_mux_proc : process (sel, din)
    begin
        case sel is
            when"0000"  => din_deser <= din(11);
            when"0001"  => din_deser <= din(10);
            when"0010"  => din_deser <= din(9);
            when"0011"  => din_deser <= din(8);
            when"0100"  => din_deser <= din(7);
            when"0101"  => din_deser <= din(6);
            when"0110"  => din_deser <= din(5);
            when"0111"  => din_deser <= din(4);
            when"1000"  => din_deser <= din(3);
            when"1001"  => din_deser <= din(2);
            when"1010"  => din_deser <= din(1);
            when"1011"  => din_deser <= din(0);
            when others => din_deser <= '0';

        end case;
    end process;

end behavior;
