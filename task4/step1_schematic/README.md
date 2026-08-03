# Step 1 – Transistor-Level Schematic and Pre-Layout Simulation

## Objective

Design a fresh transistor-level 2:1 analog multiplexer (AMUX2_3V_NEW) using SKY130 MOSFET models. The new design replaces the placeholder AMUX2_3V used in the original repository and serves as the reference schematic for the remaining physical design flow.

---

## Design Requirements

- Fresh transistor-level implementation
- SKY130 NMOS and PMOS devices
- 2:1 analog multiplexer
- Double-height layout target
- Compatible with Magic, Netgen and OpenLane

---

## Circuit Architecture

The design uses:

- One CMOS inverter to generate the complementary select signal (SELB)
- Two complementary transmission gates
- SKY130 1.8 V NMOS and PMOS transistors

Functional behavior:

| Select | Output |
|---------|--------|
| 0 | OUT = I0 |
| 1 | OUT = I1 |

---

## Files

| File | Description |
|------|-------------|
| `AMUX2_3V_NEW.spice` | Transistor-level schematic |
| `test_AMUX2_3V.spice` | NGSpice testbench |

---

## Verification

The schematic was verified using an NGSpice testbench to confirm:

- Correct select functionality
- Proper transmission-gate operation
- Pre-layout circuit behavior

This transistor-level schematic was then used as the reference design for AI-assisted layout generation in the next step.
