
#-------------------------------------------------------------
# OpenLane Configuration File for design_mux
#-------------------------------------------------------------

# Top-level design name
set ::env(DESIGN_NAME) "design_mux"

# RTL source files
# Only the digital wrapper is synthesized.
# The analog macro is treated as a hard macro.
set ::env(VERILOG_FILES) "\
$::env(DESIGN_DIR)/src/design_mux.v \
$::env(DESIGN_DIR)/src/raven_spi.v \
$::env(DESIGN_DIR)/src/spi_slave.v \
$::env(DESIGN_DIR)/src/AMUX2_3V.v"
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
#-------------------------------------------------------------
# Technology Configuration
#-------------------------------------------------------------

# Process Design Kit
set ::env(PDK) "sky130A"

# Standard cell library
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

#-------------------------------------------------------------
# Clock Configuration
#-------------------------------------------------------------

# Clock input port
set ::env(CLOCK_PORT) "SCK"
# Clock period (ns)
set ::env(CLOCK_PERIOD) "10.0"

#-------------------------------------------------------------
# Floorplan Configuration
#-------------------------------------------------------------

# Absolute floorplan sizing
set ::env(FP_SIZING) "absolute"

# Die area (LLX LLY URX URY)
# Sized to accommodate one analog macro
# and a small amount of digital logic.
set ::env(DIE_AREA) "0 0 200 200"

#-------------------------------------------------------------
# Analog Hard Macro Configuration
#-------------------------------------------------------------

# Physical abstract of the analog macro
set ::env(EXTRA_LEFS) \
    "$::env(DESIGN_DIR)/macro/AMUX2_3V.lef"

# Timing model of the analog macro
set ::env(EXTRA_LIBS) \
    "$::env(DESIGN_DIR)/macro/AMUX2_3V.lib"

# Physical layout used during final GDS merge
set ::env(EXTRA_GDS_FILES) \
    "$::env(DESIGN_DIR)/macro/AMUX2_3V.gds"

#-------------------------------------------------------------
# Macro Placement
#-------------------------------------------------------------

# Fixed placement coordinates for the analog macro
set ::env(MACRO_PLACEMENT_CFG) \
    "$::env(DESIGN_DIR)/macro.cfg"

#-------------------------------------------------------------
# Power Distribution Network
#-------------------------------------------------------------

# Vertical PDN pitch
set ::env(FP_PDN_VPITCH) "153.6"

# Horizontal PDN pitch
set ::env(FP_PDN_HPITCH) "153.18"

#-------------------------------------------------------------
# Routing Configuration
#-------------------------------------------------------------

# Maximum routing layer
set ::env(GLB_RT_MAXLAYER) "5"
# Disable resizer optimization for analog macro
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
# -------------------------------------------------------------
# Analog Macro Settings
# -------------------------------------------------------------

# Prevent placement optimizations around the macro
set ::env(PL_MACRO_HALO) "10 10"
set ::env(PL_MACRO_CHANNEL) "10 10"

# Disable diode insertion
set ::env(DIODE_INSERTION_STRATEGY) 0

# Enable macro power grid
set ::env(FP_PDN_ENABLE_MACROS_GRID) 1

# Connect macro power pins
set ::env(FP_PDN_MACRO_HOOKS) "u_amux VDD VSS VDD VSS"
