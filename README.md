# Sea Bird Toolbox

A collection of scripts I have developed for Matlab to process data from Sea-Bird Scientific instruments. Sea-Bird makes oceanographic sensors and instrumentation. Currently the only script in the toolbox is a parser for the .cnv files that are output from Sea-Bird Data Procesing Software, readSBScnv.m. 

The software is provided as is and is not officially supported by Sea-Bird Scientific. It is my own personal collection of scripts. If you find an issues, bugs or improvements please contact me! 

KiM MARTiNi 08.2017
kmartini@seabird.com


## readSBScnv.m
A script that pulls the majority of information in the header and all the data columns and puts them into a compact matlab structure. This includes the user input headers, variable names, variable spans, variable units, and the file modification list found at the end of the header. Uses interpretSBSvariable.m to determine the variable names which was painstakingly copied from the [Sea-Bird Data Processing Manual](http://www.seabird.com/sites/default/files/documents/SBEDataProcessing_7.26.7.pdf) by hand. This script has been tested on .cnvs output from SBE 911, 16, 19, 49, 25, 37, and 39 instruments. 

