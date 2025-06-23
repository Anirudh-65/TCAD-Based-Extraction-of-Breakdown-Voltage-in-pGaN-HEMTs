# TCAD Setup and Simulation Procedure

This document outlines the complete simulation methodology used in the project **"TCAD-Based Extraction of Breakdown Voltage in p-GaN HEMTs"**, implemented using the **Synopsys Sentaurus TCAD** toolset. The goal was to simulate and analyze the impact of heterostructure parameters—especially buffer design and substrate material—on the breakdown voltage behavior of normally-OFF p-GaN gate HEMTs.

---

## 1. Device Structure and Geometry

The simulated device is a **lateral p-GaN gate AlGaN/GaN HEMT** designed for normally-OFF operation. The base structure was inspired by the layout reported in [2] and enhanced with practical modifications.

### Layer Stack:
- **Substrate:** Variable — Silicon (Si), 4H-Silicon Carbide (SiC), Sapphire (Al₂O₃), or Gallium Oxide (Ga₂O₃)
- **Nucleation Layer:** 150 nm AlN
- **Buffer Layer:** 
  - **AlGaN/GaN hybrid buffer** (for AlGaN case), or
  - **Full GaN buffer** (for GaN case)
- **Channel:** 200 nm GaN
- **Barrier Layer:** Al<sub>x</sub>Ga<sub>1-x</sub>N (x = 0.25 or 0.30), thickness varied between 10–15 nm
- **Gate Layer:** 100 nm p-GaN (Mg-doped)
- **Passivation:** 200 nm Si₃N₄
- **Gate Metal:** Tungsten (Schottky gate contact)

---

## 2. TCAD Simulation Flow

Simulations were carried out using **Sentaurus SDE** for structure generation and meshing, followed by **Sentaurus SDevice** for electrical simulations. The basic simulation workflow involved:

### Step-by-Step Procedure:

1. **Structure Generation (SDE)**
   - Defined full device cross-section using layered material stacks
   - Included accurate dimensions based on literature
   - Applied fine meshing in critical high-field regions (e.g., gate edges, buffer junctions)

2. **Visualization (svisual)**
   - Used `svisual.tcl` to verify layer placement, thicknesses, and doping profiles

3. **Electrical Simulation (SDevice)**
   - Simulated drain bias sweeps to extract breakdown voltage (V<sub>br</sub>)
   - Used transient ramping of drain voltage until soft breakdown
   - Evaluated peak electric field distribution across layers

4. **Post-Processing**
   - Extracted Id–Vg and Id–Vd characteristics
   - Plotted electric field contours and peak spots
   - Tabulated V<sub>br</sub> and E<sub>max</sub> across configurations

---

##  3. Physical Models Enabled

To accurately capture real-world device behavior, the following physics models were incorporated in `common_des.mod`:

- **Drift-Diffusion Transport**
- **Bandgap Narrowing**
- **Shockley-Read-Hall (SRH) Recombination**
- **Trap Modeling**: Bulk and interface traps to reflect leakage and field distribution
- **Tunneling Effects**: Significant for high-field gate regions
- **Polarization Models**: Critical for AlGaN/GaN and GaN/AlN interfaces
- **Impact Ionization**: Used to determine soft breakdown onset

---

##  4. Parameter Variations

Each buffer configuration (AlGaN or GaN) was simulated across:

- **Substrate Materials**: Si, 4H-SiC, Al₂O₃, Ga₂O₃
- **Al Mole Fraction (xB)**: 0.25, 0.30
- **Barrier Thickness (tB)**: 10 nm, 13 nm, 15 nm
- **Mg Doping (N<sub>Mg</sub>)**: 1.5 × 10¹⁹ cm⁻³ and 2.0 × 10¹⁹ cm⁻³

---

## 5. Breakdown Extraction Method

Breakdown voltage was defined as the point where:
- A sharp rise in drain current occurred during the **V<sub>DS</sub> sweep**
- Peak electric field exceeded ~8–9 MV/cm in critical locations
- Drain current spiked >10× baseline indicating soft avalanche

The **maximum breakdown** observed was **1125.19 V** for the **AlGaN buffer** on a **SiC substrate**, and **1118.39 V** for the **GaN buffer** on **SiC**.

---

## 6. Validation

Simulation outputs were validated by:
- Comparing **Id–Vg characteristics** with literature (e.g., Hwang et al. [2])
- Ensuring threshold voltage and pinch-off behavior were consistent with p-GaN gate behavior
- Matching breakdown trends with known substrate thermal and electrical advantages

---

## References

[1] X.-G. He, D.-G. Zhao, and D.-S. Jiang,  
“Formation of two-dimensional electron gas at AlGaN/GaN heterostructure and the derivation of its sheet density expression,”  
*Chinese Physics B*, vol. 24, no. 6, p. 067301, 2015.

[2] I. Hwang, M. Kim, S. Baik, H. Kim, K. Lee, T. Kim, and S. Ryu,  
“p-GaN Gate HEMTs With Tungsten Gate Metal for High Threshold Voltage and Low Gate Current,”  
*IEEE Electron Device Letters*, vol. 34, no. 2, pp. 202–204, 2013.

[3] Y. Wang, S. Hu, J. Guo, H. Wu, T. Liu, and J. Jiang,  
“Enhancement of Breakdown Voltage in p-GaN Gate AlGaN/GaN HEMTs With a Stepped Hybrid GaN/AlN Buffer Layer,”  
*IEEE Journal of the Electron Devices Society*, vol. 10, pp. 197–202, 2022.
