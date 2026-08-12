# AMUX2_3V fresh-layout generation notes

## Methodology

This is a new, hand-authored Magic layout generated from the transistor topology in `AMUX2_3V.spice`.  The supplied sample cell was consulted only to confirm native SKY130A Magic layer and file syntax; no geometry, placement, routing, labels, or ports were copied from it.  No prior attempt directory was used and the SPICE file was not altered.

## Dimensions

The fixed cell bounding box is `1200 x 600` Magic units.  The supplied SKY130A technology file specifies a 10-nm Magic scale, so this is **12.0 um x 6.0 um**, for an area of **72.0 um2**.  It is a double-row (PMOS-over-NMOS) layout with a 2:1 width-to-height aspect ratio and matches the requested approximate footprint.

## Transistor placement

Three vertical device columns are used.  From left to right they are TG0, TG1, and the select inverter.  Each column places a 1.00-um PMOS in the upper n-well row and a 0.50-um NMOS in the lower substrate row.  The six device connections implement exactly:

- TG0 PMOS gate=`select`; TG0 NMOS gate=`sel_b`; both connect `I0` to `out`.
- TG1 PMOS gate=`sel_b`; TG1 NMOS gate=`select`; both connect `I1` to `out`.
- The rightmost CMOS inverter produces `sel_b` from `select`.

`sel_b` is deliberately internal and has no port label.

## Well and substrate strategy

The entire upper PMOS row is covered by continuous `nwell`.  A dedicated `nsubdiff`/contact well tie at the upper right connects the n-well to VDD.  The lower NMOS row uses the p-type substrate with a dedicated `psubdiff`/contact tie at the lower right connected to VSS.  Thus neither the PMOS well nor the NMOS substrate is intentionally floating.

## Power and routing strategy

Wide Metal1 rails span the full top and bottom edges for VDD and VSS.  The inverter source terminals and the explicit well/substrate taps have direct Metal1 drops to these rails.  Signal terminals use diffusion contacts, local interconnect landing pads, and Metal1.  `select` and `sel_b` are on separate horizontal Metal1 tracks.  The `out` net uses a Metal2 spine, with via transitions from all four transmission-gate output terminals; this avoids an unintended Metal1 crossing with the select-control routes.

## Pin placement

Exactly six ports are present, in canonical logical order: `I0`, `I1`, `select`, `out`, `VDD`, `VSS`.  I0 and I1 are exposed on the left and right Metal1 access spines, select is on the central Metal1 track, out is exposed at the upper-right Metal2 spine, and the power pins label full-width Metal1 rails.  Each is placed on routing-accessible metal at or near the cell boundary.

## Scope of checks

The `.mag` file was structurally inspected for Magic header/end markers, recognized layer sections, a single fixed bounding box, and unique labels/ports in the required order.  No DRC or LVS result is claimed in this task; those must be run in a SKY130A Magic/OpenLane environment before sign-off.
