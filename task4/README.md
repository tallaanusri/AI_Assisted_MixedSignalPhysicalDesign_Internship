
# Task 4 – Week 5: AI-Assisted Analog MUX Physical Design

## Project Overview

This repository documents the complete **Task 4 – Week 5** workflow from the AI-Assisted Mixed-Signal Physical Design Internship.

The objective was to replace the placeholder/reference analog multiplexer with a newly designed **double-height 2:1 analog multiplexer (`AMUX2_3V`)** implemented using the **SKY130A PDK**, followed by physical verification, macro generation, OpenLane integration, and final RTL-to-GDS signoff.

The complete workflow includes:

- Reference design analysis
- Old/reference MUX investigation
- New transistor-level `AMUX2_3V` design
- Pre-layout ngspice verification
- AI-assisted fresh layout generation
- Magic layout implementation
- Magic DRC verification
- Physical routing correction
- Layout extraction
- Netgen LVS investigation and debugging
- Post-layout simulation
- Reusable macro-view generation
- OpenLane RTL-to-GDS integration
- Macro power-network integration
- Final DRC verification
- Final LVS verification
- RTL-to-GDS reproducibility verification

The repository intentionally preserves the intermediate design iterations, failed verification attempts, debugging artifacts, and final corrected implementation so that the development process remains reproducible and auditable.

---

# Design Objective

The target circuit is a transistor-level **2:1 analog multiplexer**.

## External Pins

```text
I0
I1
select
out
VDD
VSS
````

## Required Functionality

```text
select = 0  →  I0 → out

select = 1  →  I1 → out
```

The physical implementation was targeted as a **double-height SKY130A macro** with external pins suitable for integration into a digital/analog mixed-signal top-level design.

---

# Old Reference MUX vs New AI-Assisted AMUX2_3V

Task 4 started from an existing/reference MUX implementation. The reference design was studied to understand the required circuit interface, physical organization, macro integration requirements, and OpenLane flow.

A new `AMUX2_3V` was then designed and physically implemented as the Task 4 replacement macro.

## Comparison

| Feature                  | Old / Reference MUX                                 | New `AMUX2_3V`                                                       |
| ------------------------ | --------------------------------------------------- | -------------------------------------------------------------------- |
| Role                     | Starting/reference implementation                   | New Task 4 implementation                                            |
| Function                 | 2:1 analog multiplexing                             | 2:1 analog multiplexing                                              |
| Technology               | SKY130-based reference                              | SKY130A                                                              |
| Circuit implementation   | Existing/reference circuit                          | Newly designed transistor-level circuit                              |
| Physical design          | Reference physical implementation                   | AI-assisted fresh physical layout                                    |
| Target geometry          | Reference-dependent                                 | 12.0 µm × 6.0 µm                                                     |
| Cell type                | Reference macro                                     | Double-height macro                                                  |
| Layout methodology       | Existing/reference layout                           | AI-assisted layout generation followed by manual/physical correction |
| DRC investigation        | Reference baseline                                  | Magic DRC and iterative physical correction                          |
| Extraction               | Reference/existing representation                   | Magic extraction of new physical implementation                      |
| LVS                      | Reference starting point                            | Iteratively debugged and finally integrated with zero-error LVS      |
| Post-layout verification | Reference baseline                                  | Dedicated select=0 and select=1 simulations                          |
| OpenLane integration     | Reference integration                               | New `AMUX2_3V` integrated into `design_mux`                          |
| Final integrated LVS     | Reference status not used as final Task 4 criterion | **PASS – Total errors = 0**                                          |

The comparison intentionally does not assign numerical area, delay, current, or LVS results to the old/reference MUX unless those values are directly available from the repository evidence.

The new `AMUX2_3V` is the primary circuit and physical-design result of Task 4.

---

# Complete Workflow

```text
Reference Design Analysis
        │
        ▼
Old / Reference MUX Investigation
        │
        ▼
New Transistor-Level AMUX2_3V Design
        │
        ▼
Pre-Layout ngspice Verification
        │
        ▼
