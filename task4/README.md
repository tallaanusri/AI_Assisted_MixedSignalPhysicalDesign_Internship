# Task 4 – Week 5: AI-Assisted Analog MUX Physical Design (SKY130)

## Project Overview

This repository documents **Task 4 – Week 5** of the AI-Assisted Mixed-Signal Physical Design Internship: the design and integration of a new **double-height 2:1 analog multiplexer (AMUX2_3V)** intended to replace the placeholder MUX used by the reference design.

The work covers transistor-level design, ngspice verification, AI-assisted physical-layout generation, Magic DRC/extraction, LVS analysis and debugging, reusable macro generation, and OpenLane integration/PNR investigation.

```text
Transistor-Level Design
        │
        ▼
Pre-Layout ngspice Verification
        │
        ▼
AI-Assisted Fresh Layout Generation
        │
        ▼
Magic Layout / DRC
        │
        ▼
Layout Extraction
        │
        ▼
Netgen LVS + Debugging
        │
        ▼
Macro Views
        │
        ▼
OpenLane Integration / PNR
```

The repository intentionally preserves multiple iterations so that the AI-assisted design process, successful stages, failed attempts, and debugging decisions remain reproducible and auditable.

---

# Design Objective

The target macro is a transistor-level 2:1 analog MUX with:

- Analog inputs: `I0`, `I1`
- Select: `select`
- Output: `out`
- Supply: `VDD`
- Ground: `VSS`
- SKY130A transistor implementation
- Double-height physical macro
- PNR-accessible external pins

Required functionality:

```text
select = 0  →  I0 → out
select = 1  →  I1 → out
```

The schematic was verified before physical implementation.

---

# Iteration History

## Iteration 1

`iteration_1/` records the initial transistor-level design, first AI-assisted layout, Magic extraction and initial LVS attempt. It established the baseline flow and exposed physical-connectivity issues.

## Iteration 2

`iteration_2/` records further AI-assisted layout generation, alternative layouts, Magic implementation, extraction, post-layout artifacts and reusable macro views.

## Iteration 3 – Current Final Debugging Iteration

`iteration_3/` records the latest clean/restarted implementation and OpenLane integration work. This is the primary iteration for the final Week-5 documentation.

Current structure:

```text
iteration_3/
├── README.md
├── step1_schematic/
├── step2_ai_layout/
├── step3_magic_drc/
└── step4_extraction/
```

The latest iteration focuses on a fresh double-height layout, physical routing correction, extraction, LVS investigation and final OpenLane integration/debugging.

---

# Transistor-Level and Pre-Layout Verification

The transistor-level MUX was simulated using SKY130A models and ngspice under the nominal verification conditions used during development:

- SKY130A TT corner
- 27 °C
- `VDD = 1.8 V`
- 20 fF output load

Measured pre-layout results:

| Metric | Select = 0 | Select = 1 |
|---|---:|---:|
| Function | `I0 → out` | `I1 → out` |
| Rise delay | 47.36 ps | 50.96 ps |
| Fall delay | 51.46 ps | 48.37 ps |
| Average VDD current | 1.560 µA | 0.891 µA |

An important early debugging result was the identification of SKY130 W/L parameter units in the primitive wrappers. The wrappers expect W/L values in micrometre units; incorrect scaling initially caused model-selection problems in ngspice.

---

# AI-Assisted Layout Generation

The new layout was generated as a fresh physical implementation using an AI-assisted workflow rather than copying the existing MUX layout.

AI inputs included:

1. Transistor-level SPICE netlist.
2. SKY130A Magic technology information.
3. A sample/reference `.mag` file for technology/layout context.
4. Explicit pin names and pin-order requirements.
5. Double-height cell requirements.
6. Power/well/substrate requirements.
7. PNR-accessible pin requirements.
8. Iterative correction prompts based on DRC, extraction and LVS observations.

The generated layout was targeted as a **12.0 µm × 6.0 µm double-height cell** in the development flow.

---

# Magic DRC and Physical Debugging

Magic was used to inspect and verify the generated layout. The latest iteration corrected the physical routing between the `select` and internal `sel_b` control networks.

The final DRC-oriented layout artifact in Iteration 3 is:

```text
iteration_3/step3_magic_drc/AMUX2_3V_magic83_DRC0_select_fixed.mag
```

The corrected extracted topology contains:

- 3 NFETs
- 3 PFETs
- distinct `select` and internal `sel_b` networks
- transmission-gate polarity corresponding to the intended MUX structure
- external pin order: `I0 I1 select out VDD VSS`

The Magic physical-verification stage was therefore successfully completed for the generated macro revision used for subsequent extraction/integration work.

---

# Extraction

Magic extraction was performed to convert the physical geometry into an electrical representation.

The latest extracted SPICE artifact is preserved under:

```text
iteration_3/step4_extraction/AMUX2_3V_extracted.spice
```

Extraction was essential for comparing the actual physical connectivity against the canonical transistor-level netlist.

---

# LVS Verification and Debugging

## Final Status

**Netgen LVS did not reach a clean zero-error match.** The failure is intentionally documented rather than hidden or bypassed.

The debugging process identified several concrete causes.

### 1. External pin-order mismatch

The canonical schematic interface was:

```text
I0 I1 select out VDD VSS
```

An earlier extracted layout revision produced a different subcircuit ordering, for example:

```text
select I0 out I1 VSS VDD
```

This caused top-level pin/net correspondence errors during Netgen comparison.

### 2. Reversed MUX selection connectivity

The intended function is:

```text
select = 0 → I0 → out
select = 1 → I1 → out
```

An earlier AI-generated physical implementation was found to implement the opposite correspondence:

```text
select = 0 → I1 → out
select = 1 → I0 → out
```

