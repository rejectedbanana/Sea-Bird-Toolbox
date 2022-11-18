function [MOLAR_NITRATE, NITRATE] = SUNA2NO(OPTICAL_WAVELENGTH_UV, E_NITRATE, E_SWA_NITRATE, UV_INTENSITY_REF_NITRATE, TEMP_CAL_NITRATE, OPTICAL_WAVELENGTH_OFFSET, PIXEL_START, PIXEL_END, UV_INTENSITY_NITRATE, UV_INTENSITY_DARK_NITRATE, HUMIDITY_NITRATE, TEMP_NITRATE, TEMP_SPECTROPHOTOMETER_NITRATE, TEMP, PSAL, PRES)
 
% function [MOLAR_NITRATE, NITRATE] = SUNA2NO(OPTICAL_WAVELENGTH_UV, E_NITRATE, E_SWA_NITRATE, UV_INTENSITY_REF_NITRATE, TEMP_CAL_NITRATE, OPTICAL_WAVELENGTH_OFFSET, PIXEL_START, PIXEL_END, UV_INTENSITY_NITRATE, UV_INTENSITY_DARK_NITRATE, HUMIDITY_NITRATE, TEMP_NITRATE, TEMP_SPECTROPHOTOMETER_NITRATE, TEMP, PSAL, PRES)
%
% DESCRIPTION:
% [text here]
%
% INPUT:
%   var1    =   variable description
%
% OUTPUT: 
%   var1    =   variable description
%
%
% KiM MARTiNi 03.2018
% Sea-Bird Scientific 
% kmartini@seabird.com


% define R, the interval of pixels in the calibration data that corresond
% to 217 - 250 nm
R = [PIXEL_START:PIXEL_END];
% now define the subset of pixels for the fit
PIXEL_FIT_START = PIXEL_START; 
PIXEL_FIT_END = R(find( OPTICAL_WAVELENGTH_UV(R)<240, 1, 'last'));
Rfit = [PIXEL_FIT_START:PIXEL_FIT_END]; 

% STEP I: Compute absorbance of seawater
% calculate absorbance over the pixel range R
ABSORBANCE_SW = -log10( (UV_INTENSITY_NITRATE - UV_INTENSITY_DARK_NITRATE)./UV_INTENSITY_REF_NITRATE(R) );

% STEP II: Remove spectrum due to bromide and other sea salt components
if ~isempty( TEMP_CAL_NITRATE )
    % two calculations for F
    Ftemp = calculateASW(OPTICAL_WAVELENGTH_UV(R), TEMP, OPTICAL_WAVELENGTH_OFFSET);
    Fcaltemp = calculateASW(OPTICAL_WAVELENGTH_UV(R), TEMP_CAL_NITRATE, OPTICAL_WAVELENGTH_OFFSET);
    % calculate the spectrum due to Bromide and other sea salt components, with
    % a correction of in situ temeprature
    E_SWA_INSITU = E_SWA_NITRATE(R).*Ftemp./Fcaltemp;
    % Calculate the predicted absorbance spectrum due to nitrate and the
    % baseline
    ABSORBANCE_COR_NITRATE = ABSORBANCE_SW - E_SWA_INSITU.*PSAL; %.*(1-(0.02.*PRES/1000));
else
    % no corrections
    ABSORBANCE_COR_NITRATE = ABSORBANCE_SW; 
end


% STEP III: Compute nitrate concentration
% build the linear model Y = X*BETA
X = [0.01.*ones( size( ABSORBANCE_COR_NITRATE(1:length(Rfit)) )).', 0.001.*OPTICAL_WAVELENGTH_UV(Rfit).', E_NITRATE(Rfit).']; 
Y = ABSORBANCE_COR_NITRATE(1:length(Rfit)).';
% solve for BETA using multiple linear regression
BETA = X\Y;
% % charlie's way (they match)
% M = [0.01.*ones( size( ABSORBANCE_COR_NITRATE(1:length(Rfit)) )).', 0.001.*OPTICAL_WAVELENGTH_UV(Rfit).', E_NITRATE(Rfit).'];
% M_INV = pinv(M); 
% BETA = M_INV * Y;

% Reassign BETA
BASELINE_INTERCEPT = BETA(1); 
BASELINE_SLOPE = BETA(2); 
MOLAR_NITRATE = BETA(3); % nitrogen concentration [micromole/L]

% STEP IV: compute nitrate as micromol/kg using density
% define density
% 1 mg/L of Nitrate + Nitrite = 71.378 uM of Nitrate + Nitrite from King County Environmental Labs    
RHO_NO = 71.378;
% calculate nitrate
NITRATE = MOLAR_NITRATE./RHO_NO;

function F = calculateASW(OPTICAL_WAVELENGTH_UV, T, OPTICAL_WAVELENGTH_OFFSET)
    
    % function F = calculateASW(OPTICAL_WAVELENGTH_UV, T, OPTICAL_WAVELENGTH_OFFSET)  
    %
    % Calculate the baseline-corrected sea water abosrbance. This is used
    % to remove the background bromide spectrum.

    % define the constants
    A = 1.1500276;
    B = 0.02840;
    C = -0.3101349;
    D = 0.001222;

    % calcualte F
    F = (A+B.*T).*exp((C+D*T).*(OPTICAL_WAVELENGTH_UV - OPTICAL_WAVELENGTH_OFFSET));
end

end

