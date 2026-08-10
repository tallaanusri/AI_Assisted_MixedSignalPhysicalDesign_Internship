# Step 3 – Magic Layout Verification

## Objective

Open the AI-generated Magic layout in the SKY130 technology environment and verify that the layout loads correctly before extraction and LVS.

---

## Input

- AI-generated Magic layout (`AMUX2_3V_AI.mag`)
- SKY130 Magic technology file (`sky130A.magicrc`)

---

## Procedure

1. Started the OpenLane Docker container.
2. Opened Magic with the SKY130 technology file.
3. Loaded the AI-generated layout.
4. Verified that the layout was recognized by Magic.

---

## Output

- AMUX2_3V_AI.mag successfully loaded in Magic.
- Layout was prepared for extraction and LVS verification.

---

## Files

- `AMUX2_3V_AI.mag`

---

## Notes

The AI-generated layout was successfully opened using the SKY130 technology. This layout was then used for extraction and subsequent LVS debugging.
