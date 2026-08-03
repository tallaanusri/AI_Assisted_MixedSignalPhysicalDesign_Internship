
# Step 1 – Transistor-Level Schematic Design

## Objective

Design a fresh transistor-level implementation of the AMUX2_3V analog 2:1 multiplexer using SKY130 devices.

The implementation uses:

- SKY130 NMOS and PMOS models
- Transmission-gate architecture
- CMOS inverter for select signal generation

## Functionality

```
Select = 0  →  OUT = I0
Select = 1  →  OUT = I1
```

## Files

| File | Description |
|------|-------------|
| AMUX2_3V_NEW.spice | Complete transistor-level schematic |
| test_AMUX2_3V.spice | ngspice verification testbench |

The schematic was verified using ngspice before physical layout generation.
