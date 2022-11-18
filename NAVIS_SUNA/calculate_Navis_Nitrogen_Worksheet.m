%% Calculate nitrogen concentration from a SUNA on a Sea-Bird Navis BGCi
% ______\\
% This script imports SUNA data files (.isus) and SUNA calibration 
% files (.cal) and calculates nitrogen concentration.
%
% The data from SUNAs are telemetered via satellite from the BGCi float as
% ASCII files with the .isus file extension. The SUNA is operating in APF
% mode such that the data format is in the APF frame.
% 
% The calibration data is provided to the customer by Sea-Bird upon initial
% delivery as ASCII files with .cal file extension. When the reference
% spectrum is updated by the customer upon delivery of the insttrument, the
% a new .cal file will be produced and should be used to process the data.
%
% Nitrogen concentrations are calculated following Johnson et al (2016).
%
% Each cell in the worksheet can be executed using the run section button 
% or by typing ctrl-enter into the command line
%
% ______\\
% REFERENCES:
% Johnson, Ken, Orens Pasqueron De Fommervault, Romain Serra, 
% Fabrizio D'Ortenzio, Catherine Schmechtig, Hervé Claustre, and 
% Antoine Poteau. "Processing Bio-Argo nitrate concentration at the 
% DAC Level." (2016).
%
% ______\\
% KiM MARTiNi 03.2018
% kmartini@seabird.com 
%
% DISCLAIMER: Software is provided as is.

%% Load the most recent calibration file.
% This should be the calibration associated with the reference spectrum
% update performed by the customer

% define calibration file, with the full path 
cal_target_dir = 'C:\SUNAcals\SNA1099C.cal'; 

% use the provided script to load the calibration data
% outputs a structure with all the data in the calibration file
[cal] = readSUNAcal( cal_target ); 

%% Load the data file from the Navis float
% this is an ASCII text file with extension .isus

% define the data file to import, with the full path
data_target = 'I:\SUNAdata\0883.002.isus'; 

% use the provided script to load the calibration data
% outputs a structure with all the data in the data file
[dat] = readNavisSUNA( data_target ); 


%%  calculate nitrogen concentrations
% define some auxillary data

% define the vertical distance between the CTD pressure port and the
% SUNA window (default is zero)
aux.deltaP = -0.87; % [m]
% define the optical wavelength offset, which is constant
aux.OPTICAL_WAVELENGTH_OFFSET = 208.5; % [nm]

% calculate nitrogen concentrations. MolarNitrate and Nitrate fields will
% be added to the .dat structure and contain concentrations in units of 
% micromol/L and micromole/kg, respectively.
[dat] = APF2NO( dat, cal, aux ); 


