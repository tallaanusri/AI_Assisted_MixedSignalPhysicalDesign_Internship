# Task 4 – Week 5: AI-Assisted Analog MUX Physical Design (SKY130)

## Project Overview

This repository documents the implementation of **Task 4 – Week 5** of the AI-Assisted Mixed-Signal Physical Design Internship.

The objective is to design and integrate a new **double-height 2:1 analog multiplexer (AMUX2_3V)** using the open-source **SKY130A PDK**.

The work follows a custom analog IC physical-design flow:

```text
Transistor-Level Design
        │
        ▼
Pre-Layout ngspice Verification
        │
        ▼
AI-Assisted Layout Generation
        │
        ▼
Magic Layout Development
        │
        ▼
Magic DRC
        │
        ▼
Layout Extraction
        │
        ▼
LVS Verification and Debugging
        │
        ▼
Post-Layout Simulation
        │
        ▼
Macro Views
        │
        ▼
OpenLane Integration
```

The repository is organized into **two iterations** to clearly distinguish the initial implementation from the subsequent AI-assisted layout refinement and verification work.

---

# Design Objective

The target circuit is a **2:1 analog multiplexer** with:

* Analog inputs: `I0`, `I1`
* Select input: `select`
* Output: `out`
* Supply: `VDD`
* Ground: `VSS`
* SKY130 transistor-level implementation
* Double-height physical macro suitable for integration into a digital/analog mixed-signal flow

The intended functionality is:

```text
select = 0  →  I0 → out
select = 1  →  I1 → out
```

The circuit was first verified at the transistor level using ngspice before proceeding to physical layout.

---

# Iteration 1 – Initial Physical Design

The first iteration represents the initial schematic-to-layout implementation and verification attempt.

```text
iteration_1/
│
├── step1_schematic/
│   ├── AMUX2_3V_NEW.spice
│   ├── test_AMUX2_3V.spice
│   └── README.md
│
├── step2_ai_layout/
│   ├── AMUX2_3V_AI.mag
│   └── README.md
│
├── step3_drc/
│   ├── AMUX2_3V_AI.mag
│   └── README.md
│
├── step4_extraction/
│   ├── AMUX2_3V_AI.ext
│   ├── AMUX2_3V_AI.spice
│   ├── extraction_warnings.txt
│   └── README.md
│
└── step5_lvs/
    ├── AMUX2_3V_AI.spice
    ├── AMUX2_3V_SUBCKT.spice
    ├── lvs_summary.txt
    └── README.md
```

### Iteration 1 Results

The initial implementation successfully established the basic physical-design flow:

* Transistor-level SPICE netlist created.
* Pre-layout ngspice testbench created.
* Initial AI-assisted Magic layout generated.
* Magic DRC performed.
* Layout extraction performed.
* Extracted SPICE generated.
* Netgen LVS comparison performed.
* LVS mismatches were identified and documented.

The LVS results showed that the initial physical implementation was **not electrically equivalent to the intended schematic**, motivating a second layout-generation and debugging iteration.

---

# Iteration 2 – AI-Assisted Layout Refinement

The second iteration contains the refined AI-assisted workflow, layout alternatives, Magic implementation, extraction, final netlist, post-layout simulation artifacts, and reusable macro views.

```text
iteration_2/
│
├── step1_ai_assisted_design/
│   ├── inputs/
│   ├── prompts/
│   └── README.md
│
├── step2_layout_generation/
│   ├── AI_layout_prompt.md
│   ├── AMUX2_3V_AI.mag
│   ├── layout_spec.md
│   └── README.md
│
├── step3_layout_iterations/
│   ├── AMUX2_3V_attempt1.mag
│   ├── AMUX2_3V_attempt2_gemini.mag
│   └── design_iteration_notes.md
│
├── step4_magic_layout/
│   ├── AMUX2_3V_AI.mag
│   ├── AMUX2_3V_AI_old.mag
│   ├── AMUX2_3V_attempt2_gemini.mag
│   ├── AMUX2_3V_gemini_test.mag
│   ├── AMUX2_3V_AI.ext
│   ├── AMUX2_3V_AI.spice
│   └── README.md
│
├── step6_extraction/
│   ├── AMUX2_3V_AI.ext
│   ├── AMUX2_3V_AI.spice
│   └── README.md
│
├── step7_final_netlist/
│   ├── AMUX2_3V_NEW.spice
│   └── README.md
│
├── step8_post_layout_simulation/
│   ├── AMUX2_3V_AI.spice
│   ├── AMUX2_3V_SUBCKT.spice
│   ├── test_AMUX2_3V.spice
│   └── README.md
│
└── step9_macro_views/
    ├── AMUX2_3V_AI.mag
    ├── AMUX2_3V_AI.gds
    ├── AMUX2_3V_AI.lef
    ├── AMUX2_3V_AI.spice
    └── README.md
```

---

# AI-Assisted Design Workflow

The second iteration explicitly documents the AI-assisted methodology used to generate and refine the physical layout.

The AI workflow used:

1. Transistor-level SPICE netlist as circuit input.
2. SKY130 Magic technology information.
3. Reference/sample Magic layout.
4. Explicit pin-order and connectivity requirements.
5. Double-height layout requirements.
6. Power and ground rail requirements.
7. Iterative layout-generation prompts.
8. Manual inspection and verification of generated layouts.
9. Magic DRC and extraction.
10. LVS comparison and debugging.

The prompts and supporting files are preserved under:

```text
iteration_2/step1_ai_assisted_design/
```

