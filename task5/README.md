
# Task 5 – Final AI-Assisted Sign-Off, PVT Characterization and Reproducibility

## 1. Overview

Task 5 completes the final verification and sign-off of the **AMUX2_3V**, a double-height 2:1 analog multiplexer developed and physically integrated during Task 4.

The objective of Task 5 is to demonstrate that the AMUX2_3V macro is:

- Functionally correct at nominal conditions.
- Robust across process, voltage and temperature (PVT) variations.
- Correct after physical layout extraction.
- DRC clean.
- LVS matched against the transistor-level reference.
- Suitable for reuse as an analog macro in a mixed-signal physical-design flow.
- Successfully integrated into the digital top-level OpenLane flow.
- Reproducible using the scripts, testbenches, reports and configuration preserved in this repository.

Task 5 extends the verified Task 4 implementation rather than creating a different physical implementation.

The final physical implementation used for sign-off is the **Task 4 iteration 3 AMUX2_3V implementation**.

---

# 2. Design Under Verification

## AMUX2_3V

The design is a double-height **2:1 analog multiplexer** implemented using the SKY130A technology.

### Functional behavior

The multiplexer contains:

- Input `I0`
- Input `I1`
- Select `select`
- Output `out`
- Supply `VDD`
- Ground `VSS`

The expected functionality is:

| `select` | Selected path |
|----------|---------------|
| 0 | `I0 -> out` |
| 1 | `I1 -> out` |

The physical implementation contains:

- 3 NMOS devices
- 3 PMOS devices
- 6 total MOS devices

The final extracted implementation contains 7 electrical nets.

---

# 3. Relationship Between Task 4 and Task 5

Task 4 established the physical implementation of the AMUX2_3V macro.

The final Task 4 iteration was:

```text
task4/iteration_3/
````

Task 4 iteration 3 completed:

* AI-assisted layout generation
* Magic DRC
* Magic extraction
* Netgen LVS
* Post-layout SPICE simulation
* Macro view generation
* OpenLane integration
* Integrated digital/top-level verification
* Final sign-off evidence

Task 5 therefore does **not** create a second unrelated physical layout.

Instead, Task 5 performs final characterization and reproducibility verification of the already verified Task 4 implementation.

This avoids duplicating or modifying the physical implementation merely for Task 5.

The authoritative physical implementation remains:

```text
task4/iteration_3/
```

---

# 4. Task 5 Verification Flow

The Task 5 verification flow is organized as follows:

```text
                 Task 4 Final AMUX2_3V
                          |
                          v
              +-----------------------+
              | Physical Sign-Off     |
              +-----------------------+
                  |     |      |
                  |     |      |
                 DRC   LVS   Extraction
                  |     |      |
                  +-----+------+
                          |
                          v
                 Post-Layout SPICE
                          |
                          v
                  PVT Characterization
                          |
                          v
                 Worst-Case Analysis
                          |
                          v
                 OpenLane Integration
                          |
                          v
                 Reproducibility Test
                          |
                          v
                  Final Sign-Off
```

---

# 5. Repository Structure

The main Task 5 directories are:

```text
task5/
├── ai_prompts/
│   ├── prompt_01_pvt_characterization.md
│   └── DEBUGGING_HISTORY.md
│
├── pvt_characterization/
│   ├── README.md
│   ├── scripts/
│   │   └── run_pvt_characterization.py
│   ├── testbenches/
│   ├── logs/
│   └── results/
│
├── physical_signoff/
│   ├── README.md
│   ├── drc/
│   ├── extraction/
│   ├── lvs/
│   ├── post_layout_sim/
│   ├── openlane/
│   └── scripts/
│
├── reproducibility/
│   ├── README.md
│   ├── run_pvt_characterization.py
│   ├── testbenches/
│   ├── logs/
│   └── results/
│
└── final_signoff/
    ├── reports/
    └── tables/
```

---

# 6. AI-Assisted Verification

AI assistance was used to generate and debug the automated PVT characterization flow.

The preserved AI-related material is located in:

```text
task5/ai_prompts/
```

The main prompt is:

```text
task5/ai_prompts/prompt_01_pvt_characterization.md
```

Debugging and correction history is documented in:

```text
task5/ai_prompts/DEBUGGING_HISTORY.md
```

The generated Python characterization flow is:

```text
task5/pvt_characterization/scripts/run_pvt_characterization.py
```

A reproducibility copy is also provided under:

```text
task5/reproducibility/run_pvt_characterization.py
```

The AI-assisted workflow was used to automate:

1. Testbench generation.
2. Process-corner selection.
3. Supply-voltage variation.
4. Temperature variation.
5. Select-state testing.
6. ngspice execution.
7. Output measurement.
8. Delay measurement.
9. Rise/fall-time measurement.
10. PASS/FAIL classification.
11. CSV result generation.
12. Worst-case extraction.

---

# 7. PVT Characterization

## 7.1 Process Corners

The following SKY130 process corners were characterized:

```text
TT
SS
FF
```

where:

* `TT` = Typical-Typical
* `SS` = Slow-Slow
* `FF` = Fast-Fast

---

## 7.2 Supply Voltage

Three supply voltages were evaluated around the nominal 1.8 V operating point:

```text
1.62 V
1.80 V
1.98 V
```

This corresponds to approximately:

```text
-10%
Nominal
+10%
```

relative to the 1.8 V nominal supply.

---

## 7.3 Temperature

Three temperatures were evaluated:

```text
-40 °C
+27 °C
+125 °C
```

These represent:

* Low temperature
* Room/nominal temperature
* High temperature

---

## 7.4 Select States

Both functional states were tested:

```text
select = 0
select = 1
```

Therefore the characterization covers:

```text
3 process corners
× 3 supply voltages
× 3 temperatures
× 2 select states
```

giving:

```text
54 operating points
```

Each operating point verifies the corresponding selected input path.

---

# 8. PVT Measurements

The automated characterization measures and records:

* Selected input
* Output high voltage
* Output low voltage
* VOH error
* VOL error
* VOH accuracy
* VOL accuracy
* Propagation delay
* Rise time
* Fall time
* Functional correctness
* Overall PASS/FAIL status

The main result file is:

```text
task5/pvt_characterization/results/pvt_results.csv
```

The reproducibility result is also preserved at:

```text
task5/reproducibility/results/pvt_results.csv
```

The CSV contains 54 characterization results plus the header.

---

# 9. PVT Verification Result

The complete PVT characterization contains:

```text
54 / 54 PASS
```

Both select states remain functional throughout the tested:

* TT corner
* SS corner
* FF corner
* 1.62 V supply
* 1.80 V supply
* 1.98 V supply
* -40 °C
* +27 °C
* +125 °C

Therefore:

```text
PVT FUNCTIONALITY = PASS
```

The detailed verification reports are stored under:

```text
task5/pvt_characterization/results/
```

and:

```text
task5/final_signoff/reports/
```

---

# 10. PVT Worst-Case Analysis

Worst-case results are automatically summarized from the complete PVT data.

The final worst-case summary is stored at:

```text
task5/final_signoff/tables/PVT_WORST_CASE_SUMMARY.txt
```

Additional reports are:

```text
task5/final_signoff/reports/PVT_SUMMARY.txt
task5/final_signoff/reports/PVT_VERIFICATION.txt
task5/final_signoff/reports/PVT_WORST_CASES.txt
```

The analysis considers the tested operating space and identifies the conditions producing the most demanding values for the important measured parameters.

The characterization therefore goes beyond a single nominal simulation and demonstrates operation over the defined PVT space.

---

# 11. Physical Sign-Off

The physical sign-off evidence is stored under:

```text
task5/physical_signoff/
```

The physical verification stages are:

1. DRC
2. Extraction
3. LVS
4. Post-layout simulation
5. OpenLane integration

---

# 12. Magic DRC

The final physical layout was verified using Magic.

Tool:

```text
Magic 8.3 revision 413
```

Result:

```text
DRC violations = 0
```

Therefore:

```text
MAGIC DRC = PASS
```

The DRC evidence is stored under:

```text
task5/physical_signoff/drc/
```

including:

```text
AMUX2_3V_DRC.log
AMUX2_3V_DRC0.mag
```

The DRC-clean physical implementation originated from Task 4 iteration 3.

---

# 13. Layout Extraction

The final Magic-extracted SPICE netlist is preserved at:

```text
task5/physical_signoff/extraction/AMUX2_3V_extracted.spice
```

The extracted implementation contains:

```text
3 NFET devices
3 PFET devices
----------------
6 MOS devices
```

The extracted design contains:

```text
7 electrical nets
```

The extraction result is used for:

* LVS
* Post-layout simulation
* PVT characterization

---

# 14. LVS Sign-Off

## Important Task 4 / Task 5 Integration Note

The AMUX2_3V physical implementation was already fully verified during **Task 4 iteration 3**.

Task 4's final integrated sign-off evidence is stored under:

```text
task4/iteration_3/step8_rtl_to_gds/signoff_evidence/
```

The Task 4 LVS report states:

```text
LVS reports no net, device, pin, or property mismatches.

