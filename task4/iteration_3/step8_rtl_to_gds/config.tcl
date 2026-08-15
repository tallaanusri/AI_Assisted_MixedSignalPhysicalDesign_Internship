#=============================================================
# Task 4 - Iteration 3
# RTL-to-GDS integration of AMUX2_3V double-height hard macro
#=============================================================

set ::env(DESIGN_NAME) "design_mux"

#-------------------------------------------------------------
# RTL
#-------------------------------------------------------------
set ::env(VERILOG_FILES) "\
$::env(DESIGN_DIR)/src/design_mux.v \
$::env(DESIGN_DIR)/src/raven_spi.v \
$::env(DESIGN_DIR)/src/spi_slave.v \
$::env(DESIGN_DIR)/src/AMUX2_3V.v"

set ::env(SYNTH_READ_BLACKBOX_LIB) 1

#-------------------------------------------------------------
# Technology
#-------------------------------------------------------------
set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

#-------------------------------------------------------------
# Clock
#-------------------------------------------------------------
set ::env(CLOCK_PORT) "SCK"
set ::env(CLOCK_PERIOD) "10.0"

#-------------------------------------------------------------
# Floorplan
#-------------------------------------------------------------
set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0 0 200 200"

#-------------------------------------------------------------
# Analog hard macro
#-------------------------------------------------------------
set ::env(EXTRA_LEFS) \
    "$::env(DESIGN_DIR)/macro/AMUX2_3V.lef"

set ::env(EXTRA_LIBS) \
    "$::env(DESIGN_DIR)/macro/AMUX2_3V.lib"

set ::env(EXTRA_GDS_FILES) \
    "$::env(DESIGN_DIR)/macro/AMUX2_3V.gds"

#-------------------------------------------------------------
# Macro placement
#-------------------------------------------------------------
set ::env(MACRO_PLACEMENT_CFG) \
    "$::env(DESIGN_DIR)/macro.cfg"

#-------------------------------------------------------------
# Power
#-------------------------------------------------------------
set ::env(VDD_NETS) "VDD"
set ::env(GND_NETS) "VSS"

set ::env(VDD_PIN) "VDD"
set ::env(GND_PIN) "VSS"

#-------------------------------------------------------------
# Routing
#-------------------------------------------------------------
set ::env(GLB_RT_MAXLAYER) "met5"

#-------------------------------------------------------------
# Macro protection
#-------------------------------------------------------------
set ::env(PL_MACRO_HALO) "10 10"
set ::env(PL_MACRO_CHANNEL) "10 10"

#-------------------------------------------------------------
# Resizer
#-------------------------------------------------------------
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0

#-------------------------------------------------------------
# Diodes
#-------------------------------------------------------------
set ::env(DIODE_INSERTION_STRATEGY) 0

#-------------------------------------------------------------
# Macro power grid
#-------------------------------------------------------------
set ::env(FP_PDN_MACRO_HOOKS) "u_amux VDD VSS VDD VSS"
set ::env(FP_PDN_CFG) "$::env(DESIGN_DIR)/macro_pdn.tcl"
set ::env(FP_PDN_VPITCH) "10"
set ::env(FP_PDN_ENABLE_MACROS_GRID) 1

#-------------------------------------------------------------
# Avoid problematic post-synthesis STA in this environment
#-------------------------------------------------------------
set ::env(RUN_SSTA) 0

#=============================================================
