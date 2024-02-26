# Sea Bird Toolbox
## THIS TOOLBOX IS NO LONGER MAINTAINED! But you can always reach me at kmartini@tiniscientific.com

A collection of scripts I have developed for Matlab to process data from Sea-Bird Scientific oceanographic sensors, instruments and floats.

The software is provided as is and is not officially supported by Sea-Bird Scientific. It is my own personal collection of scripts. If you find an issues, bugs or improvements please contact me! 

KiM MARTiNi 02.2024 

## CTD_CNV - FUNCTIONS FOR IMPORTING AND EXPORTING

### readSBScnv.m
A script that pulls the majority of information in the header and all the data columns and puts them into a compact matlab structure. This includes the user input headers, variable names, variable spans, variable units, and the file modification list found at the end of the header. Uses interpretSBSvariable.m to determine the variable names which was painstakingly copied from the [Sea-Bird Data Processing Manual](http://www.seabird.com/sites/default/files/documents/SBEDataProcessing_7.26.7.pdf) by hand. This script has been tested on .cnvs output from SBE 911, 16, 19, 49, 25, 37, and 39 instruments. 

### readSBScal.m
A script that reads a .cal file and puts them in to a ,cal structure. 

### sbsStructure2NetCDF.m
A script that writes the data contained in the structure imported into matlab with readSBScnv.m into a NetCDF. Currently does not support the addition of additional fields. This script has been tested on .cnvs output from SBE 911, 16, 19, 49, 25, 37, and 39 instruments. 

### sbscnv2NetCDF.m
A wrapper script that writes all the data and metadata from a .cnv file into a NetCDF file. Really handy if you want to share the data with someone that doesn't use matlab. This script has been tested on .cnvs output from SBE 911, 16, 19, 49, 25, 37, and 39 instruments. 

### interpretSBSvariable.m
Converts the strings that define SBE variables to strings that matlab can use as functions. Gives units for each variable and defines whether it is a number or a text string. 

## CTD_PROCESSING - FUNCTIONS FOR SEA-BIRD CTD DATA PROCESSING
These are common functions that are used in Sea-Bird Data processing. Specifically, it's the Filter Module, the Align Module, and the Cell Thermal Mass Module. 

### SBE_filterW.m
The "Filter..." module

### SBE_alignCTDW.m
The "Align CTD..." module

### SBE_CellTMW.m
The "Cell Thermal Mass..." module

## NAVIS_MSG - FUNCTIONS FOR IMPORTING SEA-BIRD NAVIS .MSG FILE
These scripts imports the data contained in the .msg files that are transmitted from the NAVIS float to the server. This includes the engineering and scientific data, including when the float is in parked, discrete and profiling modes.

### loadNavisMSGfile.m
Read and import data from a NAVIS Float .msg file. 

### Other .mfiles
Functions that loadNavisMSGfile.m needs to work

## NAVIS_SUNA - FUNCTIONS FOR IMPORTING SEA-BIRD SUNAS DEPLOYED ON FLOATS IN APF MODE
These scripts import SUNA data files (.isus) and SUNA calibration files (.cal) and calculates nitrogen concentration.

### readNavisSUNA.m
Read and import data from .isus file sent by a SUNA in APF mode

### readSUNAcal.m
Read and import data from SUNA .cal file

### APF2NO.m
Calculate nitrogen concentration from imported data and calibration file

## OXYGEN_PROCESSING - FUNCTIONS FOR PROCESSING OXYGEN SENSOR DATA
 A collection of scripts developed for MATLAB to process data for Sea-Bird Oxygen Sensors. Includes the SBE 43, SBE 63 and the SBS 83.

### sbe43oxygen.m
Calculates the oxygen concentration from oxygen voltage, temperature, salinity, pressure and the calibration coefficients exactly as Sea-Bird Data Processing or SeaSave would do.

### sbe63oxygen.m
Calculates the oxygen concentration in mL/L from oxygen phase, oxygen temperature, salinity, pressure and the calibration coefficients exactly as Sea-Bird Data Processing or SeaSave would do.

### sbe63phase.m
Backout phase delay as measured by the Sea-Bird 63 Oxygen Sensor from oxygen concentration [ml/L].

### sbe63temperature.m
Calculates the oxygen sensor temperature from the oxygen temperature volts and the calibration coefficients exactly as Sea-Bird Data Processing or SeaSave would do.

### sbe83oxygenconc.m
Calculates the oxygen concentration in mL/L,uM, and umol/kg from the O2 phase, CTDP, CTDT, CTDpsal and the calibration coefficients.

### sbsoxygensol.m
Calculated oxygen solubility in seawater, which you need to calculate concentration.

### O2_to_pO2.m
Calculate pO2 as measured by oxygen sensors when in saltwater. 

### O2_to_pO2.m
Calculate pO2 as measured by oxygen sensors when in air. The assumption is that water vapor in air is fresh (practical salinity = 0) and there is no hydrostatic pressure. 

### VaporPressureH2O.m
Calculate the Saturated Vapor Pressure of Water in mbar after Weiss and Price (1980)

### VaporPressureH2O_InAir.m
Calculate the saturated Vapor Pressure in air. Choose your favorite method.

### TC_to_TK.m
Convert temperature in Celsius to Kelvin. 

## SUNA_PROCESSING - FUNCTIONS FOR PROCESSING SUNA NITRATE SENSOR DATA
 A collection of scripts developed for MATLAB to process data for Sea-Bird/Satlantic SUNA Nitrate Sensors. 
 
 ### readSUNAcal.m
 Import a SUNA cal file into Matlab
 
 ### SUNA2NO.m
 Algorithm for calculating Nitrogen concentrations from SUNA data. Includes the Sakamoto seawater correction.
 
 ### readSUNAcsv.m
 Read raw metadata (to be developed) and data from a .csv downloaded from a Sea-Bird Scienfific SUNA. This includes all counts from the spectrometer channels.
 
 ### readSUNAprocsv.m
 Read processed data from _pro.csv file that has been created with Sea-Bird Scientific UCI software from SUNA data
