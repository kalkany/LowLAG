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

ENTITY distortion_ip_cop IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        in_strobe                         :   IN    std_logic;  -- ufix1
        cop_enable                        :   IN    std_logic;  -- ufix1
        out_ready                         :   OUT   std_logic;  -- ufix1
        dut_enable                        :   OUT   std_logic;  -- ufix1
        reg_strobe                        :   OUT   std_logic  -- ufix1
        );
END distortion_ip_cop;


ARCHITECTURE rtl OF distortion_ip_cop IS

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL cp_controller_cpstate            : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL cp_controller_clkcnt             : unsigned(6 DOWNTO 0);  -- ufix7
  SIGNAL cp_controller_cpstate_next       : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL cp_controller_clkcnt_next        : unsigned(6 DOWNTO 0);  -- ufix7

BEGIN
  enb <= cop_enable;

  cp_controller_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cp_controller_cpstate <= to_unsigned(16#00#, 8);
      cp_controller_clkcnt <= to_unsigned(16#00#, 7);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        cp_controller_cpstate <= cp_controller_cpstate_next;
        cp_controller_clkcnt <= cp_controller_clkcnt_next;
      END IF;
    END IF;
  END PROCESS cp_controller_process;

  cp_controller_output : PROCESS (cp_controller_clkcnt, cp_controller_cpstate, in_strobe)
    VARIABLE clkcnt_temp : unsigned(6 DOWNTO 0);
  BEGIN
    cp_controller_cpstate_next <= cp_controller_cpstate;
    CASE cp_controller_cpstate IS
      WHEN "00000000" =>
        out_ready <= '1';
        dut_enable <= '0';
        reg_strobe <= '0';
        clkcnt_temp := to_unsigned(16#00#, 7);
        IF in_strobe /= '0' THEN 
          cp_controller_cpstate_next <= to_unsigned(16#01#, 8);
        ELSE 
          cp_controller_cpstate_next <= to_unsigned(16#00#, 8);
        END IF;
      WHEN "00000001" =>
        out_ready <= '0';
        dut_enable <= '1';
        reg_strobe <= '0';
        clkcnt_temp := cp_controller_clkcnt + to_unsigned(16#01#, 7);
        IF clkcnt_temp = to_unsigned(16#50#, 7) THEN 
          cp_controller_cpstate_next <= to_unsigned(16#02#, 8);
        ELSE 
          cp_controller_cpstate_next <= to_unsigned(16#01#, 8);
        END IF;
      WHEN "00000010" =>
        out_ready <= '0';
        dut_enable <= '0';
        reg_strobe <= '1';
        clkcnt_temp := to_unsigned(16#00#, 7);
        cp_controller_cpstate_next <= to_unsigned(16#00#, 8);
      WHEN OTHERS => 
        out_ready <= '0';
        dut_enable <= '0';
        reg_strobe <= '0';
        clkcnt_temp := to_unsigned(16#00#, 7);
        cp_controller_cpstate_next <= to_unsigned(16#00#, 8);
    END CASE;
    cp_controller_clkcnt_next <= clkcnt_temp;
  END PROCESS cp_controller_output;


END rtl;

