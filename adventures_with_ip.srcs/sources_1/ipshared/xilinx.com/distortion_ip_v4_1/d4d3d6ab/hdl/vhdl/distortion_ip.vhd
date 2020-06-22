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

ENTITY distortion_ip IS
  PORT( IPCORE_CLK                        :   IN    std_logic;  -- ufix1
        IPCORE_RESETN                     :   IN    std_logic;  -- ufix1
        AXI4_Lite_ACLK                    :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARESETN                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_AWADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_AWVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_WDATA                   :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_WSTRB                   :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        AXI4_Lite_WVALID                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_BREADY                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_ARVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_RREADY                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_AWREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_WREADY                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_BRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_BVALID                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_ARREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_RDATA                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_RRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_RVALID                  :   OUT   std_logic  -- ufix1
        );
END distortion_ip;


ARCHITECTURE rtl OF distortion_ip IS

  -- Component Declarations
  COMPONENT distortion_ip_dut
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          dut_enable                      :   IN    std_logic;  -- ufix1
          Fin                             :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          ce_out                          :   OUT   std_logic;  -- ufix1
          Fout                            :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  COMPONENT distortion_ip_cop
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          in_strobe                       :   IN    std_logic;  -- ufix1
          cop_enable                      :   IN    std_logic;  -- ufix1
          out_ready                       :   OUT   std_logic;  -- ufix1
          dut_enable                      :   OUT   std_logic;  -- ufix1
          reg_strobe                      :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT distortion_ip_axi_lite
    PORT( reset                           :   IN    std_logic;
          AXI4_Lite_ACLK                  :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARESETN               :   IN    std_logic;  -- ufix1
          AXI4_Lite_AWADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_AWVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_WDATA                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_WSTRB                 :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
          AXI4_Lite_WVALID                :   IN    std_logic;  -- ufix1
          AXI4_Lite_BREADY                :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_ARVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_RREADY                :   IN    std_logic;  -- ufix1
          read_cop_out_ready              :   IN    std_logic;  -- ufix1
          read_ip_timestamp               :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          cop_reg_strobe                  :   IN    std_logic;  -- ufix1
          read_Fout                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          AXI4_Lite_AWREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_WREADY                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_BRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_BVALID                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_ARREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_RDATA                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_RRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_RVALID                :   OUT   std_logic;  -- ufix1
          write_axi_enable                :   OUT   std_logic;  -- ufix1
          strobe_cop_in_strobe            :   OUT   std_logic;  -- ufix1
          write_Fin                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          reset_internal                  :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : distortion_ip_dut
    USE ENTITY work.distortion_ip_dut(rtl);

  FOR ALL : distortion_ip_cop
    USE ENTITY work.distortion_ip_cop(rtl);

  FOR ALL : distortion_ip_axi_lite
    USE ENTITY work.distortion_ip_axi_lite(rtl);

  -- Signals
  SIGNAL reset                            : std_logic;
  SIGNAL reset_cm                         : std_logic;  -- ufix1
  SIGNAL ip_timestamp                     : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL cop_dut_enable                   : std_logic;  -- ufix1
  SIGNAL write_Fin                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL Fout_sig                         : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL reset_internal                   : std_logic;  -- ufix1
  SIGNAL strobe_cop_in_strobe             : std_logic;  -- ufix1
  SIGNAL write_axi_enable                 : std_logic;  -- ufix1
  SIGNAL cop_out_ready                    : std_logic;  -- ufix1
  SIGNAL cop_reg_strobe                   : std_logic;  -- ufix1
  SIGNAL AXI4_Lite_BRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL AXI4_Lite_RDATA_tmp              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL AXI4_Lite_RRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2

BEGIN
  u_distortion_ip_dut_inst : distortion_ip_dut
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              dut_enable => cop_dut_enable,  -- ufix1
              Fin => write_Fin,  -- sfix16_En14
              ce_out => ce_out_sig,  -- ufix1
              Fout => Fout_sig  -- sfix16_En14
              );

  u_distortion_ip_cop_inst : distortion_ip_cop
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              in_strobe => strobe_cop_in_strobe,  -- ufix1
              cop_enable => write_axi_enable,  -- ufix1
              out_ready => cop_out_ready,  -- ufix1
              dut_enable => cop_dut_enable,  -- ufix1
              reg_strobe => cop_reg_strobe  -- ufix1
              );

  u_distortion_ip_axi_lite_inst : distortion_ip_axi_lite
    PORT MAP( reset => reset,
              AXI4_Lite_ACLK => AXI4_Lite_ACLK,  -- ufix1
              AXI4_Lite_ARESETN => AXI4_Lite_ARESETN,  -- ufix1
              AXI4_Lite_AWADDR => AXI4_Lite_AWADDR,  -- ufix16
              AXI4_Lite_AWVALID => AXI4_Lite_AWVALID,  -- ufix1
              AXI4_Lite_WDATA => AXI4_Lite_WDATA,  -- ufix32
              AXI4_Lite_WSTRB => AXI4_Lite_WSTRB,  -- ufix4
              AXI4_Lite_WVALID => AXI4_Lite_WVALID,  -- ufix1
              AXI4_Lite_BREADY => AXI4_Lite_BREADY,  -- ufix1
              AXI4_Lite_ARADDR => AXI4_Lite_ARADDR,  -- ufix16
              AXI4_Lite_ARVALID => AXI4_Lite_ARVALID,  -- ufix1
              AXI4_Lite_RREADY => AXI4_Lite_RREADY,  -- ufix1
              read_cop_out_ready => cop_out_ready,  -- ufix1
              read_ip_timestamp => std_logic_vector(ip_timestamp),  -- ufix32
              cop_reg_strobe => strobe_cop_in_strobe,  -- ufix1
              read_Fout => Fout_sig,  -- sfix16_En14
              AXI4_Lite_AWREADY => AXI4_Lite_AWREADY,  -- ufix1
              AXI4_Lite_WREADY => AXI4_Lite_WREADY,  -- ufix1
              AXI4_Lite_BRESP => AXI4_Lite_BRESP_tmp,  -- ufix2
              AXI4_Lite_BVALID => AXI4_Lite_BVALID,  -- ufix1
              AXI4_Lite_ARREADY => AXI4_Lite_ARREADY,  -- ufix1
              AXI4_Lite_RDATA => AXI4_Lite_RDATA_tmp,  -- ufix32
              AXI4_Lite_RRESP => AXI4_Lite_RRESP_tmp,  -- ufix2
              AXI4_Lite_RVALID => AXI4_Lite_RVALID,  -- ufix1
              write_axi_enable => write_axi_enable,  -- ufix1
              strobe_cop_in_strobe => strobe_cop_in_strobe,  -- ufix1
              write_Fin => write_Fin,  -- sfix16_En14
              reset_internal => reset_internal  -- ufix1
              );

  reset_cm <=  NOT IPCORE_RESETN;

  ip_timestamp <= to_unsigned(2006221951, 32);

  reset <= reset_cm OR reset_internal;

  AXI4_Lite_BRESP <= AXI4_Lite_BRESP_tmp;

  AXI4_Lite_RDATA <= AXI4_Lite_RDATA_tmp;

  AXI4_Lite_RRESP <= AXI4_Lite_RRESP_tmp;

END rtl;

