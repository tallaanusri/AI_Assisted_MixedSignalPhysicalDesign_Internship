# Step 5 – LVS Analysis

## Objective

Compare the extracted layout netlist with the intended transistor-level schematic to verify that both describe the same circuit.

---

## Compared Netlists

| Netlist | Purpose |
|---------|---------|
| AMUX2_3V_SUBCKT.spice | Intended schematic |
| AMUX2_3V_AI.spice | Extracted layout |

---

## LVS Observations

The extracted layout does not match the intended schematic.

Major issues identified:

1. Electrical shorts between ports.
2. Incorrect subcircuit interface.
3. Missing signal pins after extraction.
4. Layout connectivity differs from the intended transmission-gate MUX.

Extracted subcircuit:

```
.subckt AMUX2_3V_AI VDD VSS
```

Expected interface:

```
.subckt AMUX2_3V
I0 I1 select out VDD VSS
```

---

## Root Cause

Magic extraction reported that several signal pins were electrically shorted to the power rails.

As a result:

- I0 merged with VSS
- I1 merged with VSS
- select merged with VSS
- out merged with VDD

Because of these shorts, Magic removed the signal ports during extraction, leaving only VDD and VSS in the extracted netlist.

---

## Conclusion

The layout is **not LVS clean** and requires physical routing corrections before it can replace the original placeholder AMUX macro.