AI-Assisted Fresh Layout Generation
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
Reusable Macro Views
        │
        ▼
OpenLane RTL-to-GDS Integration
        │
        ▼
Macro PDN Integration
        │
        ▼
Detailed Routing
        │
        ▼
Final Magic/GDS DRC
        │
        ▼
Final LVS
        │
        ▼
RTL-to-GDS Reproducibility Verification
```

---

# Transistor-Level AMUX2_3V Design

The new `AMUX2_3V` was implemented as a transistor-level analog multiplexer using SKY130A device models.

The canonical interface is:

```text
I0 I1 select out VDD VSS
```

The required selection behavior is:

```text
select = 0 → I0 → out
select = 1 → I1 → out
```

The design contains complementary transistor control paths so that the selected input is transferred to the output while the unselected path remains disabled.

The transistor-level schematic is preserved under:

```text
task4/iteration_3/step1_schematic/
```

Important files include:

```text
AMUX2_3V.spice
tb_select0.spice
tb_select1.spice
```

---

# Pre-Layout ngspice Verification

The transistor-level circuit was verified using ngspice before physical layout.

The nominal verification conditions were:

* Technology: SKY130A
* Process corner: TT
* Temperature: 27 °C
* Supply voltage: 1.8 V
* Output load: 20 fF

## Pre-Layout Results

| Metric              | Select = 0 | Select = 1 |
| ------------------- | ---------: | ---------: |
| Function            | `I0 → out` | `I1 → out` |
| Rise delay          |   47.36 ps |   50.96 ps |
| Fall delay          |   51.46 ps |   48.37 ps |
| Average VDD current |   1.560 µA |   0.891 µA |

These results confirmed the intended logical behavior before physical implementation.

---

# SKY130 Model Debugging

An early simulation/debugging stage identified an important SKY130 primitive-wrapper parameter convention.

The SKY130 transistor wrappers used in the simulation expect transistor width and length values in **micrometre units**.

Incorrect scaling initially resulted in model-selection/simulation problems.

The issue was corrected before continuing with physical implementation.

This debugging step is preserved as part of the Task 4 development history.

---

# AI-Assisted Layout Generation

A fresh physical layout of `AMUX2_3V` was generated using an AI-assisted workflow.

The objective was not to simply copy the reference layout.

The AI-assisted layout workflow used:

1. Transistor-level SPICE netlist
2. SKY130A technology information
3. Sample Magic `.mag` layout information
4. Required pin names
5. Required pin ordering
6. Double-height cell requirements
7. Power and ground requirements
8. Well/substrate requirements
9. PNR-accessible external pins
10. Physical connectivity constraints
11. Iterative correction based on DRC and LVS observations

The target macro dimensions were:

```text
Width  = 12.0 µm
Height = 6.0 µm
Area   = 72.0 µm²
```

The main AI-assisted layout work is preserved under:

```text
task4/iteration_3/step2_ai_layout/
```

---

# Iteration History

The repository intentionally preserves multiple iterations.

This allows the development process to be inspected rather than presenting only the final successful result.

---

## Iteration 1

Location:

```text
task4/iteration_1/
```

Iteration 1 contains the initial transistor-level design, AI-assisted layout, Magic extraction, and initial LVS attempt.

The first iteration established the basic flow and exposed physical-connectivity problems.

---

## Iteration 2

Location:

```text
task4/iteration_2/
```

Iteration 2 contains additional AI-assisted layout generation, alternative layout attempts, Magic implementation, extraction, post-layout artifacts, and reusable macro views.

This iteration helped identify and correct several physical-layout issues.

---

## Iteration 3

Location:

```text
task4/iteration_3/
```

Iteration 3 is the primary and most complete Task 4 implementation.

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

Iteration 3 contains both historical debugging artifacts and the final corrected RTL-to-GDS integration.

---

# Magic DRC and Physical Debugging

Magic was used to inspect and verify the physical layout.

The final corrected macro layout is:

```text
task4/iteration_3/step3_magic_drc/AMUX2_3V_magic83_DRC0_select_fixed.mag
```

The physical debugging process focused particularly on the `select` and complementary `sel_b` control networks.

Earlier generated layouts contained physical connectivity problems.

The physical implementation was corrected rather than modifying the canonical transistor-level schematic simply to obtain an LVS match.

The corrected macro layout was verified with Magic DRC.

Final macro-level DRC result:

```text
0 violations
```

---

# Layout Extraction

Magic extraction was used to convert the final physical geometry into an electrical SPICE representation.

The extracted netlist is:

```text
task4/iteration_3/step4_extraction/AMUX2_3V_extracted.spice
```

The extracted representation was subsequently used for LVS investigation and post-layout simulation.

---

# Historical / Intermediate LVS Debugging

The repository contains earlier LVS failures.

These failures are intentionally preserved because they document the physical-debugging process.

They are **not the final LVS result**.

The historical LVS artifacts are stored under:

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

## Intermediate Issue 1 – External Pin Ordering

The intended canonical interface is:

```text
I0 I1 select out VDD VSS
```

An extracted layout revision used a different subcircuit ordering.

This produced top-level pin correspondence problems during LVS.

The problem was treated as a real physical/netlist interface issue rather than being hidden.

---

## Intermediate Issue 2 – MUX Selection Connectivity

The required functionality is:

```text
select = 0 → I0 → out
select = 1 → I1 → out
```

An earlier AI-generated physical implementation was found to implement the opposite input correspondence.

This was identified as a genuine physical-connectivity problem.

The layout was corrected rather than changing the schematic to force an LVS match.

---

## Intermediate Issue 3 – Unintended Physical Shorts

Earlier generated layouts produced extraction warnings showing unintended electrical merging between external nets.

Examples included physical shorts involving:

```text
VSS
select
I0
I1
VDD
out
```

These issues demonstrated that the physical topology did not initially correspond to the intended transistor-level schematic.

The physical layout was therefore debugged directly.

---

## Intermediate Issue 4 – Physical Topology vs Schematic Topology

The LVS debugging process established that the extracted physical topology must correspond to the canonical transistor-level circuit.

The debugging approach therefore followed:

```text
Schematic
   ↕
