function [dat] = APF2NO( dat, cal, aux )
 
% function [dat] = APF2NO( dat, cal, aux )
%
% DESCRIPTION:
% Calculates nitrate concentrations from data output from SUNA deployed on
% Sea-Bird Navis BGCi floats. Uses the associated calibration data
% from that SUNA serial number.
%
% INPUT:
%   dat    =   SUNA instrument data structure imported from .csv or .isus
%               files using a function such as readSUNAAPF.m
%   cal    =   SUNA calibration data structure imported from relevant
%              .cal file into MATLAB using readSUNAcal.m.
%   aux    =   additional constants to used to calculate nitrogen 
%              concentrations
%               - aux.deltaZ    
%                   vertical distance between the CTD pressure port
%                   and the SUNA window. 
%                   Profiling upward and the SUNA is deeper than
%                   the CTD, deltaP > 0 (i.e. on an Argo float). 
%                   Profiling downward and the SUNA is shallower
%                   than the CTD, deltaP < 0, (i.e. on CTD carousel) 
%               - aux.OPTICAL_WAVELENGTH_OFFSET
%                   This parameter can be in the range from 206-212 nm 
%                   depending on uncertainty in the wavelength
%                   registration of the diode array spectrometer.
%                   
%
% OUTPUT: 
%   dat    =   SUNA instrument data structure exported with nitrogen
%               concentrations.
%
%
% KiM MARTiNi 03.2018
% Sea-Bird Scientific 
% kmartini@seabird.com

% if not specified, use defaults for auxillary data
if nargin < 3
    % vertical distance between the CTD pressure port and the SUNA window 
    aux.deltaP = 0; % [dbar] 
    % optical wavelength offset constant
    aux.OPTICAL_WAVELENGTH_OFFSET = 208.5; % [nm]
end

% pull the calibration information from the .cal structure
OPTICAL_WAVELENGTH_UV = cal.Wavelength.'; % wavelength of pixels 1:M [nm]
E_NITRATE = cal.NO3.'; % molar absoptivity of nitrate [liter mumol.^-1 path_length.^-1]
E_SWA_NITRATE = cal.SWA.'; % sea water absorptivity 
% cal.TSWA is a Satlantic proprietary and not used
UV_INTENSITY_REF_NITRATE = cal.Reference.';  % light intensity reaching detector array through ultrapure water minus detector counts with the lamp turned off.
TEMP_CAL_NITRATE = cal.T_CAL_SWA; % Laboratory temperatures at which E_SWA_NITRATE were determined [degreeC]
OPTICAL_WAVELENGTH_OFFSET = aux.OPTICAL_WAVELENGTH_OFFSET; 


% The CTD and the nitrate sensor are seperated in space. Interpolate
% the CTD data where the nitrate sensor window is located
t = dat.CTD.t090C; 
s = dat.CTD.sal0;
p = dat.CTD.prSM; 
% interpolate the data
Pint = p+aux.deltaP; 
Tint = interp1( p, t, Pint); 
Sint = interp1( p, s, Pint); 

% find the size of the data
[d1, d2] = size( dat.OutputSpectrum ); 
% make empty matrices to fill
dat.MolarNitrate = nan( d1, 1); 
dat.Nitrate = dat.MolarNitrate; 

% cycle through each line of data
for dd = 1:d1
    
    % pull the data
    PIXEL_START = dat.OutputPixelBegin(dd); % start of the pixel span of spectrometer channels
    PIXEL_END = dat.OutputPixelEnd(dd); % end of the pixel span of spectrometer channels
    
    % pull the instrument data
    UV_INTENSITY_NITRATE = dat.OutputSpectrum(dd,:); % intesity of ultraviolet flux from nitrate sensor [counts]
    UV_INTENSITY_DARK_NITRATE = dat.DarkSpectrumMean(dd,:); % intensity of ultraviolet flux dark measurement from nitrate sensor [counts]
    HUMIDITY_NITRATE = dat.InternalRelativeHumidity(dd,:); % Relative Humidity inside the SUNA sensor [%]
    TEMP_NITRATE = dat.InternalTemperature(dd,:); % internal temperature of the SUNA sensor [degreeC]
    TEMP_SPECTROPHOTOMETER_NITRATE = dat.SpectrometerTemperature(dd,:); % temperature of the spectrometer [degreeC]
    
    % pull the CTD data
    TEMP = Tint(dd); % temperature sampled by the CTD [degreeC]
    PSAL = Sint(dd); % practical salinity sampled by the CTD [  ]
    PRES = Pint(dd); % pressure sampled by the CTD [dbar]

    % calculate nitrate concentrations following 
    [MOLAR_NITRATE, NITRATE] = SUNA2NO(...
        OPTICAL_WAVELENGTH_UV, E_NITRATE, E_SWA_NITRATE, UV_INTENSITY_REF_NITRATE, TEMP_CAL_NITRATE, OPTICAL_WAVELENGTH_OFFSET,...
        PIXEL_START, PIXEL_END,...
        UV_INTENSITY_NITRATE, UV_INTENSITY_DARK_NITRATE,...
        HUMIDITY_NITRATE, TEMP_NITRATE, TEMP_SPECTROPHOTOMETER_NITRATE,...
        TEMP, PSAL, PRES);
    
    % add the data back to the original data structure
    dat.Nmolar(dd) = MOLAR_NITRATE;
    dat.N(dd) = NITRATE;
    
end %dd