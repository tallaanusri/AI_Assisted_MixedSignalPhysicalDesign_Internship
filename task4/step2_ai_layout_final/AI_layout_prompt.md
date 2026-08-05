# AI Assisted Layout Generation Prompt

Generate a fresh SKY130A Magic VLSI layout for:

Cell:
AMUX2_3V_FINAL

Architecture:
CMOS transmission-gate 2:1 analog multiplexer


Pins:

I0
I1
SEL
OUT
VDD
VSS


Function:

SEL=0:
OUT follows I0

SEL=1:
OUT follows I1


Transistors:

1. Select inverter:
MSEL_N NMOS
MSEL_P PMOS

2. Transmission gate 0:
MTG0_N NMOS
MTG0_P PMOS

3. Transmission gate 1:
MTG1_N NMOS
MTG1_P PMOS


Layout requirements:

- SKY130A technology
- Double height macro
- VDD metal rail on top
- VSS metal rail on bottom
- NMOS in p-substrate
- PMOS in nwell
- Proper taps
- No floating diffusion
- No metal shorts
- Pins accessible for PNR
- LVS must match transistor schematic

Pin placement:

Left:
I0
I1

Bottom:
SEL

Right:
OUT

Top:
VDD

Bottom:
VSS


Generate Magic .mag layout.
