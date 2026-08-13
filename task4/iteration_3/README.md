
# Task 4 – Iteration 3
## AI-Assisted AMUX2_3V Physical Design and OpenLane Integration

Iteration 3 is the most complete implementation attempt of the Task 4 Week-5 analog MUX replacement flow.

The objective was to create a fresh **double-height SKY130A 2:1 analog multiplexer (`AMUX2_3V`)**, verify the transistor-level circuit, generate a new physical layout using an AI-assisted workflow, perform Magic DRC and extraction, investigate LVS, perform post-layout simulation, generate reusable macro views and integrate the macro into an OpenLane RTL-to-GDS flow.

---

# 1. Workflow

```text
Reference Design Analysis
        │
        ▼
Transistor-Level MUX
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
OpenLane RTL-to-GDS
        │
        ▼
PNR / DEF Connectivity Investigation
````

---

# 2. Design Objective

The target circuit is a transistor-level 2:1 analog MUX.

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

The macro was targeted as a double-height SKY130A cell with PNR-accessible external pins.

---

# 3. Step 1 – Transistor-Level Schematic

The canonical transistor-level netlist is:

```text
step1_schematic/AMUX2_3V.spice
```

The select-state testbenches are:

```text
step1_schematic/tb_select0.spice
step1_schematic/tb_select1.spice
```

The circuit was verified using SKY130A transistor models and ngspice.

---

# 4. Step 2 – AI-Assisted Layout

A fresh layout was generated using an AI-assisted workflow.

The AI inputs included:

* transistor-level SPICE
* SKY130A technology information
* sample Magic layout
* external pin requirements
* pin-order requirements
* double-height cell requirement
* power and substrate requirements
* PNR-accessible pins

The layout-generation artifacts are stored in:

```text
step2_ai_layout/
```

Important files include:

```text
AMUX2_3V.mag
AMUX2_3V.spice
prompt_01_fresh_layout.md
sample_AMUX2_3V.mag
sky130A.tech
layout_generation_notes.md
```

The AI-assisted layout process involved multiple iterations and physical corrections.

---

# 5. Step 3 – Magic DRC

Magic was used to verify the generated layout.

The final corrected layout is:

```text
step3_magic_drc/AMUX2_3V_magic83_DRC0_select_fixed.mag
```

The DRC logs are stored in:

```text
step3_magic_drc/
```

The physical correction focused on the `select` and internal complementary `sel_b` control routing.

The final corrected layout revision was verified with zero reported Magic DRC violations.

The correction process is documented in:

```text
step3_magic_drc/AMUX2_3V_select_route_fix_report.txt
step3_magic_drc/layout_fix_iteration_01.md
```

---

# 6. Step 4 – Layout Extraction

The corrected layout was extracted into SPICE.

The extracted netlist is:

```text
step4_extraction/AMUX2_3V_extracted.spice
```

This extracted representation was used for LVS investigation and post-layout simulation.

---

# 7. Step 5 – Netgen LVS

The canonical schematic and extracted layout were compared using Netgen LVS.

The LVS files are:

```text
step5_lvs/schematic.spice
step5_lvs/extracted.spice
step5_lvs/extracted_before_lvs_namefix.spice
step5_lvs/lvs_report.txt
```

## LVS Result

**A clean zero-error LVS match was not achieved.**

The failure was preserved intentionally.

The debugging identified:

### Pin-order mismatch

The intended external pin order is:

```text
I0 I1 select out VDD VSS
```

An extracted revision used a different ordering, producing top-level correspondence errors.

### Selection-connectivity mismatch

The required MUX behavior is:

```text
select = 0 → I0 → out
select = 1 → I1 → out
```

An earlier AI-generated physical implementation produced the opposite input selection.

### Unintended physical connectivity

Earlier layout revisions produced extraction warnings indicating unintended electrical merging between external nets.

These observations demonstrated that the physical implementation had to be corrected rather than modifying the schematic merely to force LVS.

Therefore:

```text
Final clean LVS = NOT ACHIEVED
```

This is explicitly reported as a project limitation.

---

# 8. Step 6 – Post-Layout Simulation

Post-layout simulations were performed using the extracted physical representation.

The simulation directory is:

```text
step6_post_layout_simulation/
```

Important files include:

```text
tb_select0_postlayout.spice
tb_select1_postlayout.spice
measure_select0.cir
measure_select1.cir
postlayout_measurements.txt
```

Raw simulation results are stored in:

```text
step6_post_layout_simulation/results/
```

Both MUX select states were simulated independently.

---

# 9. Step 7 – Macro Views

Reusable macro views were generated under:

```text
step7_macro_views/
```

The generated files include:

```text
AMUX2_3V.gds
AMUX2_3V.lef
AMUX2_3V.lib
AMUX2_3V.mag
AMUX2_3V.spice
AMUX2_3V.v
AMUX2_3V_lvs.spice
```

These provide the physical, abstract, timing, schematic and logical views required for integration.

---

# 10. Step 8 – OpenLane RTL-to-GDS

The macro was integrated into an OpenLane-based top-level design.

The integration directory is:

```text
step8_rtl_to_gds/
```

It contains:

```text
config.tcl
macro.cfg
macro/
src/
```

The macro views used by OpenLane are:

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

# 11. OpenLane PNR Investigation

The integrated design was taken through the OpenLane physical-design flow.

The investigation included:

* macro integration
* placement
* routing
* DEF inspection
* standard-cell connectivity
* constant/tie-cell investigation
* final physical-design artifact inspection

The SKY130A PDK was checked for the required constant/tie-cell implementation.

The PDK contains:

```text
sky130_fd_sc_hd__conb_1
```

Therefore, the final investigation focused on actual DEF instance connectivity and integration behavior rather than assuming that the standard cell was missing.

---

# 12. Verification Summary

| Stage                       | Status                    |
| --------------------------- | ------------------------- |
| Transistor-level schematic  | ✅ Complete                |
| Pre-layout simulation       | ✅ Complete                |
| AI-assisted fresh layout    | ✅ Complete                |
| Physical routing correction | ✅ Complete                |
| Magic DRC                   | ✅ Complete                |
| Layout extraction           | ✅ Complete                |
| LVS investigation           | ⚠️ Complete with mismatch |
| LVS debugging               | ✅ Complete                |
| Post-layout simulation      | ✅ Complete                |
| Macro-view generation       | ✅ Complete                |
| OpenLane integration        | ✅ Complete                |
| PNR investigation           | ✅ Complete                |
| Final clean LVS             | ❌ Not achieved            |

---

# 13. Important Project Integrity Note

This iteration does **not** claim successful LVS signoff.

The LVS mismatch is intentionally preserved and documented because it represents a real physical-equivalence issue.

No schematic modification was performed solely to manufacture an LVS pass.

The iteration demonstrates the complete workflow:

```text
Schematic
   ↓
