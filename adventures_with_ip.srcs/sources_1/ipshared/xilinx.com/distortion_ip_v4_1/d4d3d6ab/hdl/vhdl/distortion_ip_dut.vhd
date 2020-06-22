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

ENTITY distortion_ip_dut IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        dut_enable                        :   IN    std_logic;  -- ufix1
        Fin                               :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        ce_out                            :   OUT   std_logic;  -- ufix1
        Fout                              :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END distortion_ip_dut;


ARCHITECTURE rtl OF distortion_ip_dut IS

  -- Component Declarations
  COMPONENT distortion_ip_src_Distortion
    PORT( clk                             :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          reset                           :   IN    std_logic;
          Fin                             :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          ce_out                          :   OUT   std_logic;  -- ufix1
          Fout                            :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : distortion_ip_src_Distortion
    USE ENTITY work.distortion_ip_src_Distortion(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL Fout_sig                         : std_logic_vector(15 DOWNTO 0);  -- ufix16

BEGIN
  u_distortion_ip_src_Distortion : distortion_ip_src_Distortion
    PORT MAP( clk => clk,
              clk_enable => enb,
              reset => reset,
              Fin => Fin,  -- sfix16_En14
              ce_out => ce_out_sig,  -- ufix1
              Fout => Fout_sig  -- sfix16_En14
              );

  enb <= dut_enable;

  ce_out <= ce_out_sig;

  Fout <= Fout_sig;

END rtl;

