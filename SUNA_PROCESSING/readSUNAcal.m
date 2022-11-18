function [cal] = readSUNAcal( target_file )
 
% function [cal] = readSUNAcal( target_file )
%
% DESCRIPTION:
% Import a SUNA calibration file so it can be used for processing SUNA
% data.
%
% INPUT:
%   target_file    =   path to .cal file
%
% OUTPUT: 
%   cal    =   structure containing the calibration data from the SUNA .cal
%   file
%
%
% KiM MARTiNi 03.2018
% Sea-Bird Scientific 
% kmartini@seabird.com

% output the source
cal.source = target_file; 

% open the target file
fid = fopen( target_file ); 

% get the first line
fline = fgetl( fid ); 

% start the header line counter
hcounter = 0;
prevline = fline; 
while strcmp( fline( 1 ), 'E') ~=1
    % pull the temperature calibration
    if ~isempty(regexp( fline, 'T_CAL_SWA'))
        str = strsplit( fline ); 
        cal.T_CAL_SWA = str2num( str{end}); 
    end
    prevline = fline; 
    fline = fgetl( fid );
    hcounter = hcounter+1; 
end

% pull the column headers from the previous line
columns = strsplit( prevline, ','); 

% jump back to the beginning of the file
frewind( fid ); 
% pull the comma delimited cal data
C = textscan( fid, '%s %f %f %f %f %f', 'delimiter', ',', 'headerlines', hcounter); 

% convert to something readable, skipping the first column
for cc = 2:length(columns)
    cal.(columns{cc}) = C{cc}; 
end

% close the file
fclose( fid ); 