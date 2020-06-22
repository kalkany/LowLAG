-- This file has created for SoC Design Lecture Project named LowLAG. 
-- It desires reduce the latency between input and output of and audio. 
-- In this IP block basic distortion effect is used for audio processing.
-- 
-- If you have any question, please contact with me.
-- 
-- Author: Yunus Emre ESEN
-- Email: esenyunusemre@gmail.com


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY distortion_ip_addr_decoder IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        data_write                        :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        addr_sel                          :   IN    std_logic_vector(13 DOWNTO 0);  -- ufix14
        wr_enb                            :   IN    std_logic;  -- ufix1
        rd_enb                            :   IN    std_logic;  -- ufix1
        read_cop_out_ready                :   IN    std_logic;  -- ufix1
        read_ip_timestamp                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        cop_reg_strobe                    :   IN    std_logic;  -- ufix1
        read_Fout                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        data_read                         :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_axi_enable                  :   OUT   std_logic;  -- ufix1
        strobe_cop_in_strobe              :   OUT   std_logic;  -- ufix1
        write_Fin                         :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END distortion_ip_addr_decoder;


ARCHITECTURE rtl OF distortion_ip_addr_decoder IS

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL addr_sel_unsigned                : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL decode_sel_cop_out_ready         : std_logic;  -- ufix1
  SIGNAL const_1                          : std_logic;  -- ufix1
  SIGNAL read_ip_timestamp_unsigned       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_Fout_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL decode_sel_Fout                  : std_logic;  -- ufix1
  SIGNAL decode_sel_ip_timestamp          : std_logic;  -- ufix1
  SIGNAL const_0                          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_cop_out_ready           : std_logic;  -- ufix1
  SIGNAL data_in_cop_out_ready            : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_cop_out_ready          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_ip_timestamp            : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_ip_timestamp           : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL sync_reg_Fout                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL data_in_Fout                     : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Fout                   : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_sel_axi_enable            : std_logic;  -- ufix1
  SIGNAL reg_enb_axi_enable               : std_logic;  -- ufix1
  SIGNAL data_write_unsigned              : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL data_in_axi_enable               : std_logic;  -- ufix1
  SIGNAL write_reg_axi_enable             : std_logic;  -- ufix1
  SIGNAL decode_sel_cop_in_strobe         : std_logic;  -- ufix1
  SIGNAL strobe_sel_cop_in_strobe         : std_logic;  -- ufix1
  SIGNAL const_zero                       : std_logic;  -- ufix1
  SIGNAL strobe_in_cop_in_strobe          : std_logic;  -- ufix1
  SIGNAL strobe_sw_cop_in_strobe          : std_logic;  -- ufix1
  SIGNAL strobe_reg_cop_in_strobe         : std_logic;  -- ufix1
  SIGNAL decode_sel_Fin                   : std_logic;  -- ufix1
  SIGNAL reg_enb_Fin                      : std_logic;  -- ufix1
  SIGNAL data_in_Fin                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL write_reg_Fin                    : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  addr_sel_unsigned <= unsigned(addr_sel);

  
  decode_sel_cop_out_ready <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0003#, 14) ELSE
      '0';

  const_1 <= '1';

  enb <= const_1;

  read_ip_timestamp_unsigned <= unsigned(read_ip_timestamp);

  read_Fout_signed <= signed(read_Fout);

  
  decode_sel_Fout <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0041#, 14) ELSE
      '0';

  
  decode_sel_ip_timestamp <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0004#, 14) ELSE
      '0';

  const_0 <= to_unsigned(0, 32);

  reg_cop_out_ready_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      read_reg_cop_out_ready <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        read_reg_cop_out_ready <= read_cop_out_ready;
      END IF;
    END IF;
  END PROCESS reg_cop_out_ready_process;


  data_in_cop_out_ready <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & read_reg_cop_out_ready;

  
  decode_rd_cop_out_ready <= const_0 WHEN decode_sel_cop_out_ready = '0' ELSE
      data_in_cop_out_ready;

  reg_ip_timestamp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      read_reg_ip_timestamp <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        read_reg_ip_timestamp <= read_ip_timestamp_unsigned;
      END IF;
    END IF;
  END PROCESS reg_ip_timestamp_process;


  
  decode_rd_ip_timestamp <= decode_rd_cop_out_ready WHEN decode_sel_ip_timestamp = '0' ELSE
      read_reg_ip_timestamp;

  reg_Fout_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      sync_reg_Fout <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND cop_reg_strobe = '1' THEN
        sync_reg_Fout <= read_Fout_signed;
      END IF;
    END IF;
  END PROCESS reg_Fout_process;


  data_in_Fout <= unsigned(resize(sync_reg_Fout, 32));

  
  decode_rd_Fout <= decode_rd_ip_timestamp WHEN decode_sel_Fout = '0' ELSE
      data_in_Fout;

  data_read <= std_logic_vector(decode_rd_Fout);

  
  decode_sel_axi_enable <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0001#, 14) ELSE
      '0';

  reg_enb_axi_enable <= decode_sel_axi_enable AND wr_enb;

  data_write_unsigned <= unsigned(data_write);

  data_in_axi_enable <= data_write_unsigned(0);

  reg_axi_enable_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      write_reg_axi_enable <= '1';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_axi_enable = '1' THEN
        write_reg_axi_enable <= data_in_axi_enable;
      END IF;
    END IF;
  END PROCESS reg_axi_enable_process;


  write_axi_enable <= write_reg_axi_enable;

  
  decode_sel_cop_in_strobe <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0002#, 14) ELSE
      '0';

  strobe_sel_cop_in_strobe <= decode_sel_cop_in_strobe AND wr_enb;

  const_zero <= '0';

  strobe_in_cop_in_strobe <= data_write_unsigned(0);

  
  strobe_sw_cop_in_strobe <= const_zero WHEN strobe_sel_cop_in_strobe = '0' ELSE
      strobe_in_cop_in_strobe;

  reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      strobe_reg_cop_in_strobe <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        strobe_reg_cop_in_strobe <= strobe_sw_cop_in_strobe;
      END IF;
    END IF;
  END PROCESS reg_process;


  strobe_cop_in_strobe <= strobe_reg_cop_in_strobe;

  
  decode_sel_Fin <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0040#, 14) ELSE
      '0';

  reg_enb_Fin <= decode_sel_Fin AND wr_enb;

  data_in_Fin <= signed(data_write_unsigned(15 DOWNTO 0));

  reg_Fin_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      write_reg_Fin <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Fin = '1' THEN
        write_reg_Fin <= data_in_Fin;
      END IF;
    END IF;
  END PROCESS reg_Fin_process;


  write_Fin <= std_logic_vector(write_reg_Fin);

END rtl;

