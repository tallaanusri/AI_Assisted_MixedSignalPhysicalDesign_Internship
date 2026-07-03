# AI-Assisted RTL-to-GDS Mixed-Signal Physical Design Exploration Using OpenLane & SKY130
---
## 🎯 Goal

The goal of this project is to explore and understand the **AI-Assisted RTL-to-GDS Mixed-Signal Physical Design Exploration Using OpenLane & SKY130** by studying the reference **vsdmixedsignalflow** repository and reproducing its workflow using AI-assisted methodologies rather than directly copying the implementation.

This project demonstrates how AI tools can support engineers throughout the complete mixed-signal physical design process by assisting in:

✅ Understanding the repository structure and design flow

✅ Setting up the required tools and open-source PDKs (OpenLane & SKY130)

✅ Identifying and analyzing the required design inputs (Verilog, LEF, LIB, GDS)

✅ Understanding analog macro integration into a digital design

✅ Configuring and executing the OpenLane physical design flow

✅ Debugging synthesis, placement, routing, and DRC-related issues

✅ Verifying generated layouts and documenting observations

✅ Preparing an AI-assisted IEEE-format technical report summarizing the workflow, results, challenges, and future work

The primary objective is to demonstrate how AI can accelerate learning, problem-solving, and documentation in ASIC physical design while ensuring that every AI-generated solution is independently verified through practical experimentation.

---

## Stage 1 -Analysis of **vsdmixedsignalflow** Repository:
---
# Objective:

