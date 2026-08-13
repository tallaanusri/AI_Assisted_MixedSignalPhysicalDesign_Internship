
# Task 4 – Week 5: AI-Assisted Analog MUX Physical Design

## Project Overview

This repository documents the complete **Task 4 – Week 5** workflow from the AI-Assisted Mixed-Signal Physical Design Internship.

The objective was to replace the placeholder analog multiplexer in the reference design with a newly designed **double-height 2:1 analog multiplexer (`AMUX2_3V`)** implemented using the SKY130A PDK.

The work covers:

- Reference design analysis
- Transistor-level MUX design
- Pre-layout ngspice verification
- AI-assisted fresh layout generation
- Magic layout and DRC
- Layout extraction
- Netgen LVS investigation and debugging
- Post-layout simulation
- Reusable macro-view generation
- OpenLane RTL-to-GDS integration
- Physical-design and PNR investigation

---

## Complete Workflow

```text
Reference Design Analysis
        │
        ▼
Transistor-Level MUX Design
        │
        ▼
Pre-Layout ngspice Verification
        │
        ▼
AI-Assisted Fresh Layout
        │
        ▼
Magic Layout + DRC
        │
        ▼
Physical Routing Correction
        │
        ▼
Layout Extraction
        │
        ▼
Netgen LVS Investigation
        │
        ▼
Post-Layout Simulation
        │
        ▼
Macro View Generation
        │
        ▼
OpenLane RTL-to-GDS Integration
        │
        ▼
PNR / DEF Connectivity Investigation
````

The repository intentionally preserves multiple iterations so that the AI-assisted design process, successful stages, failed attempts and debugging decisions remain reproducible and auditable.

---

# Design Objective

The target macro is a transistor-level **2:1 analog multiplexer**.

### External pins

```text
I0
I1
select
out
VDD
VSS
```

### Required functionality

```text
select = 0  →  I0 → out
select = 1  →  I1 → out
```

The physical implementation was targeted as a **double-height SKY130A macro** with PNR-accessible external pins.

---

# Transistor-Level and Pre-Layout Verification

The transistor-level MUX was designed using SKY130A transistor models and verified using ngspice.

The nominal verification conditions were:

* SKY130A TT corner
* Temperature: 27 °C
* `VDD = 1.8 V`
* Output load: 20 fF

Measured pre-layout results:

| Metric              | Select = 0 | Select = 1 |
| ------------------- | ---------: | ---------: |
| Function            | `I0 → out` | `I1 → out` |
| Rise delay          |   47.36 ps |   50.96 ps |
| Fall delay          |   51.46 ps |   48.37 ps |
| Average VDD current |   1.560 µA |   0.891 µA |

An early debugging step identified the SKY130 primitive-wrapper W/L parameter convention. The wrappers expect W/L values in micrometre units, and incorrect scaling initially caused ngspice model-selection problems.

---

# AI-Assisted Layout Generation

A fresh physical layout was generated using an AI-assisted workflow rather than simply copying the reference MUX layout.

The AI workflow used:

1. Transistor-level SPICE netlist
2. SKY130A technology information
3. Sample Magic `.mag` layout
4. Required pin names and pin ordering
5. Double-height cell requirements
6. Power, well and substrate requirements
7. PNR-accessible external pins
8. Iterative correction based on DRC, extraction and LVS observations

The generated layout was targeted as a **12.0 µm × 6.0 µm double-height cell**.

The complete Iteration 3 AI-assisted workflow is documented under:

```text
task4/iteration_3/step2_ai_layout/
```

---

# Iteration History

## Iteration 1

```text
task4/iteration_1/
```

The first iteration records the initial transistor-level design, AI-assisted layout, Magic extraction and initial LVS attempt.

It established the baseline flow and exposed physical-connectivity problems.

---

## Iteration 2

```text
task4/iteration_2/
```

The second iteration records additional AI-assisted layout generation, alternative layout attempts, Magic implementation, extraction, post-layout artifacts and reusable macro views.

---

## Iteration 3

```text
task4/iteration_3/
```

Iteration 3 is the most complete implementation attempt.

It contains:

```text
step1_schematic/
step2_ai_layout/
step3_magic_drc/
step4_extraction/
step5_lvs/
step6_post_layout_simulation/
step7_macro_views/
step8_rtl_to_gds/
```

This is the primary iteration for the final Task 4 documentation.

---

# Magic DRC and Physical Debugging

Magic was used to inspect and verify the generated layout.

The final corrected DRC layout is:

```text
task4/iteration_3/step3_magic_drc/AMUX2_3V_magic83_DRC0_select_fixed.mag
```

The physical debugging process focused particularly on the `select` and internal complementary `sel_b` control networks.

The final corrected layout revision was verified using Magic with zero reported DRC violations.

The routing correction is documented through the DRC logs and reports stored in:

```text
task4/iteration_3/step3_magic_drc/
```

---

# Layout Extraction

Magic extraction was used to convert the physical geometry into an electrical SPICE representation.

The extracted netlist is:

```text
task4/iteration_3/step4_extraction/AMUX2_3V_extracted.spice
```

The extracted representation was then used for LVS investigation and post-layout simulation.

---

# LVS Verification and Debugging

Netgen LVS was performed by comparing the canonical transistor-level schematic with the extracted layout netlist.

The LVS artifacts are stored in:

```text
task4/iteration_3/step5_lvs/
```

Important files include:

```text
schematic.spice
extracted.spice
extracted_before_lvs_namefix.spice
lvs_report.txt
```

## LVS Status

**A clean zero-error LVS match was not achieved.**

The failure is intentionally documented rather than hidden.

The investigation identified several physical-equivalence issues.

### 1. External pin-order mismatch

The intended interface is:

```text
I0 I1 select out VDD VSS
```

An extracted layout revision used a different subcircuit ordering, producing top-level pin correspondence problems.

### 2. MUX selection connectivity

The required operation is:

```text
select = 0 → I0 → out
select = 1 → I1 → out
```

An earlier AI-generated physical implementation was found to implement the opposite input correspondence.

This was treated as a genuine physical-connectivity problem rather than merely a naming problem.

### 3. Unintended physical shorts

Earlier generated layouts produced extraction warnings showing unintended electrical merging between external nets.

This demonstrated that the physical geometry could not simply be made LVS-compatible by changing the schematic.

### 4. Physical topology versus schematic topology

Because the extracted physical topology differed from the canonical schematic, the debugging process focused on correcting the physical implementation instead of modifying the schematic merely to force an LVS pass.

---

# Post-Layout Simulation

Post-layout simulations were performed using the extracted physical representation.

The simulation files are stored under:

```text
task4/iteration_3/step6_post_layout_simulation/
```

The two select states were simulated independently.

Important files include:

```text
tb_select0_postlayout.spice
tb_select1_postlayout.spice
measure_select0.cir
measure_select1.cir
postlayout_measurements.txt
```

Raw simulation results are preserved under:

```text
step6_post_layout_simulation/results/
```

---

# Reusable Macro Views

The final macro views are preserved under:

```text
task4/iteration_3/step7_macro_views/
```

Generated views include:

```text
AMUX2_3V.gds
AMUX2_3V.lef
AMUX2_3V.lib
AMUX2_3V.mag
AMUX2_3V.spice
AMUX2_3V.v
AMUX2_3V_lvs.spice
```

These views provide the physical, abstract, timing, schematic and logical representations required for integration.

---

# OpenLane RTL-to-GDS Integration

The generated AMUX2_3V macro was integrated into an OpenLane-based RTL-to-GDS flow.

The integration workspace is:

```text
task4/iteration_3/step8_rtl_to_gds/
```

It contains:

```text
config.tcl
macro.cfg
macro/
src/
```

The macro directory contains:

```text
macro/AMUX2_3V.gds
macro/AMUX2_3V.lef
macro/AMUX2_3V.lib
```

The RTL sources include:

```text
src/AMUX2_3V.v
src/design_mux.v
src/raven_spi.v
src/spi_slave.v
```

---

# OpenLane PNR Investigation

The integrated design was taken through the OpenLane physical-design flow.

The investigation included:

* macro integration
* placement
* routing
* DEF inspection
* standard-cell connectivity
* constant/tie-cell investigation
* final physical-design artifact inspection

The SKY130A standard-cell library was checked for the required constant/tie-cell implementation.

The PDK was confirmed to contain:

```text
sky130_fd_sc_hd__conb_1
```

Therefore, the investigation focused on actual DEF instance connectivity and integration behavior rather than assuming that the tie cell was missing from the PDK.

---

# Verification Summary

| Stage                       | Status          | Result                                         |
| --------------------------- | --------------- | ---------------------------------------------- |
| Transistor-level MUX        | ✅ Complete      | SKY130A transistor implementation              |
| Pre-layout ngspice          | ✅ Complete      | Both select states verified                    |
| AI-assisted fresh layout    | ✅ Complete      | New double-height layout generated             |
| Physical routing correction | ✅ Complete      | `select` / `sel_b` routing corrected           |
| Magic DRC                   | ✅ Complete      | Zero DRC violations for final corrected layout |
| Layout extraction           | ✅ Complete      | Extracted SPICE generated                      |
| LVS                         | ⚠️ Investigated | Clean zero-error match not achieved            |
| LVS debugging               | ✅ Complete      | Physical causes investigated                   |
| Post-layout simulation      | ✅ Complete      | Both select states simulated                   |
| Macro views                 | ✅ Complete      | GDS/LEF/LIB/MAG/SPICE/Verilog generated        |
| OpenLane integration        | ✅ Complete      | Macro integrated into RTL-to-GDS flow          |
| PNR investigation           | ✅ Complete      | Placement/routing/DEF connectivity inspected   |
| Final LVS-clean signoff     | ❌ Not achieved  | Remaining limitation                           |

---

# Project Integrity Note

This repository does **not** claim that the final AMUX2_3V macro is LVS-clean.

The LVS failure is preserved intentionally as part of the engineering record.

The project demonstrates the complete workflow from:

```text
Schematic
   ↓
Simulation
   ↓
AI-Assisted Layout
   ↓
DRC
   ↓
Extraction
   ↓
LVS Investigation
   ↓
Post-Layout Simulation
   ↓
Macro Generation
   ↓
OpenLane Integration
   ↓
PNR Investigation
```

No schematic modification was performed solely to manufacture an LVS pass.

The remaining technical limitation is final clean Netgen LVS equivalence.

---

# Tools

* SKY130A PDK
* Magic VLSI
* Netgen LVS
* ngspice
* OpenLane
* OpenROAD
* Docker
* Git / GitHub
* AI-assisted layout-generation workflow

---

# Final Statement

Task 4 demonstrates an end-to-end AI-assisted mixed-signal physical-design workflow for replacing a placeholder analog MUX with a newly generated double-height SKY130A macro.

The work successfully exercised transistor-level design, simulation, AI-assisted layout generation, Magic DRC, extraction, post-layout simulation, macro-view generation and OpenLane integration.

The remaining LVS mismatch is explicitly documented with the physical issues identified during debugging, providing a transparent engineering record rather than an artificially forced verification result.
