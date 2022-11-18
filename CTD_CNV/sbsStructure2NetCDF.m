function [target_file] = sbsStructure2NetCDF( dat, filepath, filename )
 
% function [target_file] = sbsStructure2NetCDF( dat, filepath, filename )
%
% DESCRIPTION:
% Saves data that has been imported from a Sea-Bird .cnv file into
% Matlab using readSBScnv.m into a NetCDF. If the filepath and filename are
% not specified, the script will save the NetCDF in the same folder where
% the original .cnv file originated from and give it the same name as the
% original .cnv file.
%
% INPUT:
%   dat         =   structure that is output by readSBScnv.
%   filepath    =   path to where you want the NetCDF stored (optional)
%   filename    =   Name of output file (optional)
%
% OUTPUT: 
%   target_file    =   Full path to output file
%
%
% KiM MARTiNi 04.2018
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.

% get the source and output as the the same name;
[pathname,file,ext] = fileparts(dat.source);

% define the filename as file
if nargin < 3
    filename = file;
end
% define the path 
if nargin <2
    filepath = pathname; 
end

% add .nc to the end of the filename if there isn't one
if isempty( regexp( filename, '.nc', 'once'))
    filename = [filename, '.nc'];
end %if
% define the target with the filepath
target_file = fullfile( filepath, filename );

% make a file to write to
ncid = netcdf.create( target_file, 'NC_WRITE'); 

%______\\
% CREATE THE DIMENSION
% create the dimension
dimlength = str2num(dat.softwareheaders.nvalues);
% Define a dimension in the file.
ndimid = netcdf.defDim(ncid,'nvalues', dimlength);

%______\\
% DEFINE AND WRITE THE GLOBAL ATTRIBUTES
% define the source
info.Source = dat.source; 
% define the DataFileType
info.DataFileType = dat.DataFileType; 
% define the version of Seasave
info.SeasaveVersion = dat.SeasaveVersion; 
% write the global atrributes to the file
infs = fieldnames( info );
for ii = 1:length( infs )
    netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),infs{ii}, info.(infs{ii}));
end
% write the instrument headers to the file as global attributes
if ~isempty( dat.instrumentheaders )
    headers = fieldnames( dat.instrumentheaders );
    for ii = 1:length( headers )
        netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'), headers{ii}, dat.instrumentheaders.(headers{ii}));
    end %ii
end %if
% write the user headers to the file as global attributes
if ~isempty( dat.userheaders )
    headers = fieldnames( dat.userheaders );
    for ii = 1:length( headers )
        netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'), headers{ii}, dat.userheaders.(headers{ii}));
    end %ii
end %if
% write the softwareheaders to the file as global attributes
if ~isempty( dat.softwareheaders )
    headers = fieldnames( dat.softwareheaders );
    for ii = 1:length( headers )
        netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'), headers{ii}, dat.softwareheaders.(headers{ii}));
    end %ii
end %if


%_______\\
% DEFINE AND WRITE THE VARIABLE ATTRIBUTES
for vv = 1:length( dat.mvars )
    % define the variable
    varid(vv) = netcdf.defVar( ncid, dat.mvars{vv}, 'double', ndimid); 
    % add the longname
    netcdf.putAtt( ncid, varid(vv), 'long_name', dat.longname{vv}); 
    % add the units
    netcdf.putAtt( ncid, varid(vv), 'units', dat.units{vv}); 
    % add the seabird name
    netcdf.putAtt( ncid, varid(vv), 'Sea-Bird_name', dat.vars{vv}); 
    % add the format
    netcdf.putAtt( ncid, varid(vv), 'format', dat.mvars_format{vv}); 
    
end %vv
% Leave define mode and enter data mode to write data.
netcdf.endDef(ncid);
 
%_______\\
% WRITE ALL THE DATA
% now put the data into the netCDF file
for vv = 1:length( dat.mvars )
    netcdf.putVar(ncid,varid(vv), dat.(dat.mvars{vv})) 
end

%______\\
% CLOSE THE NETCDF
netcdf.close(ncid);

