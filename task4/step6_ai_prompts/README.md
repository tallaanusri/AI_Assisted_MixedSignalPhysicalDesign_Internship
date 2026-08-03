# Step 6 – AI-Assisted Layout Generation

## Objective

Use an AI coding assistant to generate a completely new Magic layout from the transistor-level schematic.

## AI Inputs

- Transistor-level SPICE netlist
- SKY130 Magic technology
- Sample Magic layout (reference only)

## AI Output

The AI generated an initial Magic layout.

The generated layout was imported into Magic and subsequently analyzed through DRC, extraction, and LVS.

The first generated layout contained routing errors that produced electrical shorts during extraction. These observations were used to guide subsequent debugging and layout correction.

This step documents the AI-assisted workflow rather than the final verified macro.
