# Task 5 - Physical Sign-Off

## Design

**AMUX2_3V** is a double-height 2:1 analog multiplexer implemented in SKY130A.

The final physical implementation is inherited from Task 4 iteration 3, which completed the AI-assisted layout generation, Magic DRC, extraction, LVS, and post-layout simulation flow.

## Sign-Off Evidence

### DRC

Tool: Magic 8.3 revision 413

Result:

- DRC violations: 0
- Final layout: `AMUX2_3V_magic83_DRC0_select_fixed.mag`

The complete Magic DRC log is stored under:

`drc/AMUX2_3V_magic83_DRC.log`

### Extraction

The final Magic-extracted transistor-level SPICE netlist is stored under:

`extraction/AMUX2_3V_extracted.spice`

The extracted implementation contains:

- 3 NFET devices
- 3 PFET devices
- 6 total MOS devices

### LVS

Tool: Netgen

Result:

- Devices: 6 vs 6
- Nets: 7 vs 7
- Pins: equivalent
- Netlists match uniquely
- Final result: Circuits match uniquely

The complete LVS report is stored under:

`lvs/lvs_report.txt`

### Post-Layout Simulation

Technology: SKY130A

Nominal condition:

- Process: TT
- Temperature: 27 C
- Supply: 1.8 V
- Load: 20 fF

Results:

| Select | Selected input | Rise delay | Fall delay |
|--------|----------------|------------|------------|
| 0 | I0 -> OUT | 74.849 ps | 71.334 ps |
| 1 | I1 -> OUT | 77.281 ps | 69.168 ps |

Both functional states pass.

### OpenLane Integration

The final macro views are preserved under `openlane/`:

- `AMUX2_3V.gds`
- `AMUX2_3V.lef`
- `AMUX2_3V.lib`
- `AMUX2_3V.v`

These views are used for digital/top-level integration of the analog macro.

## Sign-Off Status

| Verification | Result |
|--------------|--------|
| Magic DRC | PASS - 0 violations |
| Extraction | PASS |
| Netgen LVS | PASS |
| Post-layout simulation | PASS |
| PVT characterization | PASS - 54/54 |
| Overall physical sign-off | PASS |

## Source

The authoritative implementation is:

`task4/iteration_3/`

Task 5 does not modify the verified physical implementation. It packages the verification evidence and extends the characterization and reproducibility flow.

## OpenLane Reproducibility Note

The AMUX2_3V macro views required for OpenLane integration are preserved
under `openlane/`:

- `AMUX2_3V.gds`
- `AMUX2_3V.lef`
- `AMUX2_3V.lib`
- `AMUX2_3V.v`

The corresponding Task 4 integration configuration is preserved under:

`task4/iteration_3/step8_rtl_to_gds/`

including:

- `config.tcl`
- `macro.cfg`
- `src/design_mux.v`
- `src/AMUX2_3V.v`
- `macro/AMUX2_3V.gds`
- `macro/AMUX2_3V.lef`
- `macro/AMUX2_3V.lib`

The repository therefore preserves the inputs and configuration required
to reproduce the OpenLane integration. No new Task 5 OpenLane run result is
claimed here because the historical OpenLane container run artifacts are
not preserved in the Git repository.
