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

# Summary

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