Physical Layout
   ↕
Extraction
   ↕
LVS
```

The schematic was not modified merely to make an incorrect physical layout pass LVS.

---

# Post-Layout Simulation

After physical correction and extraction, the circuit was simulated using the extracted physical representation.

The simulation files are stored under:

```text
task4/iteration_3/step6_post_layout_simulation/
```

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
task4/iteration_3/step6_post_layout_simulation/results/
```

## Final Post-Layout Results

The nominal conditions were:

* Technology: SKY130A
* Process corner: TT
* Temperature: 27 °C
* VDD: 1.8 V
* Load: 20 fF

| Metric     | Select = 0 | Select = 1 |
| ---------- | ---------: | ---------: |
| Function   | `I0 → OUT` | `I1 → OUT` |
| Rise delay |  74.849 ps |  77.281 ps |
| Fall delay |  71.334 ps |  69.168 ps |

The post-layout simulations confirmed the intended input-selection behavior after physical implementation.

---

# Pre-Layout vs Post-Layout Performance

The post-layout delays are higher than the pre-layout delays because the physical implementation introduces parasitic resistance and capacitance.

## Rise Delay

| Select | Pre-layout | Post-layout |
| ------ | ---------: | ----------: |
| 0      |   47.36 ps |   74.849 ps |
| 1      |   50.96 ps |   77.281 ps |

## Fall Delay

| Select | Pre-layout | Post-layout |
| ------ | ---------: | ----------: |
| 0      |   51.46 ps |   71.334 ps |
| 1      |   48.37 ps |   69.168 ps |

This provides a direct comparison between ideal transistor-level simulation and extracted post-layout behavior.

---

# Reusable Macro Views

The final macro views are preserved under:

```text
task4/iteration_3/step7_macro_views/
```

Important views include:

