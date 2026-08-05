# Task 4 – Attempt 2
## Generate a NEW SKY130 Double-Height Analog MUX Layout

You are generating a BRAND NEW Magic layout.

DO NOT modify, repair, edit, copy, or derive from the existing AMUX2_3V layout.

The supplied sample .mag file is ONLY a formatting reference for Magic syntax and layer usage.

Generate an entirely new transistor placement and routing from the transistor-level schematic.

----------------------------------------------------------
INPUT FILES
----------------------------------------------------------

AMUX2_3V_NEW.spice
sample_AMUX2_3V.mag (reference format only)

----------------------------------------------------------
TARGET
----------------------------------------------------------

Design a SKY130 double-height 2:1 analog transmission-gate multiplexer.

Required function:

SEL=0
OUT=I0

SEL=1
OUT=I1

----------------------------------------------------------
CELL REQUIREMENTS
----------------------------------------------------------

Technology:
sky130A

Magic format only

Double-height standard-cell compatible

Approximate dimensions:

12um × 6um

----------------------------------------------------------
PORTS
----------------------------------------------------------

Exactly six ports:

I0
I1
SEL
OUT
VDD
VSS

No extra ports.

No missing ports.

Port order must be:

I0 I1 SEL OUT VDD VSS

----------------------------------------------------------
LAYOUT REQUIREMENTS
----------------------------------------------------------

Use SKY130 primitive devices.

Proper PMOS in nwell.

Proper NMOS in psubstrate.

Continuous VDD rail.

Continuous VSS rail.

Proper well taps.

Proper substrate taps.

No floating diffusion.

No floating wells.

No disconnected poly.

No shorted pins.

Pins must be on Metal1 or Metal2.

Pins must be accessible by PNR.

Every pin must be labelled.

Every pin must be declared as a Magic port.

----------------------------------------------------------
TRANSISTORS
----------------------------------------------------------

Implement the transmission-gate MUX exactly as described by the supplied schematic.

Do not simplify the circuit.

Do not change transistor sizes.

Do not swap I0/I1.

Do not invert SEL.

----------------------------------------------------------
MAGIC OUTPUT
----------------------------------------------------------

Return a complete Magic .mag file.

Include:

magic
tech sky130A

labels

ports

geometry

layers

No placeholders.

No pseudo-code.

----------------------------------------------------------
SUCCESS CRITERIA
----------------------------------------------------------

The layout MUST satisfy:

Magic DRC = 0

Magic extraction produces:

.subckt AMUX2_3V_AI I0 I1 SEL OUT VDD VSS

Netgen LVS = MATCH

Post-layout simulation matches the schematic.

----------------------------------------------------------
IMPORTANT
----------------------------------------------------------

The previous AI layout failed because:

- only VDD and VSS ports were extracted
- ports were missing
- pin order was incorrect
- functionality was reversed

Do NOT repeat these mistakes.

Generate a completely fresh implementation.
