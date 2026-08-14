# Task 5 — PVT Characterization Reproducibility

This directory contains the reproducibility package for the
AMUX2_3V PVT characterization performed in Task 5.

## DUT

AMUX2_3V double-height 2:1 analog MUX.

Ports:

I0 I1 select out VDD VSS

## PVT Matrix

Process corners:

- TT
- SS
- FF

Supply voltages:

- 1.62 V
- 1.80 V
- 1.98 V

Temperatures:

- -40 C
- 27 C
- 125 C

Select states:

- Select = 0: I0 -> OUT
- Select = 1: I1 -> OUT

Total characterization cases:

3 x 3 x 3 x 2 = 54

## Measurements

Each operating point measures:

- MUX functionality
- output HIGH voltage
- output LOW voltage
- propagation delay
- rise time
- fall time

A 20 fF output load is used.

## Reproduction

The main characterization script is:

    run_pvt_characterization.py

The extracted DUT and PVT template are provided under:

    testbenches/

The previously generated machine-readable results are provided under:

    results/

## Recorded Verification

The completed characterization contains:

- 54/54 simulations completed
- 54/54 functionality PASS
- 54/54 status PASS
- 54/54 propagation-delay measurements valid
- 54/54 rise-time measurements valid
- 54/54 fall-time measurements valid

Worst propagation delay:

170.7 ps

Worst rise time:

439.538 ps

Worst fall time:

298.93 ps

Overall Task 5 PVT characterization result:

PASS
