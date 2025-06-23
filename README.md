# TCAD-Based Extraction of Breakdown Voltage in pGaN HEMTs

This repository presents a complete Sentaurus TCAD-based investigation into the **breakdown voltage characteristics of normally-OFF p-GaN HEMTs**, focusing on the influence of **heterostructure engineering** — particularly **buffer configuration** and **substrate material** — on high-voltage performance.

The work was:
- Presented at the **Undergraduate Research Showcase, IIT Gandhinagar**

---

## Project Overview

Gallium Nitride (GaN) based High Electron Mobility Transistors (HEMTs) are a critical enabler for next-generation high-voltage, high-frequency electronics. Achieving **normally-OFF operation** using a **p-GaN gate** introduces the opportunity for safer and more efficient device designs.

This project simulates and analyzes:
- The impact of **buffer layer configuration**:  
  - Case 1: **AlGaN buffer** followed by GaN  
  - Case 2: **Full GaN buffer**
- The effect of **substrate variation** across:
  - **Silicon (Si)**
  - **4H-Silicon Carbide (SiC-4H)**
  - **Sapphire (Al₂O₃)**
  - **6H-Silicon Carbide (SiC-6H)**
- Key parameters like:
  - **Al mole fraction (xB)** in the barrier: 0.25, 0.30
  - **Barrier thickness (tB)**: 10–15 nm
  - **Mg doping (N<sub>Mg</sub>)** in the p-GaN gate: 1.5 × 10¹⁹ – 2.0 × 10¹⁹ cm⁻³

Simulations were performed using **Synopsys Sentaurus** with physical models for:
- Polarization
- Tunneling
- Trap-assisted conduction
- Impact ionization

---
