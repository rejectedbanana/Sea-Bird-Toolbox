# Sea Bird Toolbox

A collection of scripts I have developed for Matlab to process data from Sea-Bird Scientific instruments. Sea-Bird makes oceanographic sensors and instrumentation. 

The software is provided as is and is not officially supported by Sea-Bird Scientific. It is my own personal collection of scripts. If you find an issues, bugs or improvements please contact me! 

KiM MARTiNi 08.2017
kmartini@seabird.com


## FUNCTIONS FOR IMPORTING AND EXPORTING

### readSBScnv.m
A script that pulls the majority of information in the header and all the data columns and puts them into a compact matlab structure. This includes the user input headers, variable names, variable spans, variable units, and the file modification list found at the end of the header. Uses interpretSBSvariable.m to determine the variable names which was painstakingly copied from the [Sea-Bird Data Processing Manual](http://www.seabird.com/sites/default/files/documents/SBEDataProcessing_7.26.7.pdf) by hand. This script has been tested on .cnvs output from SBE 911, 16, 19, 49, 25, 37, and 39 instruments. 

### readSBScnv.m
A script that reads a .cal file and puts them in to a ,cal structure. 

### sbsStructure2NetCDF.m
A script that writes the data contained in the structure imported into matlab with readSBScnv.m into a NetCDF. Currently does not support the addition of additional fields. This script has been tested on .cnvs output from SBE 911, 16, 19, 49, 25, 37, and 39 instruments. 

### sbscnv2NetCDF.m
A wrapper script that writes all the data and metadata from a .cnv file into a NetCDF file. Really handy if you want to share the data with someone that doesn't use matlab. This script has been tested on .cnvs output from SBE 911, 16, 19, 49, 25, 37, and 39 instruments. 

## FUNCTIONS FOR SEA-BIRD DATA PROCESSING
These are common functions that are used in Sea-Bird Data processing. Specifically, it's the Filter Module, the Align Module, and the Cell Thermal Mass Module. I've also included a script that calculates oxygen concentration from oxygen voltage and the calibration coefficients. 

### SBE_filterW.m
The "Filter..." module

### SBE_alignCTDW.m
The "Align CTD..." module

### SBE_CellTMW.m
The "Cell Thermal Mass..." module

### sbe43oxygen.m
Calculates the oxygen concentration from oxygen voltage, temperature, salinity, pressure and the calibration coefficients exactly as Sea-Bird Data Processing or SeaSave would do.

### sbeO2sol.m
Calculated oxygen solubility in seawater, which you need to calculate concentration.