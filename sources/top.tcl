
################################################################
# This is a generated script based on design: top
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2017.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source top_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# ALU, ID, MUX2in, MUX2in, MUX, controller, extender, memory, memory, next_addr, pc, register_set_32

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg400-1
   set_property BOARD_PART tul.com.tw:pynq-z2:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name top

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:sim_clk_gen:1.0\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
ALU\
ID\
MUX2in\
MUX2in\
MUX\
controller\
extender\
memory\
memory\
next_addr\
pc\
register_set_32\
"

   set list_mods_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_msg_id "BD_TCL-008" "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set dataIn_0 [ create_bd_port -dir I -from 31 -to 0 dataIn_0 ]
  set dataOut_0 [ create_bd_port -dir O -from 31 -to 0 dataOut_0 ]
  set enable_true [ create_bd_port -dir I enable_true ]

  # Create instance: ALU_0, and set properties
  set block_name ALU
  set block_cell_name ALU_0
  if { [catch {set ALU_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ALU_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ID_0, and set properties
  set block_name ID
  set block_cell_name ID_0
  if { [catch {set ID_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ID_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: MUX2in_0, and set properties
  set block_name MUX2in
  set block_cell_name MUX2in_0
  if { [catch {set MUX2in_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $MUX2in_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: MUX2in_1, and set properties
  set block_name MUX2in
  set block_cell_name MUX2in_1
  if { [catch {set MUX2in_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $MUX2in_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: MUX_0, and set properties
  set block_name MUX
  set block_cell_name MUX_0
  if { [catch {set MUX_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $MUX_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: controller_0, and set properties
  set block_name controller
  set block_cell_name controller_0
  if { [catch {set controller_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $controller_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: extender_0, and set properties
  set block_name extender
  set block_cell_name extender_0
  if { [catch {set extender_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $extender_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: memory_0, and set properties
  set block_name memory
  set block_cell_name memory_0
  if { [catch {set memory_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $memory_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: memory_1, and set properties
  set block_name memory
  set block_cell_name memory_1
  if { [catch {set memory_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $memory_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: next_addr_0, and set properties
  set block_name next_addr
  set block_cell_name next_addr_0
  if { [catch {set next_addr_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $next_addr_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pc_0, and set properties
  set block_name pc
  set block_cell_name pc_0
  if { [catch {set pc_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pc_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: register_set_32_0, and set properties
  set block_name register_set_32
  set block_cell_name register_set_32_0
  if { [catch {set register_set_32_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $register_set_32_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sim_clk_gen_0, and set properties
  set sim_clk_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:sim_clk_gen:1.0 sim_clk_gen_0 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {50000000} \
 ] $sim_clk_gen_0

  # Create port connections
  connect_bd_net -net ALU_0_Result [get_bd_pins ALU_0/Result] [get_bd_pins MUX2in_0/in0] [get_bd_pins memory_1/address]
  connect_bd_net -net ALU_0_ZERO [get_bd_pins ALU_0/ZERO] [get_bd_pins next_addr_0/ZERO]
  connect_bd_net -net ID_0_fun [get_bd_pins ID_0/fun] [get_bd_pins controller_0/fun]
  connect_bd_net -net ID_0_op [get_bd_pins ID_0/op] [get_bd_pins controller_0/op]
  connect_bd_net -net ID_0_outIns [get_bd_pins ID_0/outIns] [get_bd_pins extender_0/instr]
  connect_bd_net -net ID_0_rd [get_bd_pins ID_0/rd] [get_bd_pins register_set_32_0/waddr]
  connect_bd_net -net ID_0_rs1 [get_bd_pins ID_0/rs1] [get_bd_pins register_set_32_0/raddr1]
  connect_bd_net -net ID_0_rs2 [get_bd_pins ID_0/rs2] [get_bd_pins register_set_32_0/raddr2]
  connect_bd_net -net MUX2in_0_out [get_bd_pins MUX2in_0/out] [get_bd_pins register_set_32_0/wdata]
  connect_bd_net -net MUX2in_1_out [get_bd_pins ALU_0/in_A] [get_bd_pins MUX2in_1/out]
  connect_bd_net -net MUX_0_out [get_bd_pins ALU_0/in_B] [get_bd_pins MUX_0/out]
  connect_bd_net -net controller_0_ALUAsrc [get_bd_pins MUX2in_1/select] [get_bd_pins controller_0/ALUAsrc]
  connect_bd_net -net controller_0_ALUBsrc [get_bd_pins MUX_0/select] [get_bd_pins controller_0/ALUBsrc]
  connect_bd_net -net controller_0_ALUctr [get_bd_pins ALU_0/ALUctr] [get_bd_pins controller_0/ALUctr]
  connect_bd_net -net controller_0_Branch [get_bd_pins controller_0/Branch] [get_bd_pins next_addr_0/Branch]
  connect_bd_net -net controller_0_ExtOp [get_bd_pins controller_0/ExtOp] [get_bd_pins extender_0/ExtOp]
  connect_bd_net -net controller_0_Jump [get_bd_pins controller_0/Jump] [get_bd_pins next_addr_0/Jump]
  connect_bd_net -net controller_0_MemWr [get_bd_pins controller_0/MemWr] [get_bd_pins memory_1/we]
  connect_bd_net -net controller_0_MemtoReg [get_bd_pins MUX2in_0/select] [get_bd_pins controller_0/MemtoReg]
  connect_bd_net -net controller_0_RegWr [get_bd_pins controller_0/RegWr] [get_bd_pins register_set_32_0/we]
  connect_bd_net -net dataIn_0_1 [get_bd_ports dataIn_0] [get_bd_pins memory_0/dataIn]
  connect_bd_net -net extender_0_imm [get_bd_pins MUX_0/in2] [get_bd_pins extender_0/imm] [get_bd_pins next_addr_0/imm]
  connect_bd_net -net memory_0_dataOut [get_bd_pins ID_0/instr] [get_bd_pins memory_0/dataOut]
  connect_bd_net -net memory_1_dataOut [get_bd_ports dataOut_0] [get_bd_pins MUX2in_0/in1] [get_bd_pins memory_1/dataOut]
  connect_bd_net -net next_addr_0_next_addr [get_bd_pins next_addr_0/next_addr] [get_bd_pins pc_0/next_addr]
  connect_bd_net -net pc_0_addr [get_bd_pins MUX2in_1/in1] [get_bd_pins memory_0/address] [get_bd_pins next_addr_0/addr] [get_bd_pins pc_0/addr]
  connect_bd_net -net register_set_32_0_rdata1 [get_bd_pins MUX2in_1/in0] [get_bd_pins register_set_32_0/rdata1]
  connect_bd_net -net register_set_32_0_rdata2 [get_bd_pins MUX_0/in0] [get_bd_pins memory_1/dataIn] [get_bd_pins register_set_32_0/rdata2]
  connect_bd_net -net sim_clk_gen_0_clk [get_bd_pins memory_0/clk] [get_bd_pins memory_1/clk] [get_bd_pins pc_0/clk] [get_bd_pins register_set_32_0/clk] [get_bd_pins sim_clk_gen_0/clk]
  connect_bd_net -net we_0_1 [get_bd_ports enable_true] [get_bd_pins memory_0/we] [get_bd_pins register_set_32_0/rst_n]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


