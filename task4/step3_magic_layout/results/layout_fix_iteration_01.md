# AMUX2_3V layout fix iteration 01

## Preservation

Before modification, `AMUX2_3V.mag` was copied byte-for-byte to `step3_magic_layout/generated/AMUX2_3V_before_fix_01.mag`.  Both files had SHA-256 `77B9410FD6382B621DF0C18E691D1D839988E5895D0B85C79927BB1A15279894` at the time of backup.  The canonical SPICE was not modified.

## Defect: inverter PMOS gate floating

Physical correction: Added Metal1 rectangle `790 315 807 415`.  It overlaps the existing select track at y=315..345 and the existing inverter-PMOS poly/local-interconnect gate landing at y=395..415.  This completes the PMOS inverter gate connection to `select` while retaining the separate `sel_b` drain strap at x=815..845.

Affected geometry: Metal1 only; no transistor, power rail, well, or pin geometry was moved.

Verification performed: Static layer-overlap inspection shows the new Metal1 segment joins select at x=790..805 and reaches the PMOS gate landing.  It does not overlap the VDD source drop at x=750..780, VSS, I0, I1, or out routing.

## Defect: TG1 output Metal2 shorted to I1

Physical correction: Removed the two long Metal2 I1 routes that started at x=465.  I1 now uses its retained TG1 source landing pads on Metal2, Via2 (`m3contact`) transitions, and a dedicated Metal3 backbone to the existing right-side I1 Metal2 pin via a final Via2.  The existing I1 port name, number, and right-side location are unchanged.

Affected geometry: Metal2 I1 long-route removal; new `m3contact` and `metal3` sections/routes.  TG1 source diffusion contacts at x=450..480 are retained.

Verification performed: The I1 Metal3 backbone is electrically separated from the Metal2 output track except at intended Via2 contacts on I1 landing pads.  No via is present where Metal3 crosses the Metal2 output route.

## Defect: TG1 output not connected to out

Physical correction: Added detoured Metal2 output branches from the existing out spine to both TG1 drain M2 landing pads: `530 170 560 260` plus `300 230 560 260` for the NMOS drain, and `530 455 560 540` plus `300 510 560 540` for the PMOS drain.  The detours pass above/below the I1 Via2 landing pads at x=450..480, instead of crossing them.  TG0 output connections remain unchanged.

Affected geometry: Metal2 only.

Verification performed: Each TG1 drain pad now has continuous Metal2 overlap to the x=300..330 output spine.  The I1 Metal2 long routes that previously overlapped these pads are absent, and the new output horizontals occupy y=230..260 and y=510..540, outside the I1 Via2/M2 landing ranges y=165..205 and y=440..500.

## Post-fix static connectivity review

1. Inverter PMOS gate -> select: present through new Metal1 segment.
2. Inverter NMOS gate -> select: retained.
3. TG0 PMOS gate -> select: retained (canonical topology).
4. TG0 NMOS gate -> sel_b: retained (canonical topology).
5. TG1 PMOS gate -> sel_b: retained.
6. TG1 NMOS gate -> select: retained.
7. TG0 signal terminal -> I0: retained.
8. TG1 signal terminal -> I1: retained through Metal2/Via2/Metal3.
9. TG0 output terminals -> out: retained.
10. TG1 output terminals -> out: present through new Metal2 extensions.
11. I1 and out are not shorted by the reviewed routing layers: no Metal2 overlap remains and Metal3 crosses Metal2 without a Via2 except at I1 endpoints.
12. VDD and VSS are not geometrically merged by the correction.
13. select is not geometrically merged to power by the correction.
14. I0 and I1 are not geometrically merged by the correction.
15. All six external labels/ports are retained in their original order: I0, I1, select, out, VDD, VSS.

## Remaining concerns

This is a static connectivity-oriented inspection only.  Magic is not available in this workspace, and the stated `step3_magic_layout/ai_inputs` source directory is absent.  Requires Magic extraction/DRC verification.  No DRC-clean or LVS-clean claim is made.  In particular, verify Via2 enclosure/spacing, Metal3 design rules, extracted device terminals, pin-access legality, and complete netlist equivalence in a SKY130A Magic/OpenLane environment.
