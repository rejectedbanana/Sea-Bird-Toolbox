function [ netcdfname ] = sbscnv2NetCDF( source, outputpath, outputname )
 
% function [ netcdfname ] = sbscnv2NetCDF( source, outputpath, outputname )
%
% DESCRIPTION:
% Converts a .cnv file made with Sea-Bird Data Processing Software into a
% NetCDF. All data is imported as variables and all header information is
% placed into the global attributes. 
%
% If the outputpath and outputname are not specified, the NetCDF will
% assign the same name as the original .cnv file and place it in the source
% folder.
%
% INPUT:
%   source          =   path and filename of .cnv file that needs to be
%                       converted into a NetCDF. 
%   outputpath      =   define folder to save NetCDF into
%   outputname      =   define name to save NetCDF as
%
% OUTPUT: 
%   netcdfname      =   string with path and name of the output file.
%
%
% KiM MARTiNi 04.2018
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.

% breakup the source into the file parts
[pathname,file,ext] = fileparts(source);

% if no name defined, set the the name to be the same as the .cnv
if nargin < 3
    outputname = file; 
end

% if no output path is defined, place netcdf in same location as original
% .cnv
if nargin < 2
    outputpath = pathname; 
end


% read the data into Matlab
[s] = readSBScnv( source ); 

% output as a NetCDF
[netcdfname] = sbsStructure2NetCDF( s, outputpath, outputname ); 