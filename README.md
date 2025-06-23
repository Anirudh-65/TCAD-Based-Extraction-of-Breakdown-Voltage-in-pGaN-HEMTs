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
  - **Mg doping (N<sub>Mg</sub>)** in the p-GaN gate: 2.0 × 10¹⁹ cm⁻³

Simulations were performed using **Synopsys Sentaurus** with physical models for:
- Polarization
- Tunneling
- Trap-assisted conduction
- Impact ionization

---
## Repository Breakdown

This repository is organized into three major sections. The root directory contains the main `README.md` file providing an overview of the project, and a `setup_and_procedure.md` file detailing the TCAD modeling methodology. Two folders, `gan/` and `algan/`, contain all relevant simulation files for the GaN buffer and AlGaN buffer configurations respectively. Each of these folders includes the Sentaurus SDE input script, SDevice simulation file, shared physics model definitions, a visualization script (`svisual.tcl`), and a parameter file. The `results/` directory is divided into `gan/` and `algan/` subfolders, each holding output data and plots for the configuration that achieved the highest breakdown voltage. These include the Id–Vg curve, breakdown curve, electric field distribution image, and a summary `README.md` with observations, extracted values, and concluding insights.

---

## Simulation Summary

Breakdown characteristics were extracted using **transient drain voltage sweeps**, and electric field peaks were visualized using Sentaurus' internal plotting tools.

Each case was validated against published literature to ensure consistency in Id-Vg characteristics and threshold voltage trends. The extracted data shows:

- **Higher breakdown voltages** with **SiC** and **GaN/AlGaN buffer**
- **Electric field reduction** in designs with improved depletion control and lower Al content
- Mg doping trends affected peak field localization

---

##  Key Results

| Buffer Type | Substrate | xB | tB (nm) | V<sub>br</sub> (V) | E<sub>max</sub> (V/cm) |
|-------------|-----------|----|---------|---------------------|-------------------------|
| **GaN**     | SiC-6H    | 0.30 | 13     | **1118.39**         | **9.52 × 10⁶**          |
| **AlGaN**   | SiC-6H    | 0.30 | 10     | **1125.19**         | **9.35 × 10⁶**          |

Plots and detailed results for these configurations are included in their respective folders.

---

## Tools & Techniques Used

- **Sentaurus SDE** – For structure and meshing
- **Sentaurus SDevice** – For device-level physics simulation
- **Sentauraus Svisual** – For visualizing and inspecting layers
- **MATLAB / Python** – For post-processing and plotting results

---

## References

1. **X.-G. He**, **D.-G. Zhao**, and **D.-S. Jiang**,  
   “Formation of two-dimensional electron gas at AlGaN/GaN heterostructure and the derivation of its sheet density expression,”  
   *Chinese Physics B*, Vol. 24, No. 6, p. 067301, 2015.

2. **I. Hwang**, **M. Kim**, **S. Baik**, **H. Kim**, **K. Lee**, **T. Kim**, and **S. Ryu**,  
   “p-GaN Gate HEMTs With Tungsten Gate Metal for High Threshold Voltage and Low Gate Current,”  
   *IEEE Electron Device Letters*, Vol. 34, No. 2, pp. 202–204, 2013.

3. **Y. Wang**, **S. Hu**, **J. Guo**, **H. Wu**, **T. Liu**, and **J. Jiang**,  
   “Enhancement of Breakdown Voltage in p-GaN Gate AlGaN/GaN HEMTs With a Stepped Hybrid GaN/AlN Buffer Layer,”  
   *IEEE Journal of the Electron Devices Society*, Vol. 10, pp. 197–202, 2022.
---

## Author

**Anirudh Mittal**  
B.Tech Electrical Engineering  
Indian Institute of Technology Gandhinagar  
[anirudh.mittal@iitgn.ac.in](mailto:anirudh.mittal@iitgn.ac.in)

---


