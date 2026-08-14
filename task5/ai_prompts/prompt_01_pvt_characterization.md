# AI Prompt 01 — PVT Characterization

Generate an automated ngspice-based PVT characterization flow for the
SKY130 transistor-level double-height 2:1 analog MUX AMUX2_3V.

The DUT has the following ports:

I0 I1 select out VDD VSS

The verified post-layout extracted netlist is available from the Task 4
deliverables.

Required process corners:
- TT
- SS
- FF

Required supply voltages:
- 1.62 V
- 1.80 V
- 1.98 V

Required temperatures:
- -40 C
- 27 C
- 125 C

For each PVT combination test both MUX states:

select = 0:
    I0 -> OUT
    I1 held HIGH

select = 1:
    I1 -> OUT
    I0 held LOW

Use a 20 fF output load.

Measure:
- functionality
- output HIGH voltage
- output LOW voltage
- propagation delay
- rise time
- fall time

Generate machine-readable CSV results and a human-readable summary.

The script must clearly report PASS or FAIL for every operating point
and identify worst-case conditions for delay, rise time, fall time and
output voltage accuracy.

Do not modify the verified Task 4 schematic or layout.
