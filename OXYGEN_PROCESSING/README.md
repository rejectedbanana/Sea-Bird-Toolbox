# Sea-Bird_Oxygen_Toolbox
 A collection of scripts developed for MATLAB to process data for Sea-Bird Oxygen Sensors. Includes the SBE 43, SBE 63 and the SBS 83.

The software is provided as is and is not officially supported by Sea-Bird Scientific. It is my own personal collection of scripts. If you find an issues, bugs or improvements please contact me! 

KiM MARTiNi 03.2022
kmartini@seabird.com

### sbe43oxygen.m
Calculates the oxygen concentration from oxygen voltage, temperature, salinity, pressure and the calibration coefficients exactly as Sea-Bird Data Processing or SeaSave would do.

### sbeO2sol.m
Calculated oxygen solubility in seawater, which you need to calculate concentration.

### sbe63oxygen.m
Calculates the oxygen concentration in mL/L from oxygen phase, oxygen temperature, salinity, pressure and the calibration coefficients exactly as Sea-Bird Data Processing or SeaSave would do.

### sbe63temperature.m
Calculates the oxygen sensor temperature from the oxygen temperature volts and the calibration coefficients exactly as Sea-Bird Data Processing or SeaSave would do.

### sbe83temperature.m
Calculates the oxygen sensor temperature from the oxygen temperature volts and the calibration coefficients.

### sbe83oxygenconc.m
Calculates the oxygen concentration in mL/L,uM, and umol/kg from the O2 phase, CTDP, CTDT, CTDpsal and the calibration coefficients.