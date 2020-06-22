proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7z020clg484-1
  set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Zynk_Book/adventures_with_ip/adventures_with_ip.cache/wt [current_project]
  set_property parent.project_path C:/Zynk_Book/adventures_with_ip/adventures_with_ip.xpr [current_project]
  set_property ip_repo_paths {
  c:/Zynk_Book/adventures_with_ip/adventures_with_ip.cache/ip
  C:/Zynk_Book/ip_repo
} [current_project]
  set_property ip_output_repo c:/Zynk_Book/adventures_with_ip/adventures_with_ip.cache/ip [current_project]
  add_files -quiet C:/Zynk_Book/adventures_with_ip/adventures_with_ip.runs/synth_1/ip_design_wrapper.dcp
  read_xdc -ref ip_design_processing_system7_0_0 -cells inst c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_processing_system7_0_0/ip_design_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_processing_system7_0_0/ip_design_processing_system7_0_0.xdc]
  read_xdc -prop_thru_buffers -ref ip_design_rst_processing_system7_0_100M_0 c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_rst_processing_system7_0_100M_0/ip_design_rst_processing_system7_0_100M_0_board.xdc
  set_property processing_order EARLY [get_files c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_rst_processing_system7_0_100M_0/ip_design_rst_processing_system7_0_100M_0_board.xdc]
  read_xdc -ref ip_design_rst_processing_system7_0_100M_0 c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_rst_processing_system7_0_100M_0/ip_design_rst_processing_system7_0_100M_0.xdc
  set_property processing_order EARLY [get_files c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_rst_processing_system7_0_100M_0/ip_design_rst_processing_system7_0_100M_0.xdc]
  read_xdc -prop_thru_buffers -ref ip_design_axi_gpio_0_0 -cells U0 c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_axi_gpio_0_0/ip_design_axi_gpio_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_axi_gpio_0_0/ip_design_axi_gpio_0_0_board.xdc]
  read_xdc -ref ip_design_axi_gpio_0_0 -cells U0 c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_axi_gpio_0_0/ip_design_axi_gpio_0_0.xdc
  set_property processing_order EARLY [get_files c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_axi_gpio_0_0/ip_design_axi_gpio_0_0.xdc]
  read_xdc -prop_thru_buffers -ref ip_design_axi_gpio_1_0 -cells U0 c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_axi_gpio_1_0/ip_design_axi_gpio_1_0_board.xdc
  set_property processing_order EARLY [get_files c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_axi_gpio_1_0/ip_design_axi_gpio_1_0_board.xdc]
  read_xdc -ref ip_design_axi_gpio_1_0 -cells U0 c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_axi_gpio_1_0/ip_design_axi_gpio_1_0.xdc
  set_property processing_order EARLY [get_files c:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/sources_1/bd/ip_design/ip/ip_design_axi_gpio_1_0/ip_design_axi_gpio_1_0.xdc]
  read_xdc C:/Zynk_Book/adventures_with_ip/adventures_with_ip.srcs/constrs_1/imports/constraints/adventures_with_ip.xdc
  link_design -top ip_design_wrapper -part xc7z020clg484-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force ip_design_wrapper_opt.dcp
  catch {report_drc -file ip_design_wrapper_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file ip_design_wrapper.hwdef}
  place_design -directive SSI_ExtraTimingOpt
  write_checkpoint -force ip_design_wrapper_placed.dcp
  catch { report_io -file ip_design_wrapper_io_placed.rpt }
  catch { report_utilization -file ip_design_wrapper_utilization_placed.rpt -pb ip_design_wrapper_utilization_placed.pb }
  catch { report_control_sets -verbose -file ip_design_wrapper_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step phys_opt_design
set rc [catch {
  create_msg_db phys_opt_design.pb
  phys_opt_design 
  write_checkpoint -force ip_design_wrapper_physopt.dcp
  close_msg_db -file phys_opt_design.pb
} RESULT]
if {$rc} {
  step_failed phys_opt_design
  return -code error $RESULT
} else {
  end_step phys_opt_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design -directive NoTimingRelaxation
  write_checkpoint -force ip_design_wrapper_routed.dcp
  catch { report_drc -file ip_design_wrapper_drc_routed.rpt -pb ip_design_wrapper_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file ip_design_wrapper_timing_summary_routed.rpt -rpx ip_design_wrapper_timing_summary_routed.rpx }
  catch { report_power -file ip_design_wrapper_power_routed.rpt -pb ip_design_wrapper_power_summary_routed.pb }
  catch { report_route_status -file ip_design_wrapper_route_status.rpt -pb ip_design_wrapper_route_status.pb }
  catch { report_clock_utilization -file ip_design_wrapper_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force ip_design_wrapper.bit 
  catch { write_sysdef -hwdef ip_design_wrapper.hwdef -bitfile ip_design_wrapper.bit -meminfo ip_design_wrapper.mmi -ltxfile debug_nets.ltx -file ip_design_wrapper.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

