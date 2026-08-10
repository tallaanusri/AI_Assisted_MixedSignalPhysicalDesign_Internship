# Step 3 – Magic Layout Verification

## Objective

Verify the AI-generated Magic layout using the SKY130 technology in Magic.

---

## Commands Used

```bash
magic -rcfile <sky130A.magicrc> AMUX2_3V_AI.mag
```

Inside Magic:

```tcl
load AMUX2_3V_AI
drc check
drc count
```

---

## Results

- Successfully loaded the AI-generated layout in Magic.
- Verified that the SKY130 technology file was loaded correctly.
- Performed DRC verification.
- During extraction, electrical shorts were observed between multiple ports, indicating that additional layout corrections are required before LVS can succeed.

---

## Files

| File | Description |
|------|-------------|
| AMUX2_3V_AI.mag | AI-generated Magic layout |
| drc_layout.png | Screenshot of the layout opened in Magic |
