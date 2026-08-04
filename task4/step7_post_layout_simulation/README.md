# Step 7 – Post-Layout Simulation

## Objective

Prepare the extracted layout netlist for post-layout simulation using ngspice.

## Files

- AMUX2_3V_AI.spice – Extracted layout SPICE.
- test_AMUX2_3V.spice – Simulation testbench.

## Current Status

The extracted layout currently exposes only the VDD and VSS ports because several signal ports were electrically merged during extraction. As a result, post-layout functional simulation is pending until the layout connectivity is corrected and LVS is successfully completed.