```text
AMUX2_3V.gds
AMUX2_3V.lef
AMUX2_3V.lib
AMUX2_3V.mag
AMUX2_3V.spice
AMUX2_3V.v
AMUX2_3V_lvs.spice
```

These views allow the transistor-level analog macro to be integrated into the larger `design_mux` top-level design.

---

# RTL-to-GDS Integration

The final macro was integrated into the top-level design:

```text
design_mux
```

The integration files are stored under:

```text
task4/iteration_3/step8_rtl_to_gds/
```

The main files are:

```text
config.tcl
macro.cfg
macro_pdn.tcl
src/AMUX2_3V.v
src/design_mux.v
src/raven_spi.v
src/spi_slave.v
```

The macro views used during integration are:

```text
macro/AMUX2_3V.gds
macro/AMUX2_3V.lef
macro/AMUX2_3V.lib
```

---

# AMUX2_3V Top-Level Integration

The final design contains the macro instance:

```text
u_amux AMUX2_3V
```

The final DEF places the macro at:

```text
(80000, 80000)
```

The final integrated connectivity is:

```text
Top-level SDO
    ↓
u_amux I0

u_raven_spi.reset
    ↓
u_amux I1

reg_ena
    ↓
u_amux select

top-level out
    ↓
u_amux out
```

The final DEF contains:

```text
u_amux AMUX2_3V + FIXED ( 80000 80000 ) N ;
```

and the corresponding extracted connectivity confirms the macro pins:

```text
u_amux I0
u_amux I1
u_amux select
u_amux out
```

---

# Macro Power-Network Integration Debugging

The final integrated LVS debugging identified a power-network connectivity issue at the macro/top-level interface.

The physical `AMUX2_3V` macro exposes its VDD/VSS rails on **met1**.

The default integration power grid did not directly provide the required connection from the macro met1 rails to the higher-level power grid.

The default macro grid was primarily connecting:

```text
met4 ↔ met5
```

while the macro supply rails were on:

```text
met1
```

This caused the extracted integrated layout to contain isolated macro supply nets.

The problem was therefore an **integration-level physical connectivity issue**, not a problem with the transistor-level `AMUX2_3V` circuit.

---

# Final PDN Integration Fix

The integration was corrected without changing the analog macro itself.

The following integration changes were made:

1. `AMUX2_3V` VDD/VSS were exposed in the integration RTL.
2. `FP_PDN_MACRO_HOOKS` was added.
3. A design-local:

```text
macro_pdn.tcl
```

was added.
4. The macro met1 VDD/VSS rails were bridged to the higher-level met4 power network.
5. A 10 µm met4 PDN pitch was used to cross the macro region.

The important principle is:

```text
AMUX2_3V macro
      │
      │ met1 VDD/VSS
      ▼
macro PDN hookup
      │
      │ met4
      ▼
top-level PDN
```

No transistor-level circuit change was required.

No macro geometry was changed.

No macro GDS, LEF, LIB, SPICE, or transistor-level physical implementation was modified to obtain the LVS result.

No LVS waiver was used.

---

# Final Integrated RTL-to-GDS Signoff

The final integrated OpenLane flow was successfully completed.

Final reproducibility run:

```text
RUN_2026.08.15_03.07.15
```

Location:

```text
~/OpenLane/designs/task4_iteration3_clean/runs/RUN_2026.08.15_03.07.15
```

The final OpenLane log contains:

```text
[SUCCESS]: Flow complete.
```

---

# Final Verification Summary

| Verification             | Final Result                |
| ------------------------ | --------------------------- |
| RTL-to-GDS OpenLane flow | **PASS**                    |
| Detailed routing DRC     | **0 violations**            |
| Final Magic/GDS DRC      | **0 violations**            |
| LVS                      | **PASS**                    |
| LVS total errors         | **0**                       |
| Net mismatches           | **0**                       |
| Device mismatches        | **0**                       |
| Pin mismatches           | **0**                       |
| Property mismatches      | **0**                       |
| Netgen result            | **Circuits match uniquely** |
| Setup violations         | **0**                       |
| Hold violations          | **0**                       |

