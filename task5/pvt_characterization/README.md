# Task 5 — PVT Characterization

This directory contains the automated process-voltage-temperature
characterization of the verified AMUX2_3V double-height 2:1 analog MUX
developed in Task 4.

## Process Corners

- TT — Typical-Typical
- SS — Slow-Slow
- FF — Fast-Fast

## Supply Voltage

- 1.62 V
- 1.80 V
- 1.98 V

## Temperature

- -40 C
- 27 C
- 125 C

## Functional States

### Select = 0

I0 is connected to OUT.

### Select = 1

I1 is connected to OUT.

## Measurements

The characterization flow measures:

- MUX functionality
- output HIGH voltage
- output LOW voltage
- propagation delay
- rise time
- fall time

Results are stored in `results/pvt_results.csv`.

The scripts and testbenches are generated and documented as part of
the AI-assisted verification workflow.
