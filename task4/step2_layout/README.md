# Step 2 – AI Generated Magic Layout

## Objective

Generate a completely new double-height 2:1 analog MUX layout using AI assistance instead of modifying the existing placeholder macro.

## Input Files

- AMUX2_3V_NEW.spice
- SKY130 Magic technology
- Sample AMUX2_3V.mag (reference only)

## AI Workflow

1. Provided transistor-level netlist.
2. Provided SKY130 Magic technology.
3. Used iterative prompts to generate a fresh layout.
4. Imported the generated layout into Magic.

## Result

Generated file:

AMUX2_3V_AI.mag

This is a fresh AI-generated layout and was used for DRC/LVS verification in later steps.
