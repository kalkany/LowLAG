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

ENTITY distortion_ip_src_Distortion IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        Fin                               :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        ce_out                            :   OUT   std_logic;
        Fout                              :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END distortion_ip_src_Distortion;


ARCHITECTURE rtl OF distortion_ip_src_Distortion IS

  -- Component Declarations
  COMPONENT distortion_ip_src_Distortion_tc
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          enb_1_1_1                       :   OUT   std_logic;
          enb_80_1_0                      :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : distortion_ip_src_Distortion_tc
    USE ENTITY work.distortion_ip_src_Distortion_tc(rtl);

  -- Signals
  SIGNAL enb_1_1_1                        : std_logic;
  SIGNAL enb_80_1_0                       : std_logic;
  SIGNAL Fin_signed                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Gain2_mul_temp                   : signed(31 DOWNTO 0);  -- sfix32_En31
  SIGNAL Gain2_out1                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Gain_mul_temp                    : signed(31 DOWNTO 0);  -- sfix32_En25
  SIGNAL Gain_out1                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Saturation1_out1                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Add_out1                         : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  u_Distortion_tc : distortion_ip_src_Distortion_tc
    PORT MAP( clk => clk,
              reset => reset,
              clk_enable => clk_enable,
              enb_1_1_1 => enb_1_1_1,
              enb_80_1_0 => enb_80_1_0
              );

  Fin_signed <= signed(Fin);

  Gain2_mul_temp <= to_signed(16#6666#, 16) * Fin_signed;
  Gain2_out1 <= resize(Gain2_mul_temp(31 DOWNTO 17), 16);

  Gain_mul_temp <= to_signed(16#6000#, 16) * Fin_signed;
  Gain_out1 <= Gain_mul_temp(26 DOWNTO 11);

  
  Saturation1_out1 <= to_signed(16#0333#, 16) WHEN Gain_out1 > to_signed(16#0333#, 16) ELSE
      to_signed(-16#0333#, 16) WHEN Gain_out1 < to_signed(-16#0333#, 16) ELSE
      Gain_out1;

  Add_out1 <= Gain2_out1 + Saturation1_out1;

  Fout <= std_logic_vector(Add_out1);

  ce_out <= enb_1_1_1;

END rtl;