To Understand the Repository:
**[https://github.com/praharshapm/vsdmixedsignalflow](https://github.com/praharshapm/vsdmixedsignalflow)**
The first thing to do is **NOT** install anything, Instead of it we have to understand what the repository contains.

# Basic Prompt-

```
I am learning mixed-signal physical design.

Please explain this repository like I am a beginner.

Repository:
https://github.com/praharshapm/vsdmixedsignalflow

Explain:

1. Overall objective
2. Folder structure
3. Flow of execution
4. Input files
5. Output files
6. Which OpenLane stages are performed
7. Where analog macro integration happens
8. Explain every important file in simple language.
```
Then my ChatGPT improved my prompt and given me the following Advanced Prompt for better Result.

# Advanced Prompt – 
```
I am a beginner in mixed-signal ASIC physical design and I am performing Week 1 of my AI-Assisted Analog, Mixed-Signal & FPGA Internship.

Please analyze the following GitHub repository and explain it in a beginner-friendly but technically accurate manner.

**Repository:**
https://github.com/praharshapm/vsdmixedsignalflow

Please explain the repository in the following order:

## 1. Project Overview

* What is the objective of this repository?
* What problem does it solve?
* Why is mixed-signal physical design important?

## 2. Repository Structure

Explain each folder and file:

* What is its purpose?
* Why is it needed?
* At which stage of the flow is it used?

## 3. Complete Design Flow

Explain the complete RTL-to-GDS flow step by step:

* RTL (Verilog)
* Synthesis
* Floorplanning
* Analog Macro Integration
* Placement
* Power Distribution Network (PDN)
* Clock Tree Synthesis (CTS)
* Routing
* DRC/LVS
* GDSII Generation

For every stage, explain:

* What happens?
* Which tool performs it?
* What files are used as input?
* What files are generated as output?

## 4. Important Design Files

Explain these file types in simple language:

* Verilog (.v)
* LEF
* LIB
* DEF
* GDS
* SDC
* OpenLane configuration files
* TCL scripts

Also explain why each file is required.

## 5. Analog Macro Integration

Explain:

* What is an analog macro?
* Why can't analog blocks be synthesized?
* How are LEF, LIB, and GDS used to integrate an analog macro into a digital design?

## 6. OpenLane Configuration

Identify the configuration files used in this repository and explain every important parameter, including:

* Design name
* Clock period
* Die area
* Core area
* Macro placement
* LEF/LIB inclusion
* PDN settings

## 7. Expected Outputs

List all important outputs generated during the flow, including:

* Netlist
* DEF
* Reports
* GDSII
* Logs
* Screenshots (if applicable)

Explain what each output represents.

## 8. Learning Summary

Finally, summarize:

* What concepts I should learn from this repository.
* Which parts are digital.
* Which parts are mixed-signal.
* Common beginner mistakes.
* Tips for successfully reproducing this flow using OpenLane and SKY130.

Please explain everything in simple language with diagrams or flowcharts wherever possible.
```
# Output :

ChatGPT Output File :- [MixedSignalFlow_Overview](MixedSignalFlow_Overview/README.md)
This alone will save hours Of time and It also Given the basic & Clear understanding of the overall **vsdmixedsignalflow** repository.

# Conclusion at Stage 1:

Actually Using AI in this Stage helped in saving the time as well as after reading the AI version of the repository,It became easy in understading all the things in repostary very well.Here,at this Stage AI done a great a job and It helps In learning the new Concepts easily even to beginner level Candidate.

---
## Stage 2 - Analysing about required input files:
---

# Objective :

After Understanding on the overall **vsdmixedsignalflow** repository & Its Project Problem Statement Instead of running OpenLane,I wanted to understand what are The files exist In this project  why , where there are used in the flow, and what may happen if any of file was missing and what Problem It leads to the whole project e.t.c.
So,Instead of directly using the files from the reference repository, I used AI to analyze the mixed-signal design Flow and It requirements.

# Prompt:
 ```
The project describes how the PNR of an analog IP, 2:1 analog multiplexer is carried out by opensource EDA tools, Openlane. It also discusses the steps to modify the current IP layouts in order to ensure its acceptance by the EDA tools.
I am a beginner in OpenLane and analog physical design, so explain everything from first principles with clear examples and diagrams wherever appropriate,for this project .so could you please give me the all basic input files required to do .
 * list the all input files required in it. 
 * what happened if any one of the file missed and how this missing file may lead problem to whole project 
 * also describe the stages at which the respective file is used.
 * describe how each individual file is involved in this project .
```
# 📂 AI Generated Required Input Files :

| **File / Directory** | **Example** | **Purpose** | **Used In Stage(s)** |
|-----------------------|-------------|-------------|----------------------|
| **Process Design Kit (PDK)** | `sky130A/` | Provides technology information including device models, DRC/LVS rules, standard-cell libraries, layer definitions, and process parameters required by all EDA tools. | Entire Flow (Layout, LEF Generation, Floorplanning, Placement, Routing, DRC, LVS, GDS Generation) |
| **Technology LEF** | `tech.lef` | Defines routing layers, via definitions, manufacturing grid, routing tracks, and technology-specific physical information. | Floorplanning, Placement, Routing |
| **SPICE Netlist** | `mux.spice` | Describes the transistor-level circuit connectivity of the analog multiplexer and serves as the reference schematic for verification. | Circuit Verification, LVS, Circuit Simulation |
| **Magic Layout File** | `mux.mag`, `21muxlayout.mag` | Stores the complete transistor-level physical layout of the analog IP designed in Magic. | Layout Editing, LEF Generation, GDS Generation |
| **Macro LEF** | `AMUX2_3V.lef` | Provides an abstract physical representation of the analog macro including cell size, pin locations, routing blockages, and placement boundaries. | Floorplanning, Macro Placement, Routing |
| **Liberty File** | `AMUX2_3V.lib` | Contains timing, delay, capacitance, transition, and power information used for timing analysis of the analog macro. | Static Timing Analysis (STA), Timing Optimization |
| **Verilog Top Module** | `design_mux.v` | Defines the top-level design that instantiates the analog macro and connects it with the surrounding digital logic. | OpenLane Initialization, Design Integration |
| **Analog Macro Verilog** | `AMUX2_3V.v` | Provides the logical or black-box representation of the analog macro for synthesis and RTL compilation. | RTL Compilation, Macro Integration |
| **OpenLane Configuration File** | `config.tcl` | Specifies the design name, PDK, LEF, Liberty files, Verilog sources, clock settings, and flow parameters required by OpenLane. | OpenLane Flow Initialization |
| **Flow Script** | `flow.tcl` | Controls the execution of the OpenLane flow by invoking floorplanning, placement, routing, verification, and GDS generation steps. | Entire OpenLane Flow |
| **Magic Technology File** | `sky130A.tech` | Contains technology-specific layer definitions, design rules, and extraction parameters used by Magic. | Layout Editing, DRC, Extraction |
| **Standard Cell LEF** | `sky130_fd_sc_hd.lef` | Provides the physical abstract views of all standard cells available in the technology library. | Standard Cell Placement, Routing |
| **Standard Cell Liberty** | `sky130_fd_sc_hd.lib` | Contains timing, power, and electrical characteristics of the standard cells used during implementation. | Static Timing Analysis (STA), Timing Optimization |
| **Standard Cell GDS** | `sky130_fd_sc_hd.gds` | Contains the physical layouts of all standard cells required for merging into the final chip layout during tapeout. | Final GDS Merge, Tapeout |

# Comparsion Of Both AI & Refrence Input Files (1st AI mistake discovered):

While comparing the AI given input files list with the reference project (**vsdmixedsignalflow**), two important files were identified as missing in the AI given file list. These files are essential for successfully integrating an analog macro into the OpenLane flow.

### 1. `macro.cfg`

**Purpose:**

The `macro.cfg` file specifies the **physical location and orientation** of the analog macro within the chip floorplan. It contains the macro name, X-coordinate, Y-coordinate, and orientation (North, South, East, West, etc.), enabling OpenLane/OpenROAD to place the analog block at a predefined location.

**Role in the Design Flow:**

This file is used during the **Floorplanning and Macro Placement** stage. Before standard-cell placement begins, OpenLane reads `macro.cfg` to determine the exact position of the analog macro. Since analog blocks have fixed layouts, they cannot be resized or freely moved like standard cells. Therefore, an explicit placement file is required.

**Impact if Missing:**

If `macro.cfg` is absent, OpenLane cannot determine where the analog macro should be placed. This may result in incorrect macro placement, overlap with standard cells, routing congestion, placement failures, or even termination of the Place-and-Route flow. Consequently, subsequent stages such as routing, DRC, and final GDS generation may also fail.

---

### 2. `verilog_to_lib.pl`

**Purpose:**

`verilog_to_lib.pl` is a Perl utility script that converts the analog macro's Verilog description into a **Liberty (`.lib`) file**. The generated Liberty file provides timing and electrical characterization required by OpenLane for integrating the analog macro into the digital implementation flow.

**Role in the Design Flow:**

This script is executed **before OpenLane initialization**, during the **library generation stage**. It generates the `.lib` file, which is then used together with the LEF and Verilog files throughout floorplanning, placement, routing, and static timing analysis.

**Impact if Missing:**

Without `verilog_to_lib.pl`, the required Liberty file cannot be generated automatically. As a result, OpenLane lacks the timing and library information needed to recognize and process the analog macro correctly. This prevents proper macro integration and may cause the Place-and-Route flow to fail.

---

## Conclusion At Stage 2 :

The comparison with the reference project shows that both `macro.cfg` and `verilog_to_lib.pl` are essential support files for analog macro integration in OpenLane. While `macro.cfg` ensures the analog macro is placed at the correct physical location during floorplanning, `verilog_to_lib.pl` generates the Liberty file required for timing characterization and macro recognition. Omitting either of these files can interrupt the implementation flow and prevent successful completion of the Analog Place-and-Route process.

Concluding That Using the AI saves Time but it doesn't gives Everything Correctly always so,we have to make sure to verify and understand the results of AI whether correct or not. ** Never trust AI-generated interfaces without verification.**

---
## Stage 3 - Understanding The Tools and Softwares:
---
# Objective :

To Know About the OpenLane architecture and Sky130 and docker, there role in the **RTL-to-GDS Mixed-Signal Physical Design**.

# Prompt:

```
Explain OpenLane architecture and Sky130 and docker ,how install these give me step by step process  and also explain 
Which tool performs what following thins:
* Synthesis
* Placement
* CTS
* Routing
* DRC
* LVS
* Magic
* KLayout
* OpenROAD
* Yosys
```
# Output :

All Information About the OpenLane architecture and Sky130 and docker is in [AboutTools](AboutTools/README.md)

# Tools Installation Guide :-

Tools Installation Process is in [InstallationGuide](InstallationGuide/README.md)

---
## Stage 4 - Generating Input Files by AI :
---
# Objective :
Every file was created using a focused and well-defined prompt to ensure consistency,hierarchy in the design particularly for module names, port lists, pin names, and net connections.This approach was intentionally adopted because even a minor mismatch in ports or signal names can lead to hierarchy inconsistencies, compilation errors, or integration failures during the OpenLane flow. Maintaining identical interfaces across all input files is therefore essential for successful macro integration, floorplanning, placement, routing, and verification. Ensuring this consistency significantly reduces debugging effort and improves the overall reliability of the Analog Place-and-Route process.

 1. Top-Level Digital Verilog (design_mux.v)
  ```
Write a synthesizable Verilog top-level module named **`design_mux`** for the OpenLane flow. Instantiate **exactly one** analog hard macro **`AMUX2_3V`** with **exactly** these ports:

* input I0
* input I1
* output out
* input select
Do not rename, reorder, add, or remove any macro ports, and do not include power/ground pins.

Implement minimal digital control logic using clk and active-low rst_n to generate the select signal. Connect all ports correctly and ensure hierarchy consistency to avoid port mismatches.

Generate clean, synthesizable **Verilog-2001** code only. Do not use delays, initial blocks, or other non-synthesizable constructs. The output should contain only the complete design_mux module.
```
1.1 Top-Level Digital Verilog Code for design_mux.v 
```
module design_mux (
    input  wire RST,
    input  wire SCK,
    input  wire SDI,
    input  wire CSB,
    output wire SDO,
    output wire sdo_enb,
    output wire xtal_ena,
    output wire reg_ena,
    output wire pll_vco_ena,
    output wire pll_cp_ena,
    output wire pll_bias_ena,
    output wire [2:0] pll_trim,
    output wire pll_bypass,
    output wire irq,
    output wire trap,
    input  wire [31:0] mfgr_id,
    input  wire [31:0] prod_id,
    input  wire [31:0] mask_rev_in,
    output wire [31:0] mask_rev,
    output wire out
);

    // Internal signals between the digital controller and analog macro
    wire I0;
    wire I1;
    wire select;

    //----------------------------------------------------------
    // Analog Hard Macro
    //----------------------------------------------------------
    AMUX2_3V u_amux (
        //.VDD   (VDD),
        //.VSS   (VSS),
        .I0     (I0),
        .I1     (I1),
        .out    (out),
        .select (select)
    );

    //----------------------------------------------------------
    // Digital Controller
    //----------------------------------------------------------
    raven_spi u_raven_spi (
        .RST          (RST),
        .SCK          (SCK),
        .SDI          (SDI),
        .CSB          (CSB),
        .SDO          (I0),
        .sdo_enb      (sdo_enb),
        .xtal_ena     (xtal_ena),
        .reg_ena      (reg_ena),
        .pll_vco_ena  (pll_vco_ena),
        .pll_cp_ena   (pll_cp_ena),
        .pll_bias_ena (pll_bias_ena),
        .pll_trim     (pll_trim),
        .pll_bypass   (pll_bypass),
        .irq          (irq),
        .reset        (I1),
        .trap         (trap),
        .mfgr_id      (mfgr_id),
        .prod_id      (prod_id),
        .mask_rev_in  (mask_rev_in),
        .mask_rev     (mask_rev)
    );

    // Example control logic for the analog mux
    assign select = reg_ena;

endmodule
```
2. Macro Blackbox Stub (AMUX2_3V.v)
```
Write a synthesizable Verilog **black-box** module named **`AMUX2_3V`** using the `(* blackbox *)` attribute. Define **exactly** these ports: `input I0`, `input I1`, `output out`, and `input select`. **Do not** rename, reorder, add, or remove any ports. Do **not** include power/ground pins or any internal logic. Output only the complete black-box module declaration.
```
2.1 AI Generated Macro Blackbox Stub Code 
```
module AMUX2_3V (
    input  wire I0,
    input  wire I1,
    input  wire select,
    output wire out
);

    // Functional behavioral model
    assign out = (select === 1'b1) ? I1 :
                 (select === 1'b0) ? I0 :
                 1'bx;

endmodule
```
3. Macro LEF — Generated via Magic Prompt
```
give me a Magic TCL script to generate a LEF file from `AMUX2_3V.mag`. Open the layout, convert labels to ports with the following types: `VDD`/`VSS` as `inout` (`power`/`ground`), `I0`, `I1`, and `select` as `input signal`, and `out` as `output signal`. Set `LEFclass` to `CORE` and `LEFsite` to `unithddbl`, move the cell origin to `(0,0)`, and write the final LEF file. Generate only the complete Magic TCL script.
```
3.1 AI Generated AMUX2_3V.lef 
```
MACRO AMUX2_3V
  CLASS CORE ;
  SITE unithddbl ;
  ORIGIN 0.000 0.000 ;
  FOREIGN AMUX2_3V 0.000 0.000 ;
  SIZE 20.000 BY 15.000 ;
  SYMMETRY X Y ;

  PIN I0
    DIRECTION INPUT ;
    USE SIGNAL ;
    PORT
      LAYER met1 ;
        RECT 1.000 6.500 1.500 7.500 ;
    END
  END I0

  PIN I1
    DIRECTION INPUT ;
    USE SIGNAL ;
    PORT
      LAYER met1 ;
        RECT 1.000 4.000 1.500 5.000 ;
    END
  END I1

  PIN select
    DIRECTION INPUT ;
    USE SIGNAL ;
    PORT
      LAYER met1 ;
        RECT 1.000 9.000 1.500 10.000 ;
    END
  END select

  PIN out
    DIRECTION OUTPUT ;
    USE SIGNAL ;
    PORT
      LAYER met1 ;
        RECT 18.500 6.500 19.000 7.500 ;
    END
  END out

  PIN VDD
    DIRECTION INOUT ;
    USE POWER ;
    SHAPE ABUTMENT ;
    PORT
      LAYER met1 ;
        RECT 0.000 13.500 20.000 14.500 ;
    END
  END VDD

  PIN VSS
    DIRECTION INOUT ;
    USE GROUND ;
    SHAPE ABUTMENT ;
    PORT
      LAYER met1 ;
        RECT 0.000 0.500 20.000 1.500 ;
    END
  END VSS

  OBS
    LAYER met1 ;
      RECT 0.000 0.000 20.000 15.000 ;
  END

END AMUX2_3V
```
4. Macro LIB (Timing/Functional Abstraction)
```
give the exact Linux shell command to run `verilog_to_lib.pl` on `AMUX2_3V.v` and that generate `AMUX2_3V.lib`. Also, also describe the key sections that should appear in the generated `.lib` file—such as library information, cell name, area, pin definitions, direction, function, capacitance, timing arcs, and timing tables—so I can verify that the Liberty file was generated correctly. Output only the command followed by the expected `.lib` contents checklist.
```
4.1 AI Generated AMUX2_3V.lib Code
```
library(AMUX2_3V) {

  delay_model              : table_lookup;
  time_unit                : "1ns";
  voltage_unit             : "1V";
  current_unit             : "1mA";
  leakage_power_unit       : "1nW";
  capacitive_load_unit (1, pf);

  cell(AMUX2_3V) {

    area : 300;

    pin(I0) {
      direction    : input;
      capacitance  : 0.002;
    }

    pin(I1) {
      direction    : input;
      capacitance  : 0.002;
    }

    pin(select) {
      direction    : input;
      capacitance  : 0.001;
    }

    pin(out) {
      direction : output;
      function  : "(select * I1) + (!select * I0)";

      timing() {
        related_pin : "I0";
        timing_type : combinational;

        cell_rise(scalar) {
          values("0.15");
        }

        cell_fall(scalar) {
          values("0.15");
        }

        rise_transition(scalar) {
          values("0.05");
        }

        fall_transition(scalar) {
          values("0.05");
        }
      }

      timing() {
        related_pin : "I1";
        timing_type : combinational;

        cell_rise(scalar) {
          values("0.15");
        }

        cell_fall(scalar) {
          values("0.15");
        }

        rise_transition(scalar) {
          values("0.05");
        }

        fall_transition(scalar) {
          values("0.05");
        }
      }

      timing() {
        related_pin : "select";
        timing_type : combinational;

        cell_rise(scalar) {
          values("0.08");
        }

        cell_fall(scalar) {
          values("0.08");
        }

        rise_transition(scalar) {
          values("0.03");
        }

        fall_transition(scalar) {
          values("0.03");
        }
      }
    }

  }

}
```
5. config.tcl Prompt
```
Give me a **OpenLane `config.tcl`** file for the top-level design **`design_mux`**. Use `design_mux.v` as the top Verilog source and `AMUX2_3V.v` as the black-box macro. Configure the **Sky130A PDK** with **`sky130_fd_sc_hd`** standard cells, include the macro **LEF** and **Liberty** files using `EXTRA_LEFS` and `EXTRA_LIBS`, set `CLOCK_PERIOD` to **10.0 ns**, and define a **DIE_AREA** large enough for one small analog macro and a few standard cells. Add concise comments explaining the purpose of every configuration variable, and output only the complete `config.tcl` file.
```
5.1 AI Generated config.tcl 
```
#-------------------------------------------------------------
# OpenLane Configuration File for design_mux
#-------------------------------------------------------------

# Top-level design name
set ::env(DESIGN_NAME) "design_mux"

# RTL source files
# Only the digital wrapper is synthesized.
# The analog macro is treated as a hard macro.
set ::env(VERILOG_FILES) \
    "$::env(DESIGN_DIR)/src/design_mux.v"

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
set ::env(CLOCK_PORT) "clk"

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
```
6. macro.cfg Prompt 
```
Generate an **OpenLane `macro.cfg`** file that places the analog macro instance **`AMUX2_3V`** (or the exact instance name used in `design_mux.v`) at a fixed location within a **200 × 200 µm** die. Position the macro away from the IO boundary to allow routing space, use **orientation `N` (North)**, and output only the single correctly formatted line required for `macro.cfg`.
```
6.1 AI Generated macro.cfg 
```
AMUX2_3V 80 80 N
```
## AI-Generated Files vs. Reference Repository Comparison

| **File** | **AI-Generated (Final Version)** | **Reference Repository** | **Match?** | **Notes** |
|----------|-----------------------------------|--------------------------|:---------:|-----------|
| **AMUX2_3V.v**<br>(Behavioral / Blackbox) | Behavioral model with ports **I0, I1, out, select** and simple mux logic (`assign out = select ? I1 : I0`). | Behavioral model uses the **same four ports** and represents the analog macro for synthesis/simulation. | ✅ **Match** | Port names now exactly match the reference macro. The behavioral implementation is equivalent and suitable for OpenLane integration. |
| **design_mux.v**<br>(Top-Level) | Instantiates **AMUX2_3V** as `u_amux`, connects **raven_spi** controller, and drives `select` from `reg_ena`. | Instantiates **AMUX2_3V** together with **raven_spi** and **spi_slave** hierarchy used in the mixed-signal design. | 🟡 **Mostly Match** | Macro interface and hierarchy are correct. The repository also contains additional supporting modules (`raven_spi.v`, `spi_slave.v`) which must be present for complete compilation. |
| **AMUX2_3V.lef** | Defines **CORE** macro, **unithddbl** site, correct pin directions, power/ground pins, and macro geometry. | Generated from Magic with matching LEF properties and physical pin locations. | ✅ **Match** | Structure matches the reference. Exact coordinates depend on the actual Magic layout but the LEF syntax and properties are correct. |
| **AMUX2_3V.lib** | Defines library, cell, area, pin capacitances, output function, and combinational timing arcs. | Liberty generated from `verilog_to_lib.pl` containing timing model and pin definitions. | ✅ **Match** | Contains all required Liberty sections. Numerical timing values are illustrative and would normally come from characterization. |
| **config.tcl** | Configures `design_mux`, Sky130A PDK, `sky130_fd_sc_hd`, clock, DIE_AREA, EXTRA_LEFS/LIBS/GDS, and macro placement. | Reference repository configures the same OpenLane variables for analog macro integration. | 🟡 **Mostly Match** | Core configuration is correct. Minor parameter values (e.g., routing options, floorplan variables) may differ from the reference but do not change the overall flow. |
| **macro.cfg** | `AMUX2_3V 80 80 N` (fixed placement inside a 200 × 200 µm die). | Uses the macro instance name with fixed placement coordinates and orientation. | 🟡 **Functionally Match** | Correct format and orientation. The only value that may differ is the exact placement coordinate used by the reference repository. The instance name must exactly match the one in `design_mux.v`. |







 









