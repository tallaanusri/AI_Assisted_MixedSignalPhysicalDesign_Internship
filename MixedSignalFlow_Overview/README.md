

# 1. Project Overview

## Objective

The repository demonstrates a **mixed-signal RTL-to-GDS physical design flow** using the open-source **OpenLane/OpenROAD** toolchain and the **SKY130 Process Design Kit (PDK)**.

Unlike a purely digital ASIC flow, this project shows how an **analog IP (2:1 Analog Multiplexer)** can be integrated into a digital design using LEF, LIB, and Verilog black-box models, allowing OpenLane to complete the physical implementation.

### Problem it Solves

Traditional OpenLane flows are designed for **digital-only ASICs**. However, modern SoCs include both digital logic and analog blocks such as:

* ADCs
* DACs
* PLLs
* Analog Multiplexers
* Voltage Regulators

These analog blocks cannot be synthesized automatically. This repository demonstrates how to integrate them into the digital RTL-to-GDS flow.

### Why Mixed-Signal Physical Design is Important

Most real-world chips combine digital and analog components. A successful mixed-signal design flow ensures that:

* Digital logic is synthesized and placed automatically.
* Analog macros retain their handcrafted layouts.
* Both are integrated into a single manufacturable chip layout.

---

# 2. Repository Structure

The repository is organized into the following major directories:

| Folder              | Purpose                                      | Used During                        |
| ------------------- | -------------------------------------------- | ---------------------------------- |
| `Verilog/`          | RTL and black-box Verilog files              | Synthesis                          |
| `LEF/`              | Physical abstraction of analog macro         | Floorplanning & Placement          |
| `LIB/`              | Timing models                                | Synthesis & Static Timing Analysis |
| `IP Layout/`        | Magic layout (`.mag`) of the analog macro    | Analog IP development              |
| `openlane/`         | OpenLane project configuration and execution | Entire RTL-to-GDS flow             |
| `images/`           | Screenshots of each design stage             | Documentation                      |
| `openlane/results/` | Generated outputs (DEF, GDS, LEF, etc.)      | Final Results                      |

---

# 3. Complete RTL-to-GDS Flow

## Step 1 – RTL Design

**Tool:** Verilog

**Input Files**

* `design_mux.v`
* `raven_spi.v`
* `spi_slave.v`
* `AMUX2_3V.v` (black-box model)

**Output**

* RTL design description

The digital logic of the design is written in Verilog. The analog multiplexer is represented as a **black-box module**, meaning only its interface is described.

---

## Step 2 – Synthesis

**Tool:** Yosys (via OpenLane)

**Inputs**

* Verilog files
* Liberty (`AMUX2_3V.lib`)
* Standard-cell library

**Outputs**

* `design_mux.synthesis.v`
* `design_mux.synthesis_preroute.v`

Synthesis converts RTL into a gate-level netlist while preserving the analog macro as a black box.

---

## Step 3 – Floorplanning

**Tool:** OpenROAD

**Inputs**

* Synthesized netlist
* LEF files
* OpenLane configuration

**Output**

* `design_mux.floorplan.def`

This stage defines the chip dimensions, core area, I/O placement, and reserves space for the analog macro.

---

## Step 4 – Analog Macro Integration

This is the most significant step in the repository.

The analog multiplexer is integrated using three key files:

* `AMUX2_3V.lef` — Physical outline and pin locations.
* `AMUX2_3V.lib` — Timing information.
* `AMUX2_3V.v` — Black-box Verilog interface.

OpenLane recognizes the macro during placement without attempting to synthesize it.

---

## Step 5 – Placement

**Tool:** OpenROAD

**Output**

* `design_mux.placement.def`

Standard cells are placed while respecting the fixed location of the analog macro.

---

## Step 6 – Power Distribution Network (PDN)

Power and ground rails (VDD/VSS) are generated for both the digital standard cells and the analog macro.

---

## Step 7 – Routing

**Tool:** OpenROAD

**Output**

* `design_mux.def`

