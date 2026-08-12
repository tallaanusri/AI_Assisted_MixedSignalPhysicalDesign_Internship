# Iteration 3 – AI-Assisted AMUX2_3V Layout and DRC Debugging

This iteration documents the latest AI-assisted implementation of the
double-height 2:1 analog MUX replacement for `AMUX2_3V`.

## Step 1 – Transistor-Level Schematic

The transistor-level schematic/netlist was verified using SKY130A device
models and ngspice testbenches for both MUX select states.

Files:
- `step1_schematic/AMUX2_3V.spice`
- `step1_schematic/tb_select0.spice`
- `step1_schematic/tb_select1.spice`

## Step 2 – AI-Assisted Layout

The AI-assisted layout generation used:
- transistor-level SPICE
- SKY130A Magic technology information
- a reference Magic layout
- an explicit AI layout-generation prompt

Intermediate layout versions are preserved to document the iterative
generation and debugging process.

## Step 3 – Magic DRC and Physical Debugging

The generated Magic layout was opened and debugged using Magic 8.3.413
with the SKY130A technology file.

The physical routing was corrected to separate the `select` and `sel_b`
control networks.

The final layout artifact is:

`AMUX2_3V_magic83_DRC0_select_fixed.mag`

The extracted topology contains:
- 3 NFETs
- 3 PFETs
- distinct `select` and internal `sel_b`
- correct MUX transmission-gate polarity

Pin order:

`I0 I1 select out VDD VSS`

## Step 4 – Layout Extraction

Magic extraction was performed and an LVS-style SPICE netlist was generated.

File:

`step4_extraction/AMUX2_3V_extracted.spice`

The extracted subcircuit contains six SKY130 transistors.

## Verification Status

- Transistor-level schematic: completed
- Select-state simulations: completed
- AI-assisted layout generation: completed
- Select/sel_b physical routing correction: completed
- Magic extraction: completed
- Extracted SPICE generation: completed
- Netgen LVS: pending/follow-up verification
