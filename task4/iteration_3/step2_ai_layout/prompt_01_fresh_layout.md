# Task 4 — Fresh AI-Assisted SKY130A Magic Layout for AMUX2_3V

## Objective

Generate a fresh transistor-level Magic layout for the verified
AMUX2_3V 2:1 analog multiplexer.

The layout must be electrically equivalent to the canonical SPICE
netlist provided in:

    AMUX2_3V.spice

Do NOT modify the canonical SPICE netlist.

## Canonical cell interface

The exact subcircuit interface is:

    .subckt AMUX2_3V I0 I1 select out VDD VSS

The physical pins must therefore be:

    I0
    I1
    select
    out
    VDD
    VSS

Preserve this logical interface exactly.

## Required functionality

The MUX must implement:

    select = 0  ->  I0 connected to out
    select = 1  ->  I1 connected to out

Do not reverse this selection behavior.

## Circuit topology

The canonical design contains:

1. One CMOS select inverter:
       select -> sel_b

2. Transmission Gate 0:
       PMOS: out - select - I0 - VDD
       NMOS: out - sel_b - I0 - VSS

   TG0 is enabled when select = 0.

3. Transmission Gate 1:
       PMOS: out - sel_b - I1 - VDD
       NMOS: out - select - I1 - VSS

   TG1 is enabled when select = 1.

The inverter is:

       PMOS: sel_b - select - VDD - VDD
       NMOS: sel_b - select - VSS - VSS

Use the exact transistor connectivity from the supplied SPICE netlist
as the source of truth.

## Devices

Use SKY130A 1.8-V devices:

    sky130_fd_pr__pfet_01v8
    sky130_fd_pr__nfet_01v8

with:

    L = 0.15 um

PMOS:

    W = 1.00 um

NMOS:

    W = 0.50 um

## Layout requirements

Generate a clean double-height standard-cell-style analog macro.

Target approximate dimensions:

    width  = 12 um
    height = 6 um

The exact dimensions may be adjusted slightly if required for
DRC-clean routing, but preserve a compact double-height geometry.

## Power

Provide continuous:

    VDD
    VSS

rails with appropriate PMOS/NMOS well and substrate connections.

PMOS devices must be placed in the appropriate n-well.

NMOS devices must have correct substrate/well connections.

Avoid floating wells and floating substrate regions.

## Routing

Route all transistor terminals according to the canonical SPICE topology.

Required internal nets include:

    sel_b

Required external nets:

    I0
    I1
    select
    out
    VDD
    VSS

Do not electrically short any two unrelated external pins.

In particular:

    VDD must NOT be shorted to out.
    VSS must NOT be shorted to I0.
    VSS must NOT be shorted to I1.
    VSS must NOT be shorted to select.

## Pin requirements

Create clearly labeled Magic ports for:

    I0
    I1
    select
    out
    VDD
    VSS

Pins must be placed on routing-accessible metal layers.

Do not create duplicate ports.

The final extracted subcircuit must preserve the logical pin order:

    I0 I1 select out VDD VSS

## Important lessons from previous failed layout

The previous AI-generated layout was rejected because:

1. The extracted layout had incorrect pin ordering.
2. The MUX selection behavior was reversed.
3. VDD was electrically shorted to out.
4. VSS was electrically shorted to signal pins.
5. The extracted netlist was not equivalent to the canonical SPICE.

Therefore, electrical equivalence is more important than visual
similarity to the reference layout.

## Verification expectation

After generating the Magic file:

1. Open it in Magic using the supplied sky130A.tech.
2. Run Magic DRC.
3. Extract the layout.
4. Inspect the extracted SPICE.
5. Confirm that the extracted topology matches the canonical SPICE.
6. Run Netgen LVS.
7. Only after LVS passes should the layout be treated as final.

## Deliverable

Generate:

    AMUX2_3V.mag

Do not overwrite the supplied sample layout.

The generated layout must be a fresh implementation based on the
canonical SPICE netlist and SKY130A technology file.
