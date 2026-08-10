Design a fresh SKY130A Magic layout for a double-height analog 2:1 multiplexer.

Cell name:
AMUX2_3V_FINAL

Technology:
SKY130A

Function:
select=0 -> out=I0
select=1 -> out=I1


Required pins:
I0
I1
select
out
VDD
VSS


Layout rules:

1. Use transmission gate based CMOS mux.
2. Use PMOS devices in nwell.
3. Use NMOS devices in substrate.
4. Add proper well taps.
5. VDD horizontal metal rail at top.
6. VSS horizontal metal rail at bottom.
7. Inputs accessible from left boundary.
8. Output accessible from right boundary.
9. Select pin accessible from bottom.
10. Double height standard-cell compatible size.
11. No floating metals.
12. No power shorts.
13. LVS must match transistor schematic.