Total errors = 0
```

The detailed Task 4 LVS log reports:

```text
Circuits match uniquely.
```

The Task 4 reproducibility evidence also records:

```text
LVS: PASS
LVS result: Circuits match uniquely
```

Therefore, Task 5 treats the Task 4 integrated LVS result as the authoritative physical sign-off result.

---

## 14.1 Task 5 LVS Evidence

For completeness, the corresponding LVS inputs and report are preserved under:

```text
task5/physical_signoff/lvs/
```

The Task 5 LVS comparison reports:

```text
Circuit 1: AMUX2_3V
Circuit 2: AMUX2_3V

NFET devices: 3 vs 3
PFET devices: 3 vs 3

Total devices: 6 vs 6
Total nets: 7 vs 7
```

The pin lists are equivalent:

```text
I1
I0
select
VDD
VSS
out
```

The final Netgen result is:

```text
Netlists match uniquely.

Final result: Circuits match uniquely.
```

Therefore:

```text
NETGEN LVS = PASS
```

The complete report is:

```text
task5/physical_signoff/lvs/lvs_report.txt
```

---

# 15. Why Task 5 Does Not Claim a New Physical LVS Implementation

Task 5 is a sign-off and characterization task.

It is intentionally based on the final physical implementation established in Task 4.

The correct verification relationship is:

```text
Task 4
  |
  +-- AI-assisted layout
  +-- Magic DRC
  +-- Extraction
  +-- Netgen LVS
  +-- Post-layout simulation
  +-- OpenLane integration
  |
  v
Final verified AMUX2_3V
  |
  v
Task 5
  |
  +-- PVT characterization
  +-- Worst-case analysis
  +-- Automated sign-off
  +-- Reproducibility
  +-- Final verification package
```

This prevents Task 5 from incorrectly presenting the inherited Task 4 physical implementation as a newly created layout.

---

# 16. Post-Layout Simulation

The extracted physical implementation was simulated using ngspice.

Nominal condition:

```text
Technology : SKY130A
Process    : TT
Temperature: 27 °C
VDD        : 1.8 V
Load       : 20 fF
```

The nominal post-layout results are:

| Select | Selected path | Rise delay | Fall delay |
| ------ | ------------- | ---------- | ---------- |
| 0      | I0 -> OUT     | 74.849 ps  | 71.334 ps  |
| 1      | I1 -> OUT     | 77.281 ps  | 69.168 ps  |

Both functional states pass.

Therefore:

```text
POST-LAYOUT SIMULATION = PASS
```

The evidence is stored under:

```text
task5/physical_signoff/post_layout_sim/
```

---

# 17. OpenLane Integration

The AMUX2_3V macro was integrated into the digital top-level design during Task 4.

The final macro views are preserved under:

```text
task5/physical_signoff/openlane/
```

including:

```text
AMUX2_3V.gds
AMUX2_3V.lef
AMUX2_3V.lib
AMUX2_3V.v
```

The corresponding integrated design configuration is preserved under:

```text
task4/iteration_3/step8_rtl_to_gds/
```

Important integration files include:

```text
config.tcl
macro.cfg
src/design_mux.v
src/AMUX2_3V.v
macro/AMUX2_3V.gds
macro/AMUX2_3V.lef
macro/AMUX2_3V.lib
```

---

# 18. Integrated OpenLane Sign-Off

Task 4 iteration 3 completed the final integrated OpenLane flow.

The preserved sign-off evidence includes:

```text
task4/iteration_3/step8_rtl_to_gds/signoff_evidence/
```

with:

```text
detailed_routing.log
lvs.log
lvs_report.txt
magic_drc.log
metrics.csv
reproducibility_run.txt
```

The integrated flow evidence records:

```text
OpenLane flow: PASS
LVS: PASS
LVS result: Circuits match uniquely
```

The Task 4 LVS report records:

```text
LVS reports no net, device, pin, or property mismatches.
Total errors = 0
```

Therefore the AMUX2_3V macro has already been demonstrated as successfully integrated into the mixed-signal/digital physical-design flow.

---

# 19. OpenLane Timing / STA

The Task 4 integrated OpenLane design includes the digital timing views and timing constraints required for the digital portion of the design.

The integrated design contains:

```text
design_mux.sdc
design_mux.sdf
design_mux.lib
design_mux.lef
design_mux.def
design_mux.spef
```

The analog AMUX2_3V is treated as an integrated macro rather than requiring transistor-level STA.

Full transistor-level STA of the analog multiplexer itself is not required for this task.

Where applicable, digital timing analysis is therefore interpreted in the context of the integrated top-level design and its available Liberty timing models.

---

# 20. Physical Sign-Off Automation

The automated physical sign-off scripts are stored under:

```text
task5/physical_signoff/scripts/
```

Main scripts:

```text
run_physical_signoff.sh
run_openlane_integration.sh
```

The purpose of the automation is to minimize manual intervention and provide clear verification results.

The intended flow is:

```text
Magic DRC
   |
   v
