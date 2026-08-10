# AI Prompt – Fresh Magic Layout Generation

## Objective

Generate a completely new double-height 2:1 analog multiplexer layout for the SKY130A process.

The generated layout must **NOT** be copied or modified from the existing placeholder AMUX2_3V.

---

## Inputs

- Transistor-level SPICE netlist
- SKY130 Magic technology file
- Sample Magic layout (reference only for syntax)

---

## Requirements

- Implement a transmission-gate based 2:1 analog multiplexer.
- Double-height standard-cell compatible layout.
- Correct pin names:
  - I0
  - I1
  - select
  - out
  - VDD
  - VSS
- Continuous VDD and VSS rails.
- Proper nwell and pwell generation.
- Correct substrate and well ties.
- Pins accessible for place-and-route.
- Zero DRC violations.
- LVS equivalent to the supplied schematic.
- Produce a valid Magic (.mag) layout.

---

## Expected Outputs

- AMUX2_3V.mag
- DRC-clean layout
- LVS matching schematic
- Compatible with OpenLane integration