The final LVS report states:

```text
LVS reports no net, device, pin, or property mismatches.

Total errors = 0
```

The final LVS log states:

```text
Final result:
Circuits match uniquely.
```

Therefore the final integrated design achieved a **clean zero-error LVS result**.

---

# Final DRC Verification

Detailed routing completed with:

```text
No DRC violations after detailed routing.
```

The final Magic/GDS signoff completed with:

```text
No DRC violations after GDS streaming out.
```

Therefore:

```text
Detailed Routing DRC = 0
Final Magic/GDS DRC = 0
```

---

# Final LVS Verification

The final integrated LVS report contains:

```text
LVS reports no net, device, pin, or property mismatches.

Total errors = 0
```

Netgen reports:

```text
Final result:
Circuits match uniquely.
```

This confirms that the final extracted integrated design and the intended reference netlist are electrically equivalent according to the LVS flow.

---

# Final DEF Connectivity Evidence

The final DEF contains the macro instance:

```text
u_amux AMUX2_3V + FIXED ( 80000 80000 ) N ;
```

Relevant connections include:

```text
SDO
    → u_amux I0

out
    → u_amux out

reg_ena
    → u_amux select

u_raven_spi.reset
    → u_amux I1
```

This confirms that the new analog MUX is physically instantiated and connected in the final top-level design.

---

# Final Generated Views

The final OpenLane run generated:

```text
results/final/def/design_mux.def
results/final/gds/design_mux.gds
results/final/lef/design_mux.lef
results/final/lib/design_mux.lib
results/final/mag/design_mux.mag
results/final/mag/design_mux.maglef
results/final/sdc/design_mux.sdc
results/final/sdf/design_mux.sdf
results/final/spef/design_mux.spef
```

These files provide the final physical-design views of the integrated design.

---

# RTL-to-GDS Reproducibility Verification

A fresh RTL-to-GDS run was performed from the repository integration design.

The reproducibility flow used:

```text
OpenLane v1.0.2
```

OpenLane image/commit:

```text
ff5509f65b17bfa4068d5336495ab1718987ff69
```

Technology:

```text
sky130A
```

PDK version:

```text
0fe599b2afb6708d281543108caf8310912f54af
```

The complete flow was executed using:

```text
task4_iteration3_clean
```

The run completed successfully through:

```text
Synthesis
Floorplanning
Macro Placement
PDN Generation
Placement
CTS
Global Routing
Detailed Routing
Parasitic Extraction
STA
GDS Generation
LEF Generation
LVS
Magic DRC
Final View Generation
```

The final result was:

```text
[SUCCESS]: Flow complete.
```

The same reproducibility run also produced:

```text
LVS Total errors = 0
Circuits match uniquely.
```

This provides independent evidence that the final integration can be reproduced from the repository configuration.

---

# Timing Warnings

The final OpenLane run reports:

```text
max slew violations
max fanout violations
```

These are timing-quality warnings and are separate from physical signoff.

The final run reports:

```text
No hold violations
No setup violations
```

Therefore these warnings do not affect the final:

```text
DRC = 0
LVS = 0 errors
```

The `AMUX2_3V` macro is also blackboxed during some STA stages because it is an integrated analog macro. This is expected for the macro-based integration flow and does not invalidate the physical LVS result.

---

# AI-Assisted Design Contribution

AI was used as part of the physical-design workflow rather than as a replacement for physical verification.

The AI-assisted workflow contributed to:

* Fresh transistor-level layout planning
* Physical cell organization
* SKY130 layout interpretation
* Initial Magic layout generation
* Routing suggestions
* Physical-debug analysis
* Iterative correction of layout problems
* Identification of connectivity issues

The generated physical implementation was then independently verified using established EDA tools:

```text
ngspice
Magic
Netgen
OpenLane
OpenROAD
KLayout
```

The final signoff was based on actual tool-generated verification results.

---

# Key Debugging Lessons

The Task 4 development process demonstrated several important physical-design lessons.

## 1. Correct schematic behavior does not guarantee correct physical behavior

