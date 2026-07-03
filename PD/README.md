# Objective :
To implement and analyze the complete RTL-to-GDSII Physical Design flow using OpenLane and the SKY130 Process Design Kit (PDK), encompassing synthesis, floorplanning, placement, clock tree synthesis (CTS), power distribution network (PDN) generation, routing, design rule checking (DRC), layout versus schematic (LVS) verification, and final GDSII generation, while investigating AI-assisted techniques to enhance design understanding, debugging, optimization, and verification.
---
## Stage 1 – Synthesis
Synthesis is the process of converting your Verilog RTL into a gate-level netlist using the standard cells available in the SKY130 technology library.

## Prompt
```
Give me the OpenLane Tcl command used to perform synthesis for the design_mux design. Specify the required input files (design_mux.v and the AMUX2_3V.v black-box module) and identify the synthesized output netlist generated in results/synthesis/design_mux.v
```
## OutPut:
No Output will be generated at this stage.
## Learning
Since our Design is an analog macro, OpenLane cannot synthesize it.So The analog macro remained untouched.
---
## Stage 2 – Floorplanning

