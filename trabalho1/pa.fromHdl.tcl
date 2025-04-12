
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name ula2 -dir "/home/sd/Documents/ula2/planAhead_run_1" -part xc3s700anfgg484-5
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "ula2.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {ula2.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top ula2 $srcset
add_files [list {ula2.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s700anfgg484-5
