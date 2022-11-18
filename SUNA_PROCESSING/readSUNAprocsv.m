function [dat] = readSUNAprocsv( target_file )
 
% function [dat] = readSUNAprocsv( target_file )
%
% DESCRIPTION:
% Read processed data from _pro.csv file that has been created with
% Sea-Bird Scientific UCI software from SUNA data
%
% INPUT:
%   target_file     =   path to _pro.csv file to be read into matlab.
%
% OUTPUT: 
%   s               =   structure with all columns of data in the _pro.csv
%                       file.
%
%
% KiM MARTiNi 06.2018
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.


% load the data
% output the source
dat.source = target_file; 

% open the file
fid = fopen( target_file ); 

% grab the first line
fline = fgetl( fid ); 

% get through the header
% start the header line counter
hcounter = 0;
% go through header lines starting with H
while ~isempty( fline )
    % grab the next line
    fline = fgetl( fid ); 
    % step the counter forward
    hcounter = hcounter+1; 
end

% get the line with the data column names
fline = fgetl( fid  ); 
% remove the spaces
fline = fline( ~isspace( fline )); 
% take out any periods
fline( regexp( fline , '\.')) = '_';
% split it up
vars = strsplit( fline, ',' ); 
% calculate the number of vars
nvars = length( vars ); 

% define the format of columns in the output CSV 
sformat = ['%s %s %s ', repmat( '%f ', [1, nvars-3])];

% pull the comma delimited data
C = textscan( fid, sformat, 'delimiter', ',');

% close the file
fclose( fid ); 

% make the dummy matrices 
fields = {}; units = {}; 
% break up the variables into field names and units
for vv = 1:length( vars )
    % grab the field
    varin = vars{vv}; 
    % split the field and find the units
    if ~isempty( regexp( varin , '(', 'once') )
        units{vv} =  regexp( varin, '(?<=\()(.*?)(?=\))', 'match'); 
        varin( regexp( varin, '(')) = '_'; 
        varin( regexp( varin, '/')) = ''; 
        fields{vv} = char(regexp( varin, '^[^)]*', 'match'));
    else
        fields{vv} = char(varin); 
        units{vv} = []; 
    end
end %vv

% fit the data into a matrix
for vv = 1:length( vars )
    dat.(fields{vv}) = C{vv}; 
    dat.units.(fields{vv}) = units{vv}; 
end

% reorder because it is satisfying
dat = orderfields( dat, ['source'; fields.'; 'units']); 

% add the datenum
dat.datenum = datenum( strcat( C{2}, '_',C{3}), 'yyyy-mm-dd_HH:MM:SS.FFF');