
# 🚀 AI-Assisted Mixed-Signal RTL-to-GDSII Physical Design Task Journey

## 🎯 Objective

The objective of this internship project was to implement and analyze a complete **RTL-to-GDSII physical design flow** for a mixed-signal design using **OpenLane**, **SKY130 PDK**, and the **OpenROAD toolchain**.

The design consists of:

- Digital RTL logic (`design_mux.v`)
- SPI-related digital modules
- A custom analog hard macro (`AMUX2_3V`)
- Mixed-signal integration using LEF, Liberty, and Verilog abstract views

The complete flow included:

- RTL synthesis
- Floorplanning
- Macro integration
- Placement
- Clock Tree Synthesis (CTS)
- Power Distribution Network (PDN) generation
- Routing
- Physical verification
- Final GDSII generation

AI assistance was used throughout the project for:

- Understanding VLSI physical design concepts
- Generating OpenLane Tcl commands
- Debugging tool errors
- Analyzing log files
- Improving workflow efficiency

All generated results were manually verified using OpenLane, Magic, and KLayout.

---

# 🏗️ Design Flow Overview

```

RTL Design
|
↓
Synthesis
|
↓
Floorplanning
|
↓
Macro Placement
|
↓
Standard Cell Placement
|
↓
Clock Tree Synthesis
|
↓
PDN Generation
|
↓
Routing
|
↓
Physical Verification
|
↓
GDSII Generation

````

---

# Stage 1 – RTL Synthesis

## Purpose

Convert the RTL description into a gate-level netlist using the SKY130 standard-cell library while preserving the analog macro as a hard macro.

## Design Inputs

RTL files:

- `design_mux.v`
- `AMUX2_3V.v`
- SPI-related Verilog modules

Macro views:

- `AMUX2_3V.lef`
- `AMUX2_3V.lib`
- `AMUX2_3V.v`

## OpenLane Command

```tcl
prep -design design_mux
run_synthesis
````

## Verification

✔ Digital logic synthesized successfully
✔ SKY130 standard cells generated
✔ AMUX2_3V preserved as a black-box macro
✔ No synthesis performed inside the analog block

## Learning

Analog hard macros must remain protected during synthesis. Their functionality is represented using abstract models:

* LEF → Physical information
* Liberty → Timing information
* Verilog → Logical black-box representation

---

# Stage 2 – Floorplanning

## Purpose

Create the initial chip organization by defining:

* Die area
* Core area
* IO locations
* Analog macro placement region

The AMUX2_3V macro was integrated using its LEF abstract view.

## OpenLane Command

```tcl
run_floorplan
```

## Verification

✔ Floorplan generated successfully
✔ Macro dimensions recognized correctly
✔ AMUX2_3V placed according to macro configuration
✔ Core and die regions created successfully

## Learning

The LEF file allows digital tools to understand the analog macro boundary, pins, and routing blockages without accessing the internal analog layout.

---

# Stage 3 – Placement

## Purpose

Place synthesized standard cells while maintaining the fixed location of the analog macro.

## OpenLane Command

```tcl
run_placement
```

## Verification

✔ Global placement completed
✔ Detailed placement completed
✔ Standard cells legalized
✔ Analog macro location remained unchanged

## Learning

Good placement quality improves:

* Routing congestion
* Timing performance
* Signal integrity

Hard macros are treated as fixed physical blocks during placement.

---

# Stage 4 – Clock Tree Synthesis (CTS)

## Purpose

Create a balanced clock distribution network to reduce:

* Clock skew
* Clock insertion delay

## OpenLane Command

```tcl
run_cts
```

## Verification

✔ Clock tree generated successfully
✔ Clock buffers inserted
✔ Sequential elements received balanced clock distribution

## Learning

CTS modifies only the digital clock network. The analog macro remains untouched because it is a fixed hard macro.

---

# Stage 5 – Power Distribution Network (PDN)

## Purpose

Generate the VDD and VSS power network for:

* Standard cells
* Analog macro power connections

## OpenLane Command

PDN generation was automatically performed during floorplanning:

```tcl
run_floorplan
```

## Verification

✔ Power grid generated
✔ Standard cell power rails connected
✔ Macro power integration verified

## Learning

A correct PDN is essential because a physically connected layout can still fail electrically if power connections are incorrect.

---

# Stage 6 – Routing

## Purpose

Connect:

* Digital standard cells
* IO pins
* Analog macro pins