Simulation
   ↓
AI-Assisted Layout
   ↓
Magic DRC
   ↓
Extraction
   ↓
LVS Investigation
   ↓
Post-Layout Simulation
   ↓
Macro Views
   ↓
OpenLane Integration
   ↓
PNR Investigation
```

The remaining technical limitation is final clean Netgen LVS equivalence.

---

# 14. Directory Structure

```text
iteration_3/
│
├── README.md
│
├── step1_schematic/
│
├── step2_ai_layout/
│
├── step3_magic_drc/
│
├── step4_extraction/
│
├── step5_lvs/
│
├── step6_post_layout_simulation/
│
├── step7_macro_views/
│
└── step8_rtl_to_gds/
```

Each stage contains the inputs, outputs and debugging artifacts associated with that part of the workflow.

---

# 15. Reproducibility

A reviewer can follow the Iteration 3 workflow in this order:

1. Inspect the transistor-level SPICE.
2. Run the select=0 and select=1 pre-layout simulations.
3. Inspect the AI layout-generation prompt and inputs.
4. Open the generated Magic layout.
5. Run Magic DRC.
6. Inspect the corrected physical routing.
7. Extract the layout.
8. Run Netgen LVS.
9. Inspect the LVS report.
10. Run the post-layout simulations.
11. Inspect the generated macro views.
12. Load the macro into the OpenLane configuration.
13. Run the RTL-to-GDS flow.
14. Inspect placement, routing and DEF connectivity.

---

# Final Statement

Iteration 3 represents the most complete Task 4 implementation attempt.

It demonstrates the use of AI-assisted physical-layout generation together with conventional VLSI verification tools including Magic, ngspice, Netgen and OpenLane.

The project successfully completed the major physical-design stages from transistor-level design through layout, DRC, extraction, post-layout simulation, macro generation and OpenLane integration.

The remaining LVS mismatch is explicitly documented with the identified physical causes.

This provides a transparent engineering record of both the successful stages and the remaining verification challenge.
