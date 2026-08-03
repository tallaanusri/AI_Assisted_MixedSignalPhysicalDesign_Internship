# Step 4 – Layout Extraction

## Objective

Extract the AI-generated Magic layout into an electrical netlist for LVS verification.

---

## Input

- AMUX2_3V_AI.mag

---

## Magic Extraction Commands

```
extract all
ext2spice lvs
ext2spice
```

---

## Output Files

- AMUX2_3V_AI.ext
- AMUX2_3V_AI.spice

---

## Result

Magic successfully generated the extracted database (.ext) and SPICE netlist (.spice) from the layout.

The extracted SPICE netlist was used as the layout netlist during LVS verification.

---

## Observation

During extraction, Magic reported that several ports were electrically shorted:

- VSS ↔ select
- VSS ↔ I0
- VSS ↔ I1
- VDD ↔ out

These warnings indicated connectivity issues in the AI-generated layout and became the starting point for the LVS debugging process.

