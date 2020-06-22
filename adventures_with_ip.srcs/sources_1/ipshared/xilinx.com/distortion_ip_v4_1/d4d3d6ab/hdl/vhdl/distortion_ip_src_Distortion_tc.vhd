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

ENTITY distortion_ip_src_Distortion_tc IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        enb_1_1_1                         :   OUT   std_logic;
        enb_80_1_0                        :   OUT   std_logic
        );
END distortion_ip_src_Distortion_tc;


ARCHITECTURE rtl OF distortion_ip_src_Distortion_tc IS

  -- Signals
  SIGNAL count80                          : unsigned(6 DOWNTO 0);  -- ufix7
  SIGNAL phase_1                          : std_logic;
  SIGNAL phase_1_tmp                      : std_logic;
  SIGNAL phase_all                        : std_logic;

BEGIN
  Counter80 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      count80 <= to_unsigned(1, 7);
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        IF count80 >= to_unsigned(79, 7) THEN
          count80 <= to_unsigned(0, 7);
        ELSE
          count80 <= count80 + to_unsigned(1, 7);
        END IF;
      END IF;
    END IF; 
  END PROCESS Counter80;

  temp_process1 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_1 <= '1';
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        phase_1 <= phase_1_tmp;
      END IF;
    END IF; 
  END PROCESS temp_process1;

  phase_1_tmp <= '1' WHEN count80 = to_unsigned(0, 7) AND clk_enable = '1' ELSE '0';

  phase_all <= '1' WHEN clk_enable = '1' ELSE '0';

  enb_1_1_1 <=  phase_1 AND clk_enable;

  enb_80_1_0 <=  phase_all AND clk_enable;


END rtl;

