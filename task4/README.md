# Task 4 – Week 5: AI-Assisted Analog MUX Physical Design (SKY130)

=======
## Project Overview

This repository documents the complete implementation of **Task 4 – Week 5** of the AI-Assisted Mixed-Signal Physical Design Internship.

The objective is to design, verify, and integrate a new **double-height 2:1 analog multiplexer (AMUX2_3V)** using the SKY130 open-source PDK. The project follows a complete custom IC design flow from transistor-level schematic to physical layout, verification, reusable macro generation, and OpenLane integration.

---

## Task Objectives

* Design a transistor-level 2:1 analog multiplexer using SKY130 devices.
* Verify functionality using ngspice.
* Generate a new Magic layout with AI assistance.
* Achieve zero Magic DRC violations.
* Extract the physical layout into SPICE.
* Perform LVS verification between schematic and layout.
* Generate reusable macro views (.mag, .gds, .lef, extracted SPICE).
* Integrate the macro into an OpenLane design.
* Perform post-layout simulation and compare with the pre-layout design.

---

# Project Workflow

```
Transistor Schematic
        │
        ▼
Pre-layout ngspice Verification
        │
        ▼
AI Prompt Generation
        │
        ▼
AI-generated Magic Layout
        │
        ▼
Magic DRC (0 Violations)
        │
        ▼
Layout Extraction
        │
        ▼
LVS Verification & Debugging
        │
        ▼
Reusable Macro Generation
        │
        ▼
OpenLane Integration
        │
        ▼
Post-layout Simulation
```

---

# Repository Structure

```
task4/

├── step1_schematic/
├── step2_ai_layout/
├── step3_drc/
├── step4_extraction/
├── step5_lvs/
├── step6_ai_prompts/
├── step7_final_layout/
├── step7_post_layout_simulation/
└── step8_macro_views/
```

---

# Current Progress

| Step                          | Status                              |
| ----------------------------- | ----------------------------------- |
| Transistor-level schematic    | ✅ Completed                         |
| Pre-layout ngspice simulation | ✅ Completed                         |
| AI prompt generation          | ✅ Completed                         |
| AI-generated Magic layout     | ✅ Completed                         |
| Magic DRC                     | ✅ 0 Violations                      |
| Layout extraction             | ✅ Completed                         |
| LVS debugging                 | ✅ Completed (root cause identified) |
| Macro view generation         | ✅ Completed                         |
| OpenLane integration          | ⏳ In Progress                       |
| Post-layout simulation        | ⏳ Pending after LVS correction      |

---

# Generated Macro Views

The following reusable macro views have been generated:

* AMUX2_3V_AI.mag
* AMUX2_3V_AI.gds
* AMUX2_3V_AI.lef
* AMUX2_3V_AI.spice

These files are located in **step8_macro_views/**.

---

# Current Verification Status

### Completed

* Transistor-level schematic verified.
* AI-generated Magic layout created.
* Magic DRC completed with **zero violations**.
* Layout extraction completed successfully.
* GDS and LEF generated from the Magic layout.
* LVS debugging performed and documented.

### Current Issue

Although the layout is DRC-clean, layout extraction revealed that several signal ports were electrically merged with the power rails. Consequently, the extracted SPICE interface does not yet match the schematic, preventing successful LVS and post-layout simulation. This behavior has been analyzed and documented in the LVS debugging section.

---

# Remaining Work

* Correct layout connectivity.
* Re-extract the layout.
* Achieve successful Netgen LVS.
* Perform post-layout ngspice simulation.
* Compare pre-layout and post-layout performance.
* Complete OpenLane PNR integration.
* Generate remaining supported macro views (DEF, SPEF, Liberty where applicable).

---

# Tools Used

* Magic VLSI
* Netgen
* ngspice
* OpenLane
* SKY130A PDK
* Docker
* GitHub
* AI-assisted layout generation (Codex)

---

This repository captures the complete design workflow, verification process, debugging methodology, generated artifacts, and ongoing integration of an AI-assisted analog multiplexer within the SKY130 open-source physical design flow.
>>>>>>> 6260b55 (Add Task 4 documentation, AI layout artifacts, and macro views)