Metal interconnects are created to connect all cells and macros according to the netlist.

---

## Step 8 – DRC Cleaning

**Tool:** Magic

**Output**

* `design_mux.drc.mag`

The layout is checked for manufacturing rule violations such as spacing and width errors.

---

## Step 9 – GDSII Generation

**Outputs**

* `design_mux.gds`
* `design_mux.mag`
* `design_mux.lef`

The final chip layout is generated and can be viewed in layout tools like Magic or KLayout.

---

# 4. Important Design Files

| File Type      | Purpose                                                              |
| -------------- | -------------------------------------------------------------------- |
| `.v` (Verilog) | Describes digital logic and black-box interfaces.                    |
| `.lef`         | Physical abstraction of cells/macros (size, pins, blockage).         |
| `.lib`         | Timing and power characterization used during synthesis and STA.     |
| `.def`         | Placement and routing information generated during implementation.   |
| `.gds`         | Final mask layout used for fabrication.                              |
| `config.tcl`   | Configures the OpenLane flow (design name, clock, macro LEFs, etc.). |
| `script.tcl`   | Controls the sequence of OpenLane commands and flow execution.       |

---

# 5. Analog Macro Integration

The analog macro used is **AMUX2_3V**, a 2:1 analog multiplexer.

Why it cannot be synthesized:

* Analog circuits rely on transistor sizing, matching, and custom layouts.
* Logic synthesis tools only understand digital gates.

Integration process:

1. **Verilog (`AMUX2_3V.v`)** provides the module interface.
2. **LEF (`AMUX2_3V.lef`)** defines the macro's physical dimensions and pins.
3. **LIB (`AMUX2_3V.lib`)** provides timing information.
4. **Layout (`AMUX2_3V.mag`/GDS)** contains the actual analog implementation.

OpenLane treats the analog block as a fixed macro while synthesizing and placing the digital logic around it.

---

# 6. OpenLane Configuration

The repository uses:

* `openlane/config.tcl`
* `openlane/script.tcl`

These files configure the design flow, including:

* Design name
* Source Verilog files
* Clock settings
* Floorplanning parameters
* Macro LEF inclusion
* Placement and routing options
* Power distribution configuration

The `script.tcl` automates the execution of the OpenLane stages.

---

# 7. Expected Outputs

The repository already includes example outputs in `openlane/results/`:

| Output                     | Description                    |
| -------------------------- | ------------------------------ |
| `design_mux.synthesis.v`   | Gate-level synthesized netlist |
| `design_mux.floorplan.def` | Floorplanned design            |
| `design_mux.placement.def` | Placement result               |
| `design_mux.def`           | Routed design                  |
| `design_mux.gds`           | Final GDSII layout             |
| `design_mux.mag`           | Magic layout database          |
| `design_mux.lef`           | Exported LEF                   |
| `design_mux.drc.mag`       | DRC-cleaned layout             |

The `images/` directory also contains screenshots illustrating floorplanning, placement, routing, final layout, and other intermediate stages.

---

# 8. Learning Summary

### Digital Concepts

* Verilog RTL design
* Logic synthesis
* Floorplanning
* Standard-cell placement
* Power Distribution Network (PDN)
* Routing
* Design Rule Checking (DRC)

### Mixed-Signal Concepts

* Analog macro integration
* Black-box modeling
* LEF/LIB generation
* Hierarchical physical design
* Mixed-signal SoC implementation

### Common Beginner Mistakes

* Missing LEF or LIB files during macro integration.
* Incorrect black-box Verilog definitions.
* Pin mismatches between Verilog and LEF.
* Incorrect macro placement constraints.
* Missing PDK paths or OpenLane configuration errors.

### Key Takeaways

This repository demonstrates how an analog IP can be integrated into a digital OpenLane flow by combining **Verilog**, **LEF**, **LIB**, and **layout files**. It provides a complete example of a mixed-signal RTL-to-GDS implementation using open-source tools, making it an excellent reference for learning mixed-signal ASIC physical design and AI-assisted design exploration.
