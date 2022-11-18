function [dat] = readSUNAcsv( target_file )
 
% function [dat] = readSUNAcsv( target_file )
%
% DESCRIPTION:
% Read raw metadata (to be developed) and data from a .csv downloaded from
% a Sea-Bird Scienfific SUNA. This will include all the counts from the
% spectrometer channels.
%
% INPUT:
%   target_file     =   path to .csv file to be read into matlab.
%
% OUTPUT: 
%   s               =   structure with all columns of data in the .csv
%                       file.
%
%
% KiM MARTiNi 06.2018
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.

% define the number of wavelengths
nwavelengths = 256; 

% load the data
% output the source
dat.source = target_file; 

% open the file
fid = fopen( target_file ); 

% get the first line
fline = fgetl( fid );

% get through the header
% start the header line counter
hcounter = 0;
% go through header lines starting with H
while strcmp( fline( 1:6 ), 'SATFHR') == 1    
    % grab the next line
    fline = fgetl( fid ); 
    % step the counter forward
    hcounter = hcounter+1; 
end

% define the format of columns in the output CSV 
sformat = ['%s %s %f %f %f ',...
    '%f %f %f %d %f ',...
    '%d ',...
    repmat( '%f ', [1, nwavelengths]),...
    '%f %f %f %d %f ',...
    '%f %f %f %f %f ',...
    '%f %f %f %f %d ',...
    '%f %f %f %d'];
% define the field names for each column
fields = {'FrameType', 'timedate', 'timehours','Nmolar_inst', 'N_inst',... 
    'A254nm', 'A350nm', 'Brconc', 'SpecMean', 'DarkSpectrumMean',...
    'IntegrationFactor',...
    'Spectrum',...
    'InternalTemperature', 'SpectrometerTemperature', 'LampTemperature', 'CumLampOnTime', 'InternalRelativeHumidity',...
    'MainVoltage', 'LampVoltage', 'InternalVoltage', 'MainCurrent', 'FitAux1',...
    'FitAux2', 'FitBase1', 'FitBase2', 'FITRMSE', 'CTDTime',...
    'CTDsalinity', 'CTDtemperature', 'CTDpressure', 'CheckSum'};

% pull the comma delimited cal data
C = textscan( fid, sformat, 'delimiter', ',');

% close the file 
fclose( fid ); 

% Start the making the data structure
% grab the fields before the spectrum values
for ff = 1:11
    dat.(fields{ff}) = C{ff}; 
end
% concatenate the spectrum data
dat.OutputSpectrum = [C{12:12+nwavelengths-1}]; 
% grab the fields after the spectrum
for ff = 13:length( fields ) 
    dat.(fields{ff}) = C{ff+nwavelengths-1}; 
end
% convert the timedate field to a matrix
dat.timedate = cell2mat( dat.timedate );
% convert timedate and timehours to the matlab datenum format
dat.datenum = datenum( dat.timedate(:,1:4), 'yyyy')+str2num( dat.timedate(:,5:7))-1+dat.timehours./24; 

% FIND THE SLF (light) AND THE SDF (dark) FRAMES
dat.DarkFrames = strmatch( 'SATSDF', dat.FrameType); 
dat.LightFrames = strmatch( 'SATSLF', dat.FrameType); 