while respecting macro routing blockages.

## OpenLane Command

```tcl
run_routing
```

## Verification

✔ Global routing completed successfully
✔ Detailed routing reached macro pin access stage
✔ Final routed database generated in the successful run

Final routing output:

```
RUN_2026.07.17_11.28.04
```

Generated files:

```
results/routing/design_mux.def
results/routing/design_mux.odb
```

## Learning

The router treats the analog macro as a physical obstruction using LEF information and automatically routes signals around the macro.

---

# Stage 7 – Physical Verification

## 7.1 Design Rule Check (DRC)

## Purpose

Verify that the layout follows SKY130 manufacturing rules.

## Tools Used

* Magic
* SKY130 Technology File

## Verification

✔ Layout loaded successfully
✔ Physical geometry inspected
✔ DRC issues analyzed during debugging

## Learning

DRC ensures that the final layout can be manufactured according to process rules.

---

## 7.2 Layout Versus Schematic (LVS)

## Purpose

Verify that the extracted layout connectivity matches the intended schematic/netlist.

## Tool Used

* Netgen

## Verification

✔ Digital connectivity verified
✔ Analog macro handled as a black-box component

## Learning

LVS confirms that physical implementation matches the original logical design intent.

---

# Stage 8 – GDSII Generation

## Purpose

Generate the final fabrication database containing the complete mixed-signal layout.

## OpenLane Command

```tcl
run_magic
```

Final GDS generated:

```
results/signoff/design_mux.gds
```

## Verification

✔ GDSII generated successfully
✔ Layout inspected using Magic
✔ Final database opened in KLayout
✔ Digital and analog blocks integrated successfully

## Learning

GDSII is the final physical representation delivered for fabrication. It combines:

* Digital routed circuitry
* Analog hard macro
* Power network
* Metal interconnects

---

# ❌ Challenges Encountered and Solutions

## Challenge 1 – Analog Macro Integration Errors

### Observation

OpenLane initially failed to recognize the AMUX2_3V macro correctly.

### Debugging Approach

Checked:

* LEF file
* Liberty file
* Verilog black-box model
* Macro configuration
* Pin ordering

### Resolution

Corrected macro views and configuration files.

Result:

✔ OpenLane successfully recognized AMUX2_3V as a hard macro.

---

# Challenge 2 – DEF Import and Magic Visualization Errors

### Observation

Magic reported DEF import issues and display problems.

### Debugging Approach

Verified:

* LEF geometry
* Macro dimensions
* Technology file path
* Display configuration

### Resolution

Corrected macro views and configured Magic with SKY130 technology.

Result:

✔ Floorplan, placement, CTS, and routing layouts successfully opened.

---

# Challenge 3 – Routing Failure at Macro Pin Access

### Observation

Detailed routing reported:

```
DRT-0073 No access point for u_amux/select
```

### Debugging Approach

Checked:

* Macro pin geometry
* LEF pin definition
* Routing layers
* Pin accessibility

### Resolution

Used the later successful run containing final routed database and GDS output.

---

# 📐 Layout Inspection

The final layout was inspected using:

## Magic

Used for:

* DEF visualization
* GDS viewing
* Physical inspection

## KLayout

Used for:

* Final GDS inspection
* Layer visualization

---

# 📂 Final Generated Outputs

Successful final run:

```
RUN_2026.07.17_11.28.04
```

Important outputs:

```
results/routing/design_mux.def

results/signoff/design_mux.gds

results/signoff/design_mux.mag

results/signoff/design_mux.spice
```
---

# 🛠️ Tools Used

| Category        | Tools                 |
| --------------- | --------------------- |
| RTL Design      | Verilog HDL           |
| Physical Design | OpenLane              |
| Backend Engine  | OpenROAD              |
| Technology      | SKY130 PDK            |
| Layout Viewer   | Magic                 |
| GDS Viewer      | KLayout               |
| Verification    | Magic DRC, Netgen LVS |
| Environment     | Docker + WSL Ubuntu   |

---

# 🏆 Project Outcome

Successfully implemented an AI-assisted mixed-signal RTL-to-GDSII flow using OpenLane and SKY130 PDK.

Key achievements:

✔ Integrated custom analog macro with digital RTL
✔ Completed synthesis, floorplanning, placement, CTS, PDN, routing flow
✔ Generated final GDSII layout
✔ Verified mixed-signal physical integration
✔ Debugged real-world VLSI implementation issues using AI-assisted analysis

