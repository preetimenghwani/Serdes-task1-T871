# Serdes-task1-T871
Implemented a deserializer( serial to parallel convertor ) with the following features:
1. Supports bit depth of 8bit, 10bit, 12bit
   depth_sel="000" => 12bit
   depth_sel="010" => 10bit
   depth_sel="100" => 12bit
2. Adjusted Bitslip
   A test pattern "OxBAF" is used for adjusting bitslip, as soon as the model is ready to trained and ready to take input from    the user the link_trained signal switches to '1'
3. DDR Implementation
   The current deserializer works properly for 600Mhz clock speed(DDR) in post-route simulation of Zynq-7020 FPGA with            serializer in testbench.
