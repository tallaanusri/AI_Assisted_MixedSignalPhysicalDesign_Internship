#!/usr/bin/env bash
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
STEP8="$ROOT/task4/iteration_3/step8_rtl_to_gds"
REPORT="$ROOT/task5/physical_signoff/openlane/openlane_integration_report.txt"

PASS=0
FAIL=0

mkdir -p "$(dirname "$REPORT")"
: > "$REPORT"

check_file() {
    local label="$1"
    local file="$2"

    if [ -f "$file" ]; then
        echo "PASS: $label"
        echo "PASS: $label" >> "$REPORT"
        PASS=$((PASS + 1))
    else
        echo "FAIL: $label"
        echo "FAIL: $label" >> "$REPORT"
        FAIL=$((FAIL + 1))
    fi
}

echo "============================================================"
echo "Task 5 - AMUX2_3V OpenLane Integration Verification"
echo "============================================================"
echo "Repository : $ROOT"
echo "Step 8     : $STEP8"
echo

echo "Task 5 OpenLane Integration Verification" >> "$REPORT"
echo "Repository: $ROOT" >> "$REPORT"
echo >> "$REPORT"

echo "===== INPUT VIEWS ====="

check_file "AMUX2_3V GDS exists" \
    "$STEP8/macro/AMUX2_3V.gds"

check_file "AMUX2_3V LEF exists" \
    "$STEP8/macro/AMUX2_3V.lef"

check_file "AMUX2_3V Liberty exists" \
    "$STEP8/macro/AMUX2_3V.lib"

check_file "AMUX2_3V Verilog exists" \
    "$STEP8/src/AMUX2_3V.v"

check_file "design_mux RTL exists" \
    "$STEP8/src/design_mux.v"

check_file "OpenLane configuration exists" \
    "$STEP8/config.tcl"

check_file "Macro placement configuration exists" \
    "$STEP8/macro.cfg"

echo
echo "===== MACRO REFERENCES ====="

if grep -q 'AMUX2_3V.lef' "$STEP8/config.tcl"; then
    echo "PASS: LEF referenced by OpenLane configuration"
    echo "PASS: LEF referenced by OpenLane configuration" >> "$REPORT"
    PASS=$((PASS + 1))
else
    echo "FAIL: LEF referenced by OpenLane configuration"
    echo "FAIL: LEF referenced by OpenLane configuration" >> "$REPORT"
    FAIL=$((FAIL + 1))
fi

if grep -q 'AMUX2_3V.lib' "$STEP8/config.tcl"; then
    echo "PASS: Liberty referenced by OpenLane configuration"
    echo "PASS: Liberty referenced by OpenLane configuration" >> "$REPORT"
    PASS=$((PASS + 1))
else
    echo "FAIL: Liberty referenced by OpenLane configuration"
    echo "FAIL: Liberty referenced by OpenLane configuration" >> "$REPORT"
    FAIL=$((FAIL + 1))
fi

if grep -q 'AMUX2_3V.gds' "$STEP8/config.tcl"; then
    echo "PASS: GDS referenced by OpenLane configuration"
    echo "PASS: GDS referenced by OpenLane configuration" >> "$REPORT"
    PASS=$((PASS + 1))
else
    echo "FAIL: GDS referenced by OpenLane configuration"
    echo "FAIL: GDS referenced by OpenLane configuration" >> "$REPORT"
    FAIL=$((FAIL + 1))
fi

if grep -q 'AMUX2_3V' "$STEP8/src/design_mux.v"; then
    echo "PASS: design_mux instantiates AMUX2_3V"
    echo "PASS: design_mux instantiates AMUX2_3V" >> "$REPORT"
    PASS=$((PASS + 1))
else
    echo "FAIL: design_mux instantiates AMUX2_3V"
    echo "FAIL: design_mux instantiates AMUX2_3V" >> "$REPORT"
    FAIL=$((FAIL + 1))
fi

echo
echo "===== CONFIGURATION ====="

if grep -q 'SYNTH_READ_BLACKBOX_LIB' "$STEP8/config.tcl"; then
    echo "PASS: black-box macro synthesis handling configured"
    echo "PASS: black-box macro synthesis handling configured" >> "$REPORT"
    PASS=$((PASS + 1))
else
    echo "FAIL: black-box macro synthesis handling configured"
    echo "FAIL: black-box macro synthesis handling configured" >> "$REPORT"
    FAIL=$((FAIL + 1))
fi

echo
echo "===== SUMMARY ====="

echo "PASS checks : $PASS"
echo "FAIL checks : $FAIL"

{
    echo
    echo "PASS checks : $PASS"
    echo "FAIL checks : $FAIL"
} >> "$REPORT"

if [ "$FAIL" -eq 0 ]; then
    echo
    echo "OPENLANE INTEGRATION INPUT VERIFICATION: PASS"
    echo "OPENLANE INTEGRATION INPUT VERIFICATION: PASS" >> "$REPORT"
    exit 0
else
    echo
    echo "OPENLANE INTEGRATION INPUT VERIFICATION: FAIL"
    echo "OPENLANE INTEGRATION INPUT VERIFICATION: FAIL" >> "$REPORT"
    exit 1
fi
