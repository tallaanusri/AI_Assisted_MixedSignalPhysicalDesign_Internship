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
# 📂 AI Output Of Input Files Required:

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
That is Using the AI saves Time but it doesn't gives Everything Correctly always so,we have to make sure to verify and understand the results of AI whether correct or not Before blindly Following it.

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

# 1. What is OpenLane?

## Definition

* **OpenLane** is an **open-source automated RTL-to-GDSII ASIC design flow**.
* It combines several open-source EDA tools into one complete ASIC implementation flow.
* Instead of running every tool manually, OpenLane executes them in the correct order.
* Think of OpenLane as a **project manager** that controls all the individual design tools.

## OpenLane Architecture

```text
                   RTL (Verilog)
                         │
                         ▼
                    OpenLane Flow
                         │
 ┌─────────────────────────────────────────┐
 │                                         │
 │        1. Yosys (Synthesis)             │
 │                 │                       │
 │                 ▼                       │
 │      2. OpenROAD Floorplanning          │
 │                 │                       │
 │                 ▼                       │
 │          3. Placement                   │
 │                 │                       │
 │                 ▼                       │
 │      4. Clock Tree Synthesis            │
 │                 │                       │
 │                 ▼                       │
 │      5. Power Distribution Network      │
 │                 │                       │
 │                 ▼                       │
 │             6. Routing                  │
 │                 │                       │
 │                 ▼                       │
 │         7. SPEF / Timing                │
 │                 │                       │
 │                 ▼                       │
 │      8. Magic (DRC + GDS)               │
 │                 │                       │
 │                 ▼                       │
 │          9. Netgen (LVS)                │
 │                                         │
 └─────────────────────────────────────────┘
                         │
                         ▼
                  Final GDSII Layout
```


# Why OpenLane?

Without OpenLane you would manually run

```
Yosys
↓
OpenROAD
↓
Magic
↓
Netgen
↓
KLayout

```

OpenLane automates everything.

---

# 2. What is SKY130?

## Definition

SKY130 stands for

**SkyWater 130 nm Process Design Kit (PDK)**

It is Google's first open-source fabrication technology.

Without a PDK,

you **cannot manufacture a chip**.

---

## Think of SKY130 like this

Imagine building a house.

You need

* bricks
* doors
* windows
* cement

Similarly,

to build an ASIC you need

* Standard Cells
* Metal Layers
* Design Rules
* Timing Models
* Transistor Models

These are provided by SKY130.

---

## SKY130 contains

```
Standard Cells

↓

LEF

↓

LIB

↓

SPICE Models

↓

Technology Files

↓

Magic Technology File

↓

Routing Rules
```

---

# Why OpenLane needs SKY130?

Suppose you synthesized

```verilog
assign y=a&b;
```

OpenLane must know

> Which AND gate?

SKY130 provides

```
sky130_fd_sc_hd__and2
```

along with

* Area

* Delay

* Power

* Layout

Everything comes from SKY130.

---

# 3. What is Docker?

Docker is software that creates an isolated Linux environment.

Instead of installing

```
Yosys
Magic
KLayout
Python
TCL
OpenROAD
OpenLane
```

individually,

Docker packages everything into one container.

Think of Docker as a **virtual lab** where all EDA tools are already installed and work together.

---

# Why OpenLane uses Docker?

Because different operating systems have different dependencies.

Docker ensures

```
Your PC
↓
Docker
↓
Ubuntu
↓
OpenLane
↓
OpenROAD
↓
Magic
↓
Yosys
```

Everything behaves the same on every computer.

---

# Which Tool Performs What?

| Stage                                | Tool                   | What it Does                                                     |
| ------------------------------------ | ---------------------- | ---------------------------------------------------------------- |
| **RTL Design**                       | Verilog                | Describes hardware functionality                                 |
| **Synthesis**                        | **Yosys**              | Converts Verilog into a gate-level netlist                       |
| **Floorplanning**                    | **OpenROAD**           | Defines die size, core area, and macro placement                 |
| **Placement**                        | **OpenROAD**           | Places standard cells on the chip                                |
| **Clock Tree Synthesis (CTS)**       | **OpenROAD**           | Builds a balanced clock distribution network                     |
| **Power Distribution Network (PDN)** | **OpenROAD**           | Creates VDD/VSS power grids                                      |
| **Routing**                          | **OpenROAD**           | Connects cells using metal routing layers                        |
| **Static Timing Analysis (STA)**     | **OpenROAD / OpenSTA** | Verifies setup/hold timing                                       |
| **Design Rule Check (DRC)**          | **Magic**              | Checks layout against manufacturing design rules                 |
| **Layout vs. Schematic (LVS)**       | **Netgen**             | Compares the extracted layout netlist with the schematic/netlist |
| **Layout Viewing & Editing**         | **Magic**              | Interactive layout editor and GDS viewer                         |
| **GDS Visualization**                | **KLayout**            | High-performance GDSII viewer and inspection tool                |
| **Complete Physical Design Flow**    | **OpenLane**           | Orchestrates all the above tools in the correct sequence         |

---

# OpenLane Flow with Tools

```text
                 Verilog RTL
                      │
                      ▼
              Yosys (Synthesis)
                      │
                      ▼
         OpenROAD (Floorplanning)
                      │
                      ▼
      OpenROAD (Macro Placement)
                      │
                      ▼
        OpenROAD (Cell Placement)
                      │
                      ▼
           OpenROAD (CTS)
                      │
                      ▼
           OpenROAD (PDN)
                      │
                      ▼
        OpenROAD (Routing)
                      │
                      ▼
         OpenSTA (Timing)
                      │
                      ▼
            Magic (DRC)
                      │
                      ▼
           Netgen (LVS)
                      │
                      ▼
      Magic / KLayout (View GDSII)
                      │
                      ▼
              Final GDSII Layout
```

---

# What You Should Remember for Interviews

| Tool         | One-line Purpose                                                                                 |
| ------------ | ------------------------------------------------------------------------------------------------ |
| **OpenLane** | Automates the complete RTL-to-GDS flow.                                                          |
| **OpenROAD** | Performs floorplanning, placement, CTS, PDN, routing, and timing analysis.                       |
| **Yosys**    | Synthesizes Verilog RTL into a gate-level netlist.                                               |
| **Magic**    | Performs layout editing, DRC, and GDS generation/viewing.                                        |
| **Netgen**   | Performs LVS to verify layout matches the design.                                                |
| **KLayout**  | Views and inspects GDSII layout files.                                                           |
| **SKY130**   | Provides the technology libraries, standard cells, and design rules required for implementation. |
| **Docker**   | Provides a consistent environment with all EDA tools installed and configured.                   |

---

# Tools Installation Guide :-

Tools Installation Process [InstallationGuide](InstallationGuide/README.md)


 









