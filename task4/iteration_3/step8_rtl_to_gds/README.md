# Step 8 — RTL-to-GDS OpenLane Integration and Signoff

## Objective

Integrate the AI-assisted SKY130A double-height `AMUX2_3V` analog 2:1 MUX macro into the `design_mux` RTL design and complete the OpenLane RTL-to-GDS flow.

## Integration

The `AMUX2_3V` macro is integrated into `design_mux` together with the existing SPI/Raven-SPI logic.

The macro exposes:

- `I0`
- `I1`
- `select`
- `out`
- `VDD`
- `VSS`

The integration uses an explicit macro PDN hookup because the physical AMUX2_3V VDD/VSS rails are implemented on met1 while the default integration PDN operates on higher metal layers.

The integration fix therefore uses:

- explicit VDD/VSS macro connectivity
- `FP_PDN_MACRO_HOOKS`
- `macro_pdn.tcl`
- met4 bridging with a 10 µm PDN pitch

No transistor-level macro geometry or schematic was changed.

## Reproducibility Run

OpenLane:

- Version: v1.0.2
- Commit: `ff5509f65b17bfa4068d5336495ab1718987ff69`

PDK:

- `sky130A`
- CIEL version: `0fe599b2afb6708d281543108caf8310912f54af`

Run:

`RUN_2026.08.15_03.07.15`

## Signoff Results

| Check | Result |
|---|---|
| Verilator lint | 0 errors |
| Detailed routing DRC | 0 violations |
| Magic post-GDS DRC | 0 violations |
| LVS | PASS |
| LVS errors | 0 |
| LVS result | Circuits match uniquely |
| Setup violations | 0 |
| Hold violations | 0 |
| KLayout/Magic GDS XOR | No differences |

## Final Macro Instance

The final DEF contains:

`u_amux AMUX2_3V`

The extracted integrated LVS netlist matches the source circuit with no net, device, pin, or property mismatches.

## Final Outputs

The `final_outputs/` directory contains the final OpenLane views:

- GDS
- DEF
- LEF
- LIB
- MAG
- SPEF
- SDC
- SDF

Detailed signoff logs and reports are preserved under `signoff_evidence/`.

## Important Note

The integrated LVS correction was performed only at the OpenLane integration level.

The following were not changed:

- AMUX2_3V transistor-level schematic
- AMUX2_3V transistor-level SPICE
- AMUX2_3V layout geometry
- AMUX2_3V GDS
- AMUX2_3V LEF
- AMUX2_3V LIB
- AMUX2_3V extracted SPICE

No LVS waiver was used.
