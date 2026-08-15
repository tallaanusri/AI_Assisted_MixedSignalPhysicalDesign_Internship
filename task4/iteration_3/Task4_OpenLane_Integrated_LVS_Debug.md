# Task 4 OpenLane Integrated LVS Debug

## Initial failure

The clean OpenLane run RUN_2026.08.15_02.32.27 reached Step 34 and failed LVS. The summary was: net count difference = 2, unmatched nets = 20, unmatched devices = 45, unmatched pins = 23, total errors = 90.

## Evidence inspected

- reports/signoff/34-design_mux.lvs.rpt
- logs/signoff/34-lvs.lef.log
- logs/signoff/34-design_mux.lef.lvs.log
- tmp/signoff/34-setup_file.lef.lvs
- results/signoff/design_mux.spice
- tmp/signoff/31-design_mux.pnl.v
- logs/floorplan/7-pdn.log and 7-pdn.warnings
- final DEF, GDS, and generated Verilog

Step 34 compares the layout-derived results/signoff/design_mux.spice as circuit 1 with the source/PnR tmp/signoff/31-design_mux.pnl.v as circuit 2.

## Root cause

The verified macro LEF exposes VDD and VSS on met1, but the original black-box RTL did not expose or connect those supplies and the OpenLane configuration did not define a macro PDN hook. OpenLane therefore reported PDN-0189 for u_amux VDD/VSS. The first layout extraction contained u_amux/VDD and u_amux/VSS as isolated physical nets while the powered source netlist connected the macro pins to global VDD/VSS.

Adding only the hook corrected logical ownership but did not create metal because the default macro grid only connects met4 to met5 and no original met4 stripe crossed the 12 x 6 um macro. The remaining physical opens were visible in the second failed fresh run.

## Minimal integration fix

- AMUX2_3V.v now declares VDD and VSS as inout black-box ports.
- design_mux.v now exposes VDD/VSS and connects u_amux.VDD to VDD and u_amux.VSS to VSS.
- config.tcl defines FP_PDN_MACRO_HOOKS as u_amux VDD VSS VDD VSS.
- config.tcl selects design-local macro_pdn.tcl and uses a 10 um met4 pitch.
- macro_pdn.tcl is the standard OpenLane PDN configuration plus a macro-grid met1-to-met4 connection, which connects the macro's existing physical supply rails to the top-level PDN.

This is electrically correct: the final layout-derived macro instance is Xu_amux SDO u_raven_spi.reset reg_ena out VDD VSS AMUX2_3V, matching the powered source instance. No transistor-level circuit, macro geometry, macro GDS, macro LEF, macro SPICE, or macro LIB was redesigned or changed.

## Fresh clean proof

Fresh OpenLane run: RUN_2026.08.15_03.40.00_LVS_FIX2

- Flow completed successfully.
- Detailed routing: 0 DRC violations.
- Post-GDS Magic DRC: 0 violations.
- Step 34 Netgen LVS: Final result: Circuits match uniquely.
- LVS report: Total errors = 0; no net, device, pin, or property mismatches.
- No LVS waiver or macro waiver was used.
- Final GDS, DEF, and Verilog were generated; final DEF contains u_amux AMUX2_3V fixed at (80000, 80000) N.

The macro remains AMUX2_3V, 12 x 6 um (72 um2), with its verified physical implementation unchanged.