A transistor-level circuit can simulate correctly while the physical layout contains:

* incorrect connectivity
* shorts
* wrong select polarity
* extraction mismatches
* incorrect pin ordering

Therefore schematic simulation must be followed by physical verification.

---

## 2. LVS failures must be investigated at the physical level

Changing a schematic simply to make LVS pass can hide a physical-design problem.

The Task 4 debugging process instead followed:

```text
Schematic
    ↓
Layout
    ↓
Extraction
    ↓
LVS
    ↓
Physical correction
```

---

## 3. Macro integration introduces additional connectivity problems

A macro can be internally correct while its integration into the top-level design is incorrect.

The final LVS failure during integration was traced to the macro supply-network connection.

The analog macro's:

```text
met1 VDD/VSS
```

needed to be explicitly connected to the higher-level:

```text
met4 PDN
```

---

## 4. DRC and LVS verify different properties

DRC verifies whether the physical geometry satisfies design rules.

LVS verifies whether the extracted electrical network corresponds to the intended circuit.

Therefore:

```text
DRC = 0
```

does not automatically imply:

```text
LVS = 0
```

Both checks are required.

---

## 5. Reproducibility is an important part of signoff

The final design was not considered complete merely because one successful run existed.

A fresh RTL-to-GDS run was performed using the repository integration design and the specified PDK environment.

The fresh run successfully produced:

```text
DRC = 0
LVS = 0 errors
Flow complete
```

---

# Task 4 Final Status

The final Task 4 implementation consists of:

```text
New transistor-level AMUX2_3V
        ↓
Pre-layout verification
        ↓
AI-assisted physical layout
        ↓
Magic DRC = 0
        ↓
Extraction
        ↓
Post-layout simulation
        ↓
Macro views
        ↓
OpenLane integration
        ↓
Macro PDN correction
        ↓
Detailed routing DRC = 0
        ↓
Final Magic/GDS DRC = 0
        ↓
LVS = 0 errors
        ↓
Circuits match uniquely
        ↓
Fresh reproducibility run = PASS
```

## Final Signoff

```text
AMUX2_3V:
    Functionality              PASS
    Pre-layout simulation      PASS
    Post-layout simulation     PASS
    Macro DRC                  0 violations
    Integrated routing DRC     0 violations
    Final GDS DRC              0 violations
    LVS                         PASS
    LVS errors                  0
    Net mismatches              0
    Device mismatches           0
    Pin mismatches              0
    Property mismatches         0
    Netgen result               Circuits match uniquely
    Setup violations            0
    Hold violations             0
    RTL-to-GDS reproducibility  PASS
```

The final Task 4 result is therefore a **DRC-clean, zero-error-LVS, reproducible SKY130A RTL-to-GDS integration containing the newly designed AI-assisted `AMUX2_3V` analog multiplexer macro**.

---


# Conclusion

Task 4 demonstrates the complete development and physical-verification flow of a new analog multiplexer macro using an AI-assisted physical-design methodology.

The work progressed from:

```text
Reference MUX
```

to:

```text
New transistor-level AMUX2_3V
```

and then through:

```text
Simulation
→ AI-assisted layout
→ DRC
→ Extraction
→ LVS debugging
→ Post-layout simulation
→ Macro generation
→ OpenLane integration
→ PDN debugging
→ Final DRC
→ Final LVS
→ Reproducibility
```

The intermediate LVS failures were retained as part of the engineering history.

The final integrated implementation successfully achieved:

```text
Detailed Routing DRC = 0 violations
Final Magic/GDS DRC = 0 violations
LVS = PASS
LVS Total errors = 0
Net mismatches = 0
Device mismatches = 0
Pin mismatches = 0
Property mismatches = 0
Netgen = Circuits match uniquely
Setup violations = 0
Hold violations = 0
RTL-to-GDS Flow = PASS
```

The final result is a reproducible, physically verified SKY130A implementation of the new `AMUX2_3V` analog multiplexer integrated into the `design_mux` top-level design.

````


