# Task 4 – AI Planning Stage (Attempt 2)

You are NOT generating a Magic layout yet.

Your task is to analyze the supplied transistor-level schematic and produce a detailed implementation plan for a NEW SKY130 double-height analog 2:1 transmission-gate MUX.

## Inputs

1. AMUX2_3V_NEW.spice
2. sample_AMUX2_3V.mag (reference for Magic syntax only; DO NOT copy or modify)
3. sky130A.magicrc
4. sky130A.tech

## Functional Requirements

Implement exactly:

SEL = 0  -> OUT = I0
SEL = 1  -> OUT = I1

Use the transmission-gate architecture described in the schematic.

## Required Output

Do NOT generate a .mag file.

Instead provide:

1. Functional analysis of the circuit.

2. List every transistor:
   - Device type
   - Gate
   - Source
   - Drain
   - Bulk
   - Width/Length

3. Explain the transistor placement strategy.

4. Explain the routing strategy.

5. Specify the exact external ports:

I0
I1
SEL
OUT
VDD
VSS

6. Specify the exact port order:

I0 I1 SEL OUT VDD VSS

7. Describe VDD and VSS rails.

8. Describe well ties and substrate ties.

9. Describe pin accessibility for OpenLane PNR.

10. Estimate the final cell dimensions.

11. Identify any possible DRC or LVS risks before layout generation.

IMPORTANT:

Do NOT generate a Magic layout in this response.
