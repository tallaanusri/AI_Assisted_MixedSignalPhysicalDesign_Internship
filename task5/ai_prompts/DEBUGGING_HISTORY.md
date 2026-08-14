# Task 5 AI-Assisted Verification and Debugging History

## 1. PVT Characterization Automation

AI assistance was used to develop an automated ngspice PVT characterization
flow for the SKY130A AMUX2_3V post-layout extracted netlist.

The characterization covers:

- TT, SS and FF process corners
- VDD = 1.62 V, 1.80 V and 1.98 V
- Temperature = -40 C, 27 C and +125 C
- select = 0 and select = 1
- output voltage
- VOH and VOL
- voltage rail error
- voltage accuracy
- propagation delay
- rise time
- fall time
- PASS/FAIL functionality
- CSV result generation
- worst-case identification

## 2. PVT Path Debugging

The first authoritative PVT script searched for the DUT in the wrong
directory and reported:

FileNotFoundError: DUT not found

The verified DUT is located at:

task5/reproducibility/testbenches/AMUX2_3V_extracted.spice

The script root was corrected to:

    ROOT = Path(__file__).resolve().parent

This made the DUT path resolve relative to the reproducibility script.

## 3. PDK Portability Debugging

An early PVT template contained a user-specific absolute PDK path.

This was removed from the reusable testbench.

The authoritative PVT script now obtains the PDK through the PDK_ROOT
environment variable and searches for:

sky130A/libs.tech/ngspice/sky130.lib.spice

This avoids dependence on a particular user's home directory.

## 4. Output Voltage Accuracy

The characterization explicitly calculates:

    VOH accuracy (%) = VOH / VDD * 100

    VOL accuracy (%) = (VDD - VOL) / VDD * 100

Rail errors are also reported:

    VOH error = VDD - VOH

    VOL error = VOL

## 5. Final PVT Result

The characterization contains:

3 process corners x 3 supply voltages x 3 temperatures x 2 select states

= 54 operating cases.

Final result:

54/54 PASS

Authoritative result file:

task5/reproducibility/results/pvt_results.csv

## 6. Physical Verification

The final physical implementation is inherited from the verified Task 4
iteration-3 implementation.

The Task 5 physical sign-off evidence contains:

- Magic DRC
- extraction
- Netgen LVS
- post-layout ngspice simulation

Final results:

- Magic DRC: 0 violations
- Extraction: PASS
- Netgen LVS: Circuits match uniquely
- Post-layout simulation: PASS

The extracted macro contains six transistor devices:

- 3 NFETs
- 3 PFETs

## 7. Earlier LVS Debugging

Earlier AI-generated layout iterations had LVS problems caused by:

1. extracted-layout pin-order mismatch
2. incorrect MUX select behavior
3. layout connectivity problems

These were corrected in the final layout iteration.

The schematic was not modified merely to force an LVS match.

The final extracted interface is:

    I0 I1 select out VDD VSS

The final Netgen result is:

    Circuits match uniquely.

## 8. AI-Assisted Verification Workflow

AI assistance was used for:

- PVT characterization scripts
- ngspice testbench generation
- automated measurement logic
- CSV result generation
- voltage accuracy calculations
- PASS/FAIL checking
- reproducibility-oriented path handling
- debugging and documentation

Generated scripts were executed in the actual SKY130A environment and
corrected when execution exposed path or verification issues.

## 9. Final Verification Status

| Verification Item | Result |
|---|---|
| PVT cases | 54 |
| PVT PASS | 54/54 |
| Process corners | TT / SS / FF |
| Supply voltages | 1.62 / 1.80 / 1.98 V |
| Temperatures | -40 / 27 / +125 C |
| Select states | 0 / 1 |
| Magic DRC | PASS - 0 violations |
| Extraction | PASS |
| Netgen LVS | PASS |
| Post-layout simulation | PASS |

Remaining Task 5 work covers automated physical-signoff execution,
OpenLane integration verification and clean-clone reproducibility.
