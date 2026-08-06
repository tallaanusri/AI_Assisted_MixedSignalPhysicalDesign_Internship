
# Demonstration Video

A complete screen-recorded demonstration of this project has been prepared as part of the internship submission.

**Video Duration:** Less than 20 minutes

**Video Link:** https://drive.google.com/file/d/1uglsQlUBD10nfeG6bGEcuh80S-Up0QdC/view?usp=sharing

## Video Contents

The demonstration is organized to allow another user to reproduce the complete AI-assisted mixed-signal physical design workflow on their own machine (assuming the required tools and SKY130 PDK are already installed).

### 1. Project Introduction (First 2–3 Minutes)

* Internship task overview
* Reference repository used
* Selected circuit block: **Double-Height 2:1 Analog MUX (AMUX2_3V)**
* Design objective
* Expected deliverables and verification flow

### 2. AI-Assisted Design Workflow

The video demonstrates the complete workflow including:

* Repository structure
* AI tools used (ChatGPT/Codex)
* Prompts provided to the AI
* AI-generated circuit files
* Generated netlists
* Testbench creation
* Magic layout generation
* Folder organization
* Commands executed throughout the design flow

### 3. Design Verification

The following verification steps are demonstrated:

* NGSPICE schematic simulation
* Magic layout generation
* DRC checking
* Layout extraction
* Netgen LVS
* Post-layout simulation (where applicable)
* Waveform inspection and analysis

### 4. Debugging Process

The demonstration also includes:

* Errors encountered during implementation
* Root-cause analysis
* AI-assisted debugging
* Fixes applied
* Intermediate verification after each fix
* Final observations

### 5. Final Results

The video concludes with:

* Final project directory
* Generated design files
* Simulation outputs
* Layout screenshots
* Verification status
* Lessons learned
* Summary of the complete AI-assisted physical design workflow

---

This demonstration is intended to be fully reproducible. Every prompt, generated file, command, simulation result, screenshot, and observation used in the video is also included in this repository so that another user can follow the same workflow step-by-step.
