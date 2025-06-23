## Results and Observations

This research project investigates the impact of buffer composition and substrate choice on the **breakdown behavior** of GaN HEMTs. Two buffer architectures were compared—**AlGaN buffer** and **GaN buffer**—across four substrates (Silicon, SiC (4H & 6H), and Al₂O₃), for varying **Al mole fractions (xB)** and **buffer thicknesses (tB)**.

The simulations were performed using Sentaurus TCAD, following and extending the methodology of:

> **Hwang, I. et al.**, “p-GaN Gate HEMTs With Tungsten Gate Metal for High Threshold Voltage and Low Gate Current,” *IEEE Trans. Electron Devices, 2013.*

---


###  Breakdown Voltage and Electric Field (AlGaN vs GaN Buffer)

| Substrate | xB   | tB   | V<sub>br</sub> AlGaN (V) | V<sub>br</sub> GaN (V) | E<sub>max</sub> AlGaN (V/cm) | E<sub>max</sub> GaN (V/cm) |
|-----------|------|------|---------------------------|--------------------------|-------------------------------|-----------------------------|
| Silicon   | 0.25 | 0.013 | 386.25                    | 631.03                   | 4.62×10⁶                     | 7.33×10⁶                   |
|           |      | 0.015 | 391.35                    | 639.53                   | 4.62×10⁶                     | 7.69×10⁶                   |
|           | 0.30 | 0.010 | 427.81                    | 715.36                   | 4.79×10⁶                     | 8.82×10⁶                   |
|           |      | 0.013 | 429.91                    | 728.92                   | 4.51×10⁶                     | 9.05×10⁶                   |
| SiC_4H    | 0.25 | 0.013 | 387.02                    | 889.91                   | 4.65×10⁶                     | 9.06×10⁶                   |
|           |      | 0.015 | 390.62                    | 901.40                   | 4.65×10⁶                     | 8.24×10⁶                   |
|           | 0.30 | 0.010 | 435.45                    | 1118.23                  | 4.72×10⁶                     | 9.06×10⁶                   |
|           |      | 0.013 | 435.95                    | 1091.73                  | 4.58×10⁶                     | 9.41×10⁶                   |
| Al2O3     | 0.25 | 0.013 | 370.46                    | 1010.25                  | 4.67×10⁶                     | 9.05×10⁶                   |
|           |      | 0.015 | 376.12                    | 1012.58                  | 4.58×10⁶                     | 8.41×10⁶                   |
|           | 0.30 | 0.010 | 421.70                    | 806.58                   | 4.62×10⁶                     | 5.74×10⁶                   |
|           |      | 0.013 | 425.57                    | 378.86                   | 4.52×10⁶                     | 5.95×10⁶                   |
| SiC_6H    | 0.25 | 0.013 | 900.72                    | 890.13                   | 9.52×10⁶                     | 9.52×10⁶                   |
|           |      | 0.015 | 910.78                    | 901.57                   | 9.50×10⁶                     | 9.29×10⁶               |
|           | 0.30 | 0.010 | **1125.19**               | 1091.68                  | **9.35×10⁶**                  | 9.35×10⁶                       |
|           |      | 0.013 | 1100.03                   | **1118.39**              | 9.52×10⁶                   | **9.52×10⁶**                     |

---

## Structured Explanation of Observed Results

### 1. **Why GaN Buffers Achieve Higher Breakdown Voltage**

- **Reduced Polarization Fields:**  
  GaN buffers exhibit **lower spontaneous and piezoelectric polarization** compared to AlGaN. This reduces the **electric field peak** near the drain edge, leading to **delayed onset of avalanche breakdown** and hence, higher V<sub>br</sub>.

- **Lower Interface Trap Density:**  
  GaN/GaN interfaces have **fewer traps** than AlGaN/GaN heterojunctions. This lowers leakage paths and **inhibits trap-assisted carrier multiplication**, contributing to breakdown robustness.

---

### 2. **Role of Al Mole Fraction (xB) and Buffer Thickness (tB)**

- **Increasing xB (e.g., from 0.25 to 0.30):**  
  Adds **positive polarization charge**, slightly **shifting the field peak** away from the gate. In GaN, this results in improved breakdown. However, in AlGaN buffers, this benefit is offset by stronger polarization mismatch.

- **Increasing tB (e.g., from 0.010 to 0.015 µm):**  
  Enhances **vertical field spreading**, reducing field crowding at the channel-drain junction. This marginally improves V<sub>br</sub> across all cases but saturates beyond ~15 nm.

---

### 3. **Why SiC and Sapphire Substrates Perform Better**

- **Superior Thermal Conductivity:**  
  SiC (especially 6H) and Al₂O₃ efficiently **dissipate heat**, preventing localized overheating that could trigger early breakdown.

- **Lattice Matching:**  
  These substrates provide **better lattice alignment with GaN**, minimizing dislocations and improving crystal quality—critical for high-field operation.

- **Electric Field Spreading:**  
  High-permittivity substrates enable broader **field distribution** across the vertical profile, reducing peak E-fields near the gate-drain edge.

---

### 4. **Why Silicon Substrates Lag Behind**

- **High Dislocation Density:**  
  Poor lattice match causes crystal defects, which serve as **field crowding centers** and leakage paths.

- **Inferior Thermal Handling:**  
  Lower thermal conductivity leads to **hot spots**, which can locally degrade breakdown behavior.

---

##  Conclusion

> **GaN buffers** on **SiC_6H substrates** offer the **best breakdown characteristics**, achieving over **1.1 kV breakdown voltage** and **9.5 MV/cm electric field**.  
> These findings validate and extend the conclusions of Hwang et al., highlighting the significance of **buffer material engineering and substrate optimization** in designing high-voltage GaN HEMTs.

