#!/usr/bin/env python3

import csv
import os
import re
import subprocess
from pathlib import Path

# =============================================================
# Task 5 - Automated PVT Characterization
# AMUX2_3V double-height 2:1 analog MUX
# =============================================================

ROOT = Path(__file__).resolve().parent

TB_DIR = ROOT / "testbenches"
RESULT_DIR = ROOT / "results"
LOG_DIR = ROOT / "logs"

DUT = TB_DIR / "AMUX2_3V_extracted.spice"

CSV_FILE = RESULT_DIR / "pvt_results.csv"

NGSPICE = "ngspice"

# -------------------------------------------------------------
# Portable SKY130 PDK discovery
#
# The script must run on another machine after the user sets
# PDK_ROOT. Support both:
#
#   PDK_ROOT=/path/to/sky130
#       -> /path/to/sky130/sky130A/libs.tech/ngspice/...
#
# and:
#
#   PDK_ROOT=/path/to/sky130A
#       -> /path/to/sky130A/libs.tech/ngspice/...
# -------------------------------------------------------------

PDK_ROOT = os.environ.get("PDK_ROOT")

if not PDK_ROOT:
    raise EnvironmentError(
        "PDK_ROOT is not set. Please export PDK_ROOT to the "
        "installed SKY130 PDK root before running this script."
    )

PDK_ROOT = Path(PDK_ROOT).expanduser().resolve()

candidate_libs = [
    PDK_ROOT / "sky130A" / "libs.tech" / "ngspice" / "sky130.lib.spice",
    PDK_ROOT / "libs.tech" / "ngspice" / "sky130.lib.spice",
]

SKY130_LIB = next((p for p in candidate_libs if p.exists()), None)

if SKY130_LIB is None:
    raise FileNotFoundError(
        "Could not find sky130.lib.spice under PDK_ROOT. "
        f"Checked: {candidate_libs}"
    )

CORNERS = ["tt", "ss", "ff"]
VDDS = [1.62, 1.80, 1.98]
TEMPS = [-40, 27, 125]
SELECTS = [0, 1]

DUT_NAME = "AMUX2_3V_magic83_DRC0_select_fixed"

RESULT_DIR.mkdir(parents=True, exist_ok=True)
LOG_DIR.mkdir(parents=True, exist_ok=True)

# -------------------------------------------------------------
# Verify DUT exists
# -------------------------------------------------------------

if not DUT.exists():
    raise FileNotFoundError(f"DUT not found: {DUT}")

# -------------------------------------------------------------
# Extract DUT subcircuit text
# -------------------------------------------------------------

dut_text = DUT.read_text()

if f".subckt {DUT_NAME}" not in dut_text:
    raise RuntimeError(
        f"Expected subcircuit {DUT_NAME} not found in {DUT}"
    )

print("=============================================================")
print("Task 5 - AMUX2_3V PVT Characterization")
print("=============================================================")
print(f"DUT     : {DUT}")
print(f"Library : {SKY130_LIB}")
print(f"Corners : {', '.join(CORNERS)}")
print(f"VDD     : {VDDS}")
print(f"Temp    : {TEMPS}")
print(f"States  : {SELECTS}")
print("=============================================================")

rows = []

# -------------------------------------------------------------
# Generate and run one simulation
# -------------------------------------------------------------

for corner in CORNERS:
    for vdd in VDDS:
        for temp in TEMPS:
            for sel in SELECTS:

                selected_input = "I0" if sel == 0 else "I1"

                tag = (
                    f"{corner}_"
                    f"vdd{vdd:.2f}_"
                    f"temp{temp:+d}_"
                    f"sel{sel}"
                )

                netlist = TB_DIR / f"tb_{tag}.spice"
                logfile = LOG_DIR / f"{tag}.log"
                rawfile = RESULT_DIR / f"{tag}.raw"

                # -------------------------------------------------
                # Select state and stimulus
                # -------------------------------------------------

                if sel == 0:
                    select_source = "VSEL select 0 0"
                    i0_source = (
                        "VI0 I0 0 PULSE(0 {VDDVAL} 1n 20p 20p 5n 10n)"
                    )
                    i1_source = "VI1 I1 0 0"
                    trigger_node = "v(i0)"
                else:
                    select_source = "VSEL select 0 {VDDVAL}"
                    i0_source = "VI0 I0 0 0"
                    i1_source = (
                        "VI1 I1 0 PULSE(0 {VDDVAL} 1n 20p 20p 5n 10n)"
                    )
                    trigger_node = "v(i1)"

                # -------------------------------------------------
                # Numeric measurement thresholds
                #
                # Do not use expressions such as {VDDVAL/2} inside
                # the .control block. ngspice 45.2 can interpret
                # these as control-language vector expressions and
                # report "vddval is not available".
                # Generate literal numeric thresholds instead.
                # -------------------------------------------------

                vdd_half = vdd / 2.0
                vdd_10 = vdd * 0.10
                vdd_90 = vdd * 0.90

                # -------------------------------------------------
                # Testbench
                # -------------------------------------------------

                tb = f"""* ============================================================
* Task 5 - Automated PVT Characterization
* Corner      : {corner}
* VDD         : {vdd:.2f} V
* Temperature : {temp} C
* Select      : {sel}
* Selected    : {selected_input}
* ============================================================

.include "{DUT}"

.param VDDVAL={vdd:.6f}
.param TEMPVAL={temp}

VDD VDD 0 {{VDDVAL}}
VSS VSS 0 0

{select_source}
{i0_source}
{i1_source}

CLOAD out 0 20f

.lib "{SKY130_LIB}" {corner}
.temp {{TEMPVAL}}

XMUX I0 I1 select out VDD VSS {DUT_NAME}

.tran 1p 20n

.control
set noaskquit
run

* Output levels
meas tran voh MAX v(out) FROM=6n TO=10n
meas tran vol MIN v(out) FROM=1n TO=5n

* Propagation delay: 50% input to 50% output
meas tran tpd_rise TRIG {trigger_node} VAL={vdd_half:.6f} RISE=1 TARG v(out) VAL={vdd_half:.6f} RISE=1
meas tran tpd_fall TRIG {trigger_node} VAL={vdd_half:.6f} FALL=1 TARG v(out) VAL={vdd_half:.6f} FALL=1

* 10%-90% rise time
meas tran rise_time TRIG v(out) VAL={vdd_10:.6f} RISE=1 TARG v(out) VAL={vdd_90:.6f} RISE=1

* 90%-10% fall time
meas tran fall_time TRIG v(out) VAL={vdd_90:.6f} FALL=1 TARG v(out) VAL={vdd_10:.6f} FALL=1

* Save waveform
write "{rawfile}" all

quit
.endc

.end
"""

                netlist.write_text(tb)

                # -------------------------------------------------
                # Run ngspice
                # -------------------------------------------------

                print(
                    f"[RUN] corner={corner:2s} "
                    f"VDD={vdd:.2f} "
                    f"T={temp:4d}C "
                    f"SEL={sel}"
                )

                with open(logfile, "w") as log:
                    proc = subprocess.run(
                        [NGSPICE, "-b", str(netlist)],
                        stdout=log,
                        stderr=subprocess.STDOUT,
                        text=True,
                    )

                log_text = logfile.read_text()

                # -------------------------------------------------
                # Extract measurements
                # -------------------------------------------------

                def get_measure(name):
                    pattern = rf"{re.escape(name)}\s*=\s*([+-]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?)"
                    match = re.search(pattern, log_text, re.IGNORECASE)
                    if not match:
                        return None
                    try:
                        return float(match.group(1))
                    except ValueError:
                        return None

                voh = get_measure("voh")
                vol = get_measure("vol")

                tpd_rise = get_measure("tpd_rise")
                tpd_fall = get_measure("tpd_fall")
                rise_time = get_measure("rise_time")
                fall_time = get_measure("fall_time")

                # Convert ngspice seconds to ps
                def sec_to_ps(x):
                    return None if x is None else x * 1e12

                tpd_rise_ps = sec_to_ps(tpd_rise)
                tpd_fall_ps = sec_to_ps(tpd_fall)

                if tpd_rise_ps is not None and tpd_fall_ps is not None:
                    prop_delay_ps = max(tpd_rise_ps, tpd_fall_ps)
                elif tpd_rise_ps is not None:
                    prop_delay_ps = tpd_rise_ps
                elif tpd_fall_ps is not None:
                    prop_delay_ps = tpd_fall_ps
                else:
                    prop_delay_ps = None

                rise_time_ps = sec_to_ps(rise_time)
                fall_time_ps = sec_to_ps(fall_time)

                # -------------------------------------------------
                # Functional check
                #
                # For a selected input switching 0 -> VDD:
                # output should switch correspondingly.
                # -------------------------------------------------

                functionality = "PASS"

                if voh is None or vol is None:
                    functionality = "FAIL"

                else:
                    # Allow a reasonable rail accuracy margin.
                    high_ok = voh >= 0.90 * vdd
                    low_ok = vol <= 0.10 * vdd

                    if not (high_ok and low_ok):
                        functionality = "FAIL"

                status = "PASS"

                if proc.returncode != 0:
                    status = "FAIL"

                if functionality != "PASS":
                    status = "FAIL"

                # -------------------------------------------------
                # Explicit output-voltage accuracy metrics
                #
                # Accuracy is reported relative to the applied VDD:
                #
                #   VOH accuracy (%) = VOH / VDD * 100
                #   VOL accuracy (%) = (VDD - VOL) / VDD * 100
                #
                # Rail errors are also reported explicitly.
                # -------------------------------------------------

                voh_error_V = (
                    vdd - voh if voh is not None else None
                )

                vol_error_V = (
                    vol if vol is not None else None
                )

                voh_accuracy_percent = (
                    (voh / vdd) * 100.0
                    if voh is not None else None
                )

                vol_accuracy_percent = (
                    ((vdd - vol) / vdd) * 100.0
                    if vol is not None else None
                )

                rows.append({
                    "corner": corner.upper(),
                    "vdd_V": f"{vdd:.2f}",
                    "temp_C": temp,
                    "select_state": sel,
                    "selected_input": selected_input,
                    "output_high_V": (
                        f"{voh:.6g}" if voh is not None else "NA"
                    ),
                    "output_low_V": (
                        f"{vol:.6g}" if vol is not None else "NA"
                    ),
                    "voh_error_V": (
                        f"{voh_error_V:.6g}"
                        if voh_error_V is not None else "NA"
                    ),
                    "vol_error_V": (
                        f"{vol_error_V:.6g}"
                        if vol_error_V is not None else "NA"
                    ),
                    "voh_accuracy_percent": (
                        f"{voh_accuracy_percent:.6f}"
                        if voh_accuracy_percent is not None else "NA"
                    ),
                    "vol_accuracy_percent": (
                        f"{vol_accuracy_percent:.6f}"
                        if vol_accuracy_percent is not None else "NA"
                    ),
                    "prop_delay_ps": (
                        f"{prop_delay_ps:.6g}"
                        if prop_delay_ps is not None else "NA"
                    ),
                    "rise_time_ps": (
                        f"{rise_time_ps:.6g}"
                        if rise_time_ps is not None else "NA"
                    ),
                    "fall_time_ps": (
                        f"{fall_time_ps:.6g}"
                        if fall_time_ps is not None else "NA"
                    ),
                    "functionality": functionality,
                    "status": status,
                })

# -------------------------------------------------------------
# Write CSV
# -------------------------------------------------------------

fieldnames = [
    "corner",
    "vdd_V",
    "temp_C",
    "select_state",
    "selected_input",
    "output_high_V",
    "output_low_V",
    "voh_error_V",
    "vol_error_V",
    "voh_accuracy_percent",
    "vol_accuracy_percent",
    "prop_delay_ps",
    "rise_time_ps",
    "fall_time_ps",
    "functionality",
    "status",
]

with open(CSV_FILE, "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(rows)

# -------------------------------------------------------------
# Summary
# -------------------------------------------------------------

passed = sum(1 for r in rows if r["status"] == "PASS")
failed = len(rows) - passed

print()
print("=============================================================")
print("PVT CHARACTERIZATION COMPLETE")
print("=============================================================")
print(f"Total simulations : {len(rows)}")
print(f"PASS              : {passed}")
print(f"FAIL              : {failed}")
print(f"Results           : {CSV_FILE}")
print(f"Logs              : {LOG_DIR}")
print("=============================================================")

if failed:
    print("WARNING: One or more PVT simulations failed.")
    print("Inspect the corresponding logs before declaring sign-off.")
