# Craps Dice Game – VHDL Implementation

This repository contains a complete FPGA-based implementation of the **Craps dice game**, developed in **VHDL** as part of a Digital Logic Design project.
The system is designed using a **modular datapath + FSM controller architecture** and includes full simulation testbenches for verification.

---

# Game Rules (Craps)

 **First roll**
  - Win if the sum is **7 or 11**
  - Lose if the sum is **2, 3, or 12**
  - Otherwise, the sum becomes the **point**

 **Subsequent rolls**
  - Win if the sum equals the stored **point**
  - Lose if the sum is **7**
  - Otherwise, continue rolling
  - 
---

# System Architecture

The design follows a clean separation between:

## Datapath
- Two pseudo-random dice generators (LFSR-based)
- Adder for dice sum
- Sum register
- Point register
- Comparator
- Test logic for win/lose conditions
- 7-segment display drivers

## Controller
- Finite State Machine (FSM)
- Controls rolling, latching, point storage, and game flow

---

# Project Structure
src/    → VHDL source files (datapath + controller) 
tb/     → Testbenches for all components and full system 
docs/   → Project specification and documentation

---

# Verification

Each module is verified using an independent **testbench**.
A full system testbench (`tb_dice_game.vhd`) validates correct game behavior across:
- First roll win/lose
- Point storage
- Subsequent roll win/lose conditions
- Reset behavior

---

# Tools

- Language: **VHDL**
- Libraries: `ieee.std_logic_1164`, `ieee.numeric_std`
- Simulation: ModelSim / Questa / Vivado Simulator / GTKWave

---

# How to Run

1. Compile all files in `src/`
2. Compile testbenches in `tb/`
3. Run simulations for individual modules or the full system
4. Observe waveforms to verify correct behavior

---

# Authors

**Zeinab Khalili** and **Fatemeh Shabani**  
Software Engineering Students  
Digital Logic 

