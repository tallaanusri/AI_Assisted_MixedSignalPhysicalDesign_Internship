# Iteration 3 – AI-Assisted AMUX2_3V Layout, DRC, Extraction and LVS Debugging

This iteration documents the latest AI-assisted implementation of the double-height 2:1 analog MUX replacement for `AMUX2_3V`, together with the physical-verification and OpenLane integration debugging performed during the final Week-5 work.

## Step 1 – Transistor-Level Schematic and Pre-Layout Verification

The transistor-level MUX was verified using SKY130A device models and ngspice for both select states.

Required functionality:

```text
select = 0 → I0 → out
select = 1 → I1 → out
```

Nominal pre-layout measurements recorded during development:

| Metric | Select = 0 | Select = 1 |
|---|---:|---:|
| Rise delay | 47.36 ps | 50.96 ps |
| Fall delay | 51.46 ps | 48.37 ps |
| Average VDD current | 1.560 µA | 0.891 µA |

Files include the transistor-level netlist and select-state testbenches.

## Step 2 – AI-Assisted Fresh Layout

The layout was generated as a new physical implementation using:

- transistor-level SPICE
- SKY130A Magic technology information
- a sample/reference Magic layout for technology/context information
- explicit pin-order requirements
- double-height geometry requirements
- power, well and substrate requirements
- PNR-accessible pin requirements
- iterative AI prompts based on physical verification results

The development target was a 12.0 µm × 6.0 µm double-height macro.

Intermediate layout versions are preserved to show the iterative generation/debugging process rather than hiding unsuccessful attempts.

## Step 3 – Magic DRC and Physical Debugging

The generated Magic layout was opened and debugged using Magic 8.3.413 with the SKY130A technology file.

The physical routing was corrected to separate the `select` and internal `sel_b` control networks. The corrected layout artifact is:

```text
AMUX2_3V_magic83_DRC0_select_fixed.mag
```

The corrected topology contains:

- 3 NFETs
- 3 PFETs
- distinct `select` and internal `sel_b`
- intended transmission-gate polarity
- external pin order `I0 I1 select out VDD VSS`

The Magic DRC stage was completed for the corrected layout revision used for extraction.

## Step 4 – Layout Extraction

Magic extraction was performed and an LVS-style SPICE netlist was generated.

File:

```text
step4_extraction/AMUX2_3V_extracted.spice
```

The extracted representation contains six SKY130 transistors and was used as the physical netlist for LVS debugging.

## LVS Verification and Debugging

Netgen LVS was executed, but the final comparison did not reach a clean zero-error match. The failure was investigated rather than hidden or bypassed.

### Identified causes

1. **Pin-order mismatch** – an earlier extracted layout revision presented the external subcircuit pins in a different order from the canonical schematic. The intended order is `I0 I1 select out VDD VSS`.

2. **Reversed MUX selection connectivity** – an earlier generated physical implementation was found to select I1 when `select=0` and I0 when `select=1`, opposite to the required schematic behavior.

3. **Unintended extracted shorts** – Magic extraction of an earlier generated layout reported electrical merges including `VSS` with `select`, `I1` and `I0`, and `VDD` with `out`.

4. **Physical netlist mismatch** – these connectivity differences caused the extracted SPICE topology to differ from the canonical transistor-level reference, so Netgen could not establish equivalence.

The schematic was not modified merely to force an LVS match. The mismatches were traced back to physical geometry, extraction and connectivity.

## OpenLane Integration Debugging

The new macro was integrated into the OpenLane flow and a clean-run investigation was performed.

The latest final DEF examined was:

```text
/openlane/designs/task4_iteration3/runs/RUN_2026.08.13_05.44.08/results/final/def/design_mux.def
```

During the final integration debugging, SKY130A standard-cell tie-cell availability was also checked. The selected PDK contains:

```text
sky130_fd_sc_hd__conb_1
```

in:

```text
/root/.ciel/ciel/sky130/versions/f6eeac7dad085ffcc829ccfd721f7b4ce39edcf7/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef
```

Therefore, the CONB investigation was narrowed to actual final-DEF instance connectivity and integration behavior rather than a missing standard-cell LEF.

## Verification Status

- Transistor-level schematic: **completed**
- Select-state pre-layout simulations: **completed**
- AI-assisted fresh layout generation: **completed**
- Select/sel_b physical routing correction: **completed**
- Magic DRC: **completed for the corrected macro revision**
- Magic extraction: **completed**
- Extracted SPICE generation: **completed**
- Netgen LVS: **not clean; debugging documented**
- OpenLane integration/PNR investigation: **completed for the current iteration**
- Final clean LVS: **remaining limitation**

## Evidence to Attach

The final GitHub evidence package should include screenshots of:

```text
01_schematic_netlist.png
02_pre_layout_select0.png
03_pre_layout_select1.png
04_ai_layout_prompt.png
05_generated_mux_magic_layout.png
06_magic_drc_zero.png
07_extracted_spice.png
08_netgen_lvs_debug.png
09_openlane_config.png
10_openlane_placement.png
11_openlane_routing.png
12_final_def_conb.png
13_final_drc.png
14_final_lvs_debug.png
15_post_layout_select0.png
16_post_layout_select1.png
17_area_delay_comparison.png
```

These screenshots should be added after capture so the repository contains visual evidence alongside the source files and logs.
