# Step 4 – Layout Extraction

## Objective

Extract the AI-generated Magic layout into an extracted netlist for LVS and post-layout simulation.

---

## Commands Used

Inside Magic:

```tcl
extract all
ext2spice lvs
ext2spice
```

---

## Generated Files

| File | Description |
|------|-------------|
| AMUX2_3V_AI.ext | Magic extraction database |
| AMUX2_3V_AI.spice | Extracted transistor-level SPICE netlist |

---

## Observations

The extraction completed successfully and generated both the `.ext` database and the extracted SPICE netlist.

During extraction, Magic reported electrical shorts between several ports:

- VSS ↔ select
- VSS ↔ I0
- VSS ↔ I1
- VDD ↔ out

These shorts explain why the extracted subcircuit contains only the power pins and why the layout does not yet match the intended schematic. This intermediate result was used to identify layout issues before proceeding to LVS debugging.