and:

```text
iteration_2/step2_layout_generation/
```

This makes the AI-assisted design process reproducible rather than storing only the final layout artifact.

---

# Layout Iterations

Multiple physical-layout alternatives were generated during the second iteration.

They are preserved under:

```text
iteration_2/step3_layout_iterations/
```

including:

* `AMUX2_3V_attempt1.mag`
* `AMUX2_3V_attempt2_gemini.mag`
* `design_iteration_notes.md`

This folder records the evolution of the layout rather than hiding unsuccessful intermediate attempts.

---

# Verification Status

## Completed

* Transistor-level AMUX2_3V design created.
* Pre-layout ngspice verification performed.
* AI-assisted layout-generation workflow established.
* Multiple Magic layout iterations generated.
* Magic DRC performed.
* Layout extraction performed.
* Extracted SPICE generated.
* Netgen LVS analysis performed.
* LVS mismatch/root causes investigated.
* Post-layout simulation artifacts prepared.
* GDS and LEF macro views generated.
* Reusable Magic/SPICE macro artifacts generated.

## LVS Status

The current layout reached the stage where LVS could be executed, but the extracted physical connectivity does **not yet fully match the canonical transistor-level schematic**.

The main issues identified during debugging include:

* Layout and schematic pin-order differences.
* Incorrect correspondence between the select signal and the two analog inputs in the physical implementation.
* Extracted layout connectivity showing unintended electrical shorts/merges in the earlier AI-generated layout.

Therefore, the current repository should be understood as documenting an **AI-assisted iterative physical-design and debugging workflow**, rather than claiming a final LVS-clean macro.

---

# Macro Views

The second iteration contains generated macro artifacts under:

```text
iteration_2/step9_macro_views/
```

Available views include:

```text
AMUX2_3V_AI.mag
AMUX2_3V_AI.gds
AMUX2_3V_AI.lef
AMUX2_3V_AI.spice
```

These artifacts represent the physical macro generated from the Magic layout and are intended for subsequent integration and verification.

---

# Pre-Layout Simulation

The transistor-level design was verified using ngspice before physical implementation.

The simulations evaluated both select states:

```text
select = 0
I0 → out

select = 1
I1 → out
```

The pre-layout simulation was performed using SKY130 transistor models under the selected nominal operating conditions.

The corresponding netlist and testbench are available under:

```text
iteration_1/step1_schematic/
```

and the refined design artifacts are preserved under:

```text
iteration_2/step7_final_netlist/
```

---

# Tools and Technologies

The project uses:

* **SKY130A PDK**
* **Magic VLSI**
* **Netgen LVS**
* **ngspice**
* **OpenLane**
* **Docker**
* **Git / GitHub**
* **AI-assisted layout generation**

---

# Repository Navigation

For evaluation or reproduction, the recommended order is:

### Initial implementation

```text
iteration_1/
```

This shows the original schematic, layout, DRC, extraction, and LVS attempt.

### AI-assisted refinement

```text
iteration_2/step1_ai_assisted_design/
```

Review the AI inputs and prompts.

### Layout generation

```text
iteration_2/step2_layout_generation/
```

Review the layout specification and generated layout.

### Layout alternatives

```text
iteration_2/step3_layout_iterations/
```

Review the different AI-generated layout attempts.

### Magic implementation

```text
iteration_2/step4_magic_layout/
```

Review the Magic layout and associated extraction artifacts.

### Extraction

```text
iteration_2/step6_extraction/
```

Review the extracted `.ext` and SPICE representations.

### Final circuit netlist

```text
iteration_2/step7_final_netlist/
```

Review the canonical transistor-level netlist used for comparison.

### Post-layout simulation

```text
iteration_2/step8_post_layout_simulation/
```

Review the extracted subcircuit and simulation testbench.

### Macro views

```text
iteration_2/step9_macro_views/
```

Review the generated `.mag`, `.gds`, `.lef`, and SPICE macro views.

---

# Overall Project Status

| Area                             | Status                         |
| -------------------------------- | ------------------------------ |
| Transistor-level design          | ✅ Completed                    |
| Pre-layout simulation            | ✅ Completed                    |
| AI-assisted layout generation    | ✅ Completed                    |
| Layout iterations                | ✅ Documented                   |
| Magic layout                     | ✅ Generated                    |
| Magic DRC                        | ✅ Performed                    |
| Layout extraction                | ✅ Completed                    |
| LVS analysis                     | ⚠️ Debugging/documented        |
| Post-layout simulation artifacts | ✅ Prepared                     |
| GDS generation                   | ✅ Completed                    |
| LEF generation                   | ✅ Completed                    |
| Macro packaging                  | ✅ Completed                    |
| OpenLane integration             | 🔄 Subsequent integration work |

---

# Purpose of the Two-Iteration Structure

The repository intentionally preserves both design iterations.

**Iteration 1** demonstrates the initial implementation and establishes the baseline physical-design flow.

**Iteration 2** demonstrates the AI-assisted refinement process, including prompt development, multiple layout attempts, Magic implementation, extraction, LVS debugging, simulation preparation, and macro generation.

Keeping both iterations makes the development process transparent and demonstrates how AI-generated physical design artifacts were progressively evaluated and refined.

---

## Note

Generated extraction and simulator log files may be excluded from Git when they are covered by the corresponding `.gitignore` rules. The repository therefore preserves the important reproducible design inputs, layouts, prompts, verification artifacts, and macro views without unnecessarily tracking transient tool-generated files.