This was identified as a genuine physical-connectivity/functionality problem, not merely a naming difference.

### 3. Unintended physical shorts in an earlier generated layout

Magic extraction reported electrical merges including:

```text
VSS ↔ select
VSS ↔ I1
VSS ↔ I0
VDD ↔ out
```

These extraction warnings demonstrated that the physical geometry did not represent the intended six-terminal electrical network in that revision.

### 4. Extracted topology differed from the canonical schematic

Because the physical layout contained unintended connectivity and pin-order differences, the extracted SPICE representation could not be expected to match the canonical transistor-level reference. The debugging process therefore focused on the physical implementation rather than modifying the schematic simply to force LVS.

### 5. OpenLane CONB/tie-cell investigation

During the final OpenLane integration investigation, the SKY130A standard-cell LEF was checked for the `sky130_fd_sc_hd__conb_1` macro.

The PDK was verified to contain:

```text
/root/.ciel/ciel/sky130/versions/f6eeac7dad085ffcc829ccfd721f7b4ce39edcf7/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef
```

and this LEF contains:

```text
MACRO sky130_fd_sc_hd__conb_1
```

Therefore, the investigation was narrowed to actual DEF instance connectivity and integration behavior rather than assuming that the CONB cell was missing from the PDK.

### LVS conclusion

The LVS failure is treated as a real physical-equivalence issue. No schematic-side changes were used solely to manufacture an LVS pass.

---

# OpenLane Integration and PNR Investigation

The new macro was integrated into the OpenLane-based mixed-signal/digital top-level flow. A clean final-run investigation was performed using the current Task 4 iteration-3 environment.

Latest final DEF under investigation:

```text
/openlane/designs/task4_iteration3/runs/RUN_2026.08.13_05.44.08/results/final/def/design_mux.def
```

The final DEF was inspected for standard-cell constant/tie-cell connectivity, while the SKY130A LEF was independently checked to confirm that the required `conb_1` macro exists.

The PNR/integration evidence is preserved through the Iteration 3 workspace and the command/log records used during debugging.

---

# Verification Summary

| Stage | Status | Notes |
|---|---|---|
| Transistor-level MUX | ✅ Completed | SKY130A transistor-level implementation |
| Pre-layout ngspice | ✅ Completed | Both select states verified |
| AI-assisted fresh layout | ✅ Completed | Fresh double-height layout generated |
| Physical routing correction | ✅ Completed | `select` / `sel_b` connectivity corrected |
| Magic DRC | ✅ Completed | DRC-clean layout revision documented |
| Magic extraction | ✅ Completed | Extracted SPICE generated |
| LVS analysis | ⚠️ Completed with failure | Debugging performed; clean match not achieved |
| LVS root-cause analysis | ✅ Completed/documented | Pin order, selection connectivity, physical shorts identified |
| Macro artifacts | ✅ Generated | `.mag`, extracted SPICE and integration views preserved where available |
| OpenLane integration | ✅ Performed | New macro integrated into PNR flow |
| Final CONB investigation | ✅ Performed | SKY130A LEF and final DEF connectivity inspected |
| Final clean LVS | ❌ Not achieved | Remaining limitation |

---

# Important Project Integrity Note

This repository does **not** claim that the final AMUX2_3V macro is LVS-clean. The purpose of preserving the LVS failure and its debugging evidence is to demonstrate the complete AI-assisted physical-design workflow and the ability to diagnose discrepancies between schematic intent, physical geometry, extraction and PNR integration.

The strongest confirmed results are the transistor-level simulation, fresh AI-assisted layout generation, physical routing correction, Magic DRC/extraction, macro generation and OpenLane integration/debugging. The remaining technical gap is a fully clean Netgen LVS match and the dependent final post-layout equivalence claim.

---

# Evidence and Screenshot Plan

Screenshots should be added under a dedicated evidence directory as they are captured. Recommended evidence includes:

```text
evidence/
├── 01_schematic_netlist.png
├── 02_pre_layout_select0.png
├── 03_pre_layout_select1.png
├── 04_ai_layout_prompt.png
├── 05_generated_mux_magic_layout.png
├── 06_magic_drc_zero.png
├── 07_extracted_spice.png
├── 08_netgen_lvs_debug.png
├── 09_openlane_config.png
├── 10_openlane_placement.png
├── 11_openlane_routing.png
├── 12_final_def_conb.png
├── 13_final_drc.png
├── 14_final_lvs_debug.png
├── 15_post_layout_select0.png
├── 16_post_layout_select1.png
└── 17_area_delay_comparison.png
```

Each screenshot should show enough terminal/tool context to make the result reproducible and auditable.

---

# Recommended Repository Navigation

### Schematic and pre-layout verification

```text
iteration_3/step1_schematic/
```

### AI-assisted layout

```text
iteration_3/step2_ai_layout/
```

### Magic DRC and physical correction

```text
iteration_3/step3_magic_drc/
```

### Extraction

```text
iteration_3/step4_extraction/
```

### Earlier iterations

```text
iteration_1/
iteration_2/
```

These preserve previous generated layouts, extraction results, LVS attempts and AI-assisted refinement history.

---

# Tools

- SKY130A PDK
- Magic VLSI
- Netgen LVS
- ngspice
- OpenLane
- OpenROAD
- Docker
- Git / GitHub
- AI-assisted layout-generation workflow

---

# Final Project Statement

Task 4 demonstrates an end-to-end AI-assisted mixed-signal physical-design workflow for replacing a placeholder analog MUX with a newly generated double-height SKY130 macro. The project successfully established and exercised the schematic → simulation → AI layout → DRC → extraction → LVS → macro → OpenLane/PNR workflow. The remaining LVS mismatch is explicitly documented with its diagnosed physical causes, providing a transparent engineering record rather than an artificially forced verification result.