Extraction
   |
   v
Netgen LVS
   |
   v
Post-layout ngspice
   |
   v
OpenLane integration
   |
   v
PASS/FAIL summary
```

The generated automation evidence is stored under:

```text
task5/final_signoff/reports/physical_signoff_automation.log
```

---

# 21. Reproducibility

A major objective of Task 5 is to demonstrate that the verification process can be reproduced using the repository contents.

The reproducibility material is stored under:

```text
task5/reproducibility/
```

It contains:

* PVT scripts
* Testbenches
* Simulation logs
* PVT result CSV
* Verification reports
* Reproducibility README

The reproducibility flow uses the same:

```text
SKY130A
ngspice
PVT testbenches
automated characterization script
```

used for the primary characterization.

---

# 22. Clean-Clone Reproducibility Procedure

After cloning the repository into a fresh directory, the Task 5 PVT characterization can be reproduced using the provided files.

Example:

```bash
git clone https://github.com/tallaanusri/AI_Assisted_MixedSignalPhysicalDesign_Internship.git

cd AI_Assisted_MixedSignalPhysicalDesign_Internship

cd task5/reproducibility
```

The PVT characterization script is:

```text
run_pvt_characterization.py
```

The generated testbenches are located under:

```text
testbenches/
```

Simulation logs are stored under:

```text
logs/
```

and results are stored under:

```text
results/
```

The repository therefore contains the required scripts, testbenches and verification evidence for reproducing the characterization flow, assuming the required open-source tools and SKY130 PDK are already installed.

---

# 23. Reproducibility Result

The reproduced characterization covers the same:

```text
3 process corners
3 supply voltages
3 temperatures
2 select states
```

for a total of:

```text
54 operating points
```

The reproduced result is:

```text
54 / 54 PASS
```

The reproducibility reports are stored under:

```text
task5/reproducibility/results/
```

---

# 24. Verification Evidence Summary

The repository preserves the following evidence.

## AI Assistance

```text
task5/ai_prompts/
```

Contains:

* AI prompt
* Debugging history
* Verification workflow documentation

## PVT Characterization

```text
task5/pvt_characterization/
```

Contains:

* Python automation
* SPICE testbenches
* Simulation logs
* PVT CSV results
* Verification reports

## Physical Sign-Off

```text
task5/physical_signoff/
```

Contains:

* DRC evidence
* Extracted SPICE
* LVS evidence
* Post-layout simulation
* Macro views
* OpenLane integration scripts

## Reproducibility

```text
task5/reproducibility/
```

Contains:

* Reproducibility script
* Testbenches
* Logs
* Results
* Reproducibility documentation

## Final Sign-Off

```text
task5/final_signoff/
```

Contains:

* PVT summary
* Verification summary
* Worst-case analysis
* Automation log
* Final PVT tables

---

# 25. Final Sign-Off Table

| Verification Item          | Result              | Evidence                                                   |
| -------------------------- | ------------------- | ---------------------------------------------------------- |
| AI-assisted PVT automation | PASS                | `task5/ai_prompts/`, `task5/pvt_characterization/scripts/` |
| TT characterization        | PASS                | `task5/pvt_characterization/results/`                      |
| SS characterization        | PASS                | `task5/pvt_characterization/results/`                      |
| FF characterization        | PASS                | `task5/pvt_characterization/results/`                      |
| 1.62 V characterization    | PASS                | PVT results                                                |
| 1.80 V characterization    | PASS                | PVT results                                                |
| 1.98 V characterization    | PASS                | PVT results                                                |
| -40 °C characterization    | PASS                | PVT results                                                |
| +27 °C characterization    | PASS                | PVT results                                                |
| +125 °C characterization   | PASS                | PVT results                                                |
| Select = 0 functionality   | PASS                | PVT results                                                |
| Select = 1 functionality   | PASS                | PVT results                                                |
| PVT coverage               | PASS - 54/54        | `pvt_results.csv`                                          |
| Magic DRC                  | PASS - 0 violations | `task5/physical_signoff/drc/`                              |
| Extraction                 | PASS                | `task5/physical_signoff/extraction/`                       |
| Netgen LVS                 | PASS                | `task5/physical_signoff/lvs/`                              |
| Task 4 integrated LVS      | PASS - 0 errors     | `task4/iteration_3/step8_rtl_to_gds/signoff_evidence/`     |
| Post-layout simulation     | PASS                | `task5/physical_signoff/post_layout_sim/`                  |
| OpenLane integration       | PASS                | Task 4 iteration 3 sign-off evidence                       |
| Reproducibility            | PASS                | `task5/reproducibility/`                                   |
| Overall Task 5 sign-off    | **PASS**            | `task5/final_signoff/`                                     |

---

# 26. Final Conclusion

The AMUX2_3V double-height 2:1 analog multiplexer has completed the Task 5 verification and sign-off flow.

The final evidence demonstrates:

1. Correct 2:1 analog MUX functionality.
2. Successful PVT characterization across TT, SS and FF process corners.
3. Operation at 1.62 V, 1.80 V and 1.98 V supply voltages.
4. Operation at -40 °C, +27 °C and +125 °C.
5. Correct operation for both select states.
6. 54/54 PVT operating points passing.
7. Output voltage accuracy measurements.
8. Propagation delay measurements.
9. Rise-time and fall-time measurements.
10. Zero Magic DRC violations.
11. Successful extraction.
12. Successful Netgen LVS with 6 vs 6 devices and 7 vs 7 nets.
13. Task 4 integrated LVS with zero reported errors.
14. Successful post-layout simulation.
15. Successful OpenLane integration of the analog macro.
16. Automated physical-signoff scripts and evidence.
17. Reproducible PVT characterization using the repository contents.

The physical implementation remains the verified **Task 4 iteration 3 implementation**, while Task 5 provides the final characterization, automation, reproducibility and sign-off evidence.

Therefore:

```text
==================================================
AMUX2_3V FINAL TASK 5 SIGN-OFF: PASS
==================================================
```

The macro is considered verified for reuse as a double-height 2:1 analog multiplexer in the demonstrated SKY130A mixed-signal physical-design flow.

---

# 27. Key Repository Locations

### Task 4 authoritative physical implementation

```text
task4/iteration_3/
```

### Task 4 integrated sign-off evidence

```text
task4/iteration_3/step8_rtl_to_gds/signoff_evidence/
```

### Task 5 AI prompts

```text
task5/ai_prompts/
```

### Task 5 PVT characterization

```text
task5/pvt_characterization/
```

### Task 5 physical sign-off

```text
task5/physical_signoff/
```

### Task 5 reproducibility

```text
task5/reproducibility/
```

### Task 5 final sign-off

```text
task5/final_signoff/
```

---

# 28. Final Status

| Category                           | Final Status            |
| ---------------------------------- | ----------------------- |
| Functional verification            | **PASS**                |
| PVT characterization               | **PASS - 54/54**        |
| Output voltage accuracy            | **PASS**                |
| Propagation delay characterization | **PASS**                |
| Rise/fall characterization         | **PASS**                |
| Magic DRC                          | **PASS - 0 violations** |
| Extraction                         | **PASS**                |
| Netgen LVS                         | **PASS**                |
| Task 4 integrated LVS              | **PASS - 0 errors**     |
| Post-layout simulation             | **PASS**                |
| OpenLane integration               | **PASS**                |
| Reproducibility                    | **PASS**                |
| Overall Task 5                     | **PASS**                |

```
