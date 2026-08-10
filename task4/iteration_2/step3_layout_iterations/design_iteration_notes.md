# Task 4 – AI Layout Generation Iterations

## Attempt 1
- AI-generated Magic layout.
- Layout opened in Magic.
- Extraction completed.
- Extraction reported electrical shorts:
  - VSS shorted to SEL
  - VSS shorted to I0
  - VSS shorted to I1
  - VDD shorted to OUT
- Extracted SPICE contained only VDD and VSS ports.
- Result: LVS could not proceed.

## Attempt 2 (Gemini)
- Generated using Gemini 3.1 Pro.
- Created a completely new Magic layout from the transistor-level SPICE netlist.
- Preserved the required six ports:
  - I0
  - I1
  - SEL
  - OUT
  - VDD
  - VSS
- Current status:
  - Layout generated.
  - Pending DRC, extraction, and LVS verification.
