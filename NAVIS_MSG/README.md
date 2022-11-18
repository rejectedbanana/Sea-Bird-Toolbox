# NAVIS Float

This readme is a github friendly version of import_NAVIS_Worksheet.m

## Load data from a Sea-Bird Navis Autonomous Float into MATLAB   
 This script imports the data contained in the .msg files that are
 transmitted from the NAVIS float to the server. This includes the
 engineering and scientific data, including when the float is in parked,
 discrete and profiling modes. 

 KiM MARTiNi 06.2017
 kmartini@seabird.com 

 DISCLAIMER: Software is provided as is.

## DEFINE THE FLOAT, SCIENTIFIC PAYLOAD AND DATA PATH


The scientific payload must be defined for each float in order to interpret the hexadecimal data string. In the following case, NAVIS float 0676 has a scientific payload consists of a SBE 41cp CTD, SBE 63 Optical Oxygen Sensor and a MCOMS 3-channel optical Fluorometer, Backscatter and FDOM sensor.
 
For a list of possible sensor names, type "help NavisSensor2vars" into the command line.

```matlab
% F0676 (Navis BGCi standard)
% float #
floatid = '0676';
% Define the scientific payload.
payload = {'sbe41cp', 'sbe63', 'mcoms'}; % BGCi float
% define the folder where the .msg files are stored
target_dir = 'C:\NAVIS\data\0810'; 
```
Example of a "vanilla" NAVIS float where the .msg file only contains data from a SBE 41cp CTD.

``` matlab
% F0810 (Navis BGCi standard)
% float #
floatid = '0810';
% Define the scientific payload.
payload = {'sbe41cp'}; % vanilla float
% define the folder where the .msg files are stored
target_dir = 'C:\NAVIS\data\0810'; 
```

## LOAD THE DATA
Search the data folder for all message files, then parse all the files and build the data structure "s". Each field contains all the data from a .msg file with substructures containing the configuration (header), park, discrete, profiling and engineering (footer) data. Field numbers match profile numbers. If there is no message file found for a profile, that field will be empty.

``` matlab
% find all the .msg files in the encapsulating folder
[msg] = findextension(target_dir, '.msg'); 

% clear the variables
clear s
close all

% ______\\
% cycle through the message files 
for aa = 1:length(msg)
    filename = strsplit( msg(aa).name, '.');
    if ~strcmp(filename, '000') & length( filename) == 3
        
        % define the target filems
        target_file = fullfile( target_dir, msg(aa).name);
        
        % define the profile number
        pnum = str2num( filename{2} );
        
        % load the data
        [s(pnum).header, s(pnum).park, s(pnum).discrete, s(pnum).dat, s(pnum).footer] = loadNavisMSGfile( target_file, payload );
    end
end
```

## LIST OF SENSOR NAMES
 For reference, a list of possible sensor names that have been deployed on
 Navis float variants.
### LIST OF POSSIBLE INPUT SENSORS:
      'sbe41cp'
      'sbe63'
      'sbe63flip'
      'FlBbCd'
      'FlNtuBB2'
      'FlBBBB2'
      'BB1BB2BB3'
      'mcoms'
      'pH'
      'CRover'
      'CRV'
      'tiltAzi'
      'tilt2'
      'tilt'
      'OCR'
      'PAR1'
      'PAR2'
      'OCRR'
      'OCRI'

