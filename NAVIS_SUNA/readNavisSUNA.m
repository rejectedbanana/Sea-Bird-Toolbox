function [dat] = readNavisSUNA( target_file )
 
% function [dat] = readNavisSUNA( target_file )
%
% DESCRIPTION:
% Read the .isus files output by SUNA when operated in APF mode on Navis
% floats. In APF mode, the sensor stays in low power sleep and only
% acquires data when receiving commands from a controller. 
%
% INPUT:
%   target_file    =   path and name of the .isus file, which contains the
%                       text of the data. The SUNA output is in the APF
%                       frame.
%
% OUTPUT: 
%   dat    =   structure containing all the data contained in the .isus
%               file
%
%
% KiM MARTiNi 03.2018
% Sea-Bird Scientific 
% kmartini@seabird.com

% output the source
dat.source = target_file; 

% open the file
fid = fopen( target_file ); 

% get the first line
fline = fgetl( fid ); 

% parse the line
pline = strsplit( fline ); 
% get the profile number
dat.profile = pline{2}; 
% get the date
dat.file_datenum = datenum( strcat( pline{4:end} ), 'mmmddHH:MM:SSyyyy');
% move to the next line
fline = fgetl( fid ); 

% get through the header
% start the header line counter
hcounter = 1;
% go through header lines starting with H
while strcmp( fline( 1 ), 'H') == 1
    % split the string 
    pline = strsplit( fline, ',');
    % grab the variable name and remove non-alphabetic characters
    varname = regexp( pline{2}, '\w', 'match');
    varname = char(varname).';
   
    % pull the header data
    dat.(varname) = pline{end};
    
    % grab the ext line
    fline = fgetl( fid );
    
    % step the counter forward
    hcounter = hcounter+1; 
end
% go through header lines starting with #
while strcmp( fline( 1 ), '#') == 1
    % grab the header line
    fline = fgetl( fid );
    % step the counter forward
    hcounter = hcounter+1; 
end
% now figure out how many data lines there are
dcounter = 0; 
% move forward until the end of transmission
while strcmp( fline(1:5), '<EOP>') ~=1
    % grab the data line
    fline = fgetl( fid ); 
    % step the counter forward 
    dcounter = dcounter+1; 
end

% rewind back to the beginning of the file
frewind(fid); 

% define the format of the comma delimited data
sformat = '%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s %f';

% pull the comma delimited cal data
C = textscan( fid, sformat, 'delimiter', ',', 'headerlines', hcounter); 
% trim the data
for cc = 1:length( C )
    C{cc} = C{cc}(1:dcounter);
end

% Convert the data
dat.CRC = cell2mat(C{1}); 
dat.RecordDataType = cell2mat(C{2}); 
dat.TimestampGMT = cell2mat(C{3}); % [mm/dd/yyyy HH:MM:SS UTC]

% add the CTD data
dat.CTD.Timestamp1970Epoch = C{4}; % [1970 epoch seconds]
% convert the timestamp to a datenum
dat.CTD.datenum = datenum(1970, 1, 1)+dat.CTD.Timestamp1970Epoch./60./60./24; 
dat.CTD.prSM = C{5}; % pressure [dbar]
dat.CTD.t090C = C{6}; % temperature [degreesC]
dat.CTD.sal0 = C{7}; % practical salinity [  ]

% BACK TO SUNA DATA
dat.SampleCounter = C{8}; 
dat.PowerCycleCounter = C{9}; 
dat.ErrorCounter = C{10}; 
dat.InternalTemperature = C{11}; % [degreesC]
dat.SpectrometerTemperature = C{12}; % [degreesC]
dat.InternalRelativeHumidity = C{13}; % [%]
dat.SupplyVoltage = C{14}; % [V]
dat.SupplyCurrent = C{15}; % [A]
dat.ReferenceDetectorMean = C{16}; 
dat.ReferenceDetectorStdDev = C{17}; 
dat.DarkSpectrumMean = C{18}; 
dat.DarkSpectrumStdDev = C{19}; 
dat.sal0 = C{20}; % practical salinity [  ]
dat.NO = C{21}; % sensor nitrate [muM]
dat.AbsorbanceFitResiduals = C{22}; % [RMS]
dat.OutputPixelBegin = C{23}; 
dat.OutputPixelEnd = C{24}; 
dat.OutputSpectrumHex = cell2mat(C{25}); % [Hex Packed, 4 characters for each output channel, Begin-End+1 channels]
dat.SeawaterDark = C{26}; % [Mean of Channels 1 to 5]


% CONVERT THE SUNA DATA
% convert the SUNA UTC timestamp into a datenum
dat.datenum = datenum(dat.TimestampGMT, 'mm/dd/yyyy HH:MM:SS');
% convert the output spectrum into a matrix
% get the size of the matrix
[d1, d2] = size( dat.OutputSpectrumHex); 
nchannels = d2./4; 
% make a dummy matrix to fill
dum = nan( d1, nchannels ); 
for dd = 1:nchannels
    % define the columns
    cols = (dd-1)*4+1:dd*4;
    dum( :, dd ) = hex2dec( dat.OutputSpectrumHex( :, cols) ); 
end
% load into the dat structure
dat.OutputSpectrum = dum; 
dat.nchannels = nchannels; 

% close the file 
fclose( fid ); 