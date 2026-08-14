#!/usr/bin/env bash
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SIGNOFF="$ROOT/task5/physical_signoff"

PASS=0
FAIL=0

check_file() {
    local label="$1"
    local file="$2"

    if [ -f "$file" ]; then
        echo "PASS: $label"
        PASS=$((PASS + 1))
    else
        echo "FAIL: $label"
        echo "      Missing: $file"
        FAIL=$((FAIL + 1))
    fi
}

check_pattern() {
    local label="$1"
    local pattern="$2"
    local file="$3"

    if grep -Eq "$pattern" "$file"; then
        echo "PASS: $label"
        PASS=$((PASS + 1))
    else
        echo "FAIL: $label"
        echo "      Pattern not found: $pattern"
        echo "      File: $file"
        FAIL=$((FAIL + 1))
    fi
}

echo "============================================================"
echo "Task 5 - AMUX2_3V Physical Sign-Off"
echo "============================================================"
echo "Repository : $ROOT"
echo

echo "===== DRC ====="
check_file \
    "Magic DRC log exists" \
    "$SIGNOFF/drc/AMUX2_3V_DRC.log"

check_pattern \
    "Magic DRC reports zero violations" \
    "Total DRC errors found: 0" \
    "$SIGNOFF/drc/AMUX2_3V_DRC.log"

echo
echo "===== EXTRACTION ====="

check_file \
    "Extracted SPICE exists" \
    "$SIGNOFF/extraction/AMUX2_3V_extracted.spice"

check_pattern \
    "Extracted subcircuit has six expected pins" \
    '^\.subckt AMUX2_3V_magic83_DRC0_select_fixed I0 I1 select out VDD VSS' \
    "$SIGNOFF/extraction/AMUX2_3V_extracted.spice"

echo
echo "===== LVS ====="

check_file \
    "Netgen LVS report exists" \
    "$SIGNOFF/lvs/lvs_report.txt"

check_pattern \
    "LVS netlists match uniquely" \
    'Netlists match uniquely\.' \
    "$SIGNOFF/lvs/lvs_report.txt"

check_pattern \
    "LVS final result passes" \
    'Final result: Circuits match uniquely\.' \
    "$SIGNOFF/lvs/lvs_report.txt"

echo
echo "===== POST-LAYOUT SIMULATION ====="

check_file \
    "Post-layout measurement report exists" \
    "$SIGNOFF/post_layout_sim/postlayout_measurements.txt"

check_pattern \
    "Post-layout LVS status is PASS" \
    'LVS : PASS' \
    "$SIGNOFF/post_layout_sim/postlayout_measurements.txt"

echo
echo "===== OPENLANE MACRO VIEWS ====="

check_file "GDS view exists" "$SIGNOFF/openlane/AMUX2_3V.gds"
check_file "LEF view exists" "$SIGNOFF/openlane/AMUX2_3V.lef"
check_file "Liberty view exists" "$SIGNOFF/openlane/AMUX2_3V.lib"
check_file "Verilog view exists" "$SIGNOFF/openlane/AMUX2_3V.v"

echo
echo "===== SUMMARY ====="

echo "PASS checks : $PASS"
echo "FAIL checks : $FAIL"

if [ "$FAIL" -eq 0 ]; then
    echo
    echo "FINAL PHYSICAL SIGN-OFF: PASS"
    exit 0
else
    echo
    echo "FINAL PHYSICAL SIGN-OFF: FAIL"
    exit 1
fi
