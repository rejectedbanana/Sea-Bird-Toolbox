function [O2mLL, O2uM, O2umolkg] = sbs83oxygenconc(O2Ph, O2T, cal, CTDP, CTDT, CTDPSAL, eflag )
 
% function [O2mLL, O2uM, O2umolkg] = sbs83oxygenconc( O2Ph, O2T, cal, CTDP, CTDT, CTDPSAL, eflag )
%
% DESCRIPTION:
% Calculate oxygen concentration in three different units for the 
% Sea-Bird 63 and 83 Dissolved Oxygen Sensor. Either the Sea-Bird
% calibration algorithm ('sbs') or the Argo DAC cookbook algorithm ('argo')
% can be chosen to calculate the oxygen concentration.
%
% INPUT:
% O2Ph: Raw phase delay output from SBS 83 [usec]
% O2T: Temperature from SBS 83 thermistor in [degrees C, ITS-90]. 
%       Use sbe63temperature.m to calculate temperature from voltage
%       output from the SBS 83.
% cal: Calibration coefficients from Sea-Bird calibration sheet or .cal file
%       e.g.    cal.A0 = A0; 
%               cal.A1 = A1; 
%               cal.A2 = A2; 
%               cal.B0 = B0; 
%               cal.B1 = B1; 
%               cal.C0 = C0; 
%               cal.C1 = C1; 
%               cal.C2 = C2; 
%               cal.E = E; 
% CTDP: Seawater Pressure [dbar] from an integrated CTD (SeaCAT, MircoCAT, WQM or ARGO CTD)
% CTDT: Seawater Temperature [degrees C, ITS-90] from an integrated CTD (SeaCAT, MircoCAT, WQM or ARGO CTD)
% CTDPSAL: Seawater Practical Salinity [PSU] from an integrated CTD (SeaCAT, MircoCAT, WQM or ARGO CTD)
%       CTD data can also be interpolated from an external CTD
% eflag: Used to define the processing algorith
%       e.g.    eflag = 'sbs' uses Sea-Bird Algorithm. Use to compare
%                       calibraton data.
%               eflag = 'argo' uses algorithm used by the BGC-Argo DAC
%
% ***FOR IN AIR CALCULATION***
% For the in air calculation, the air immediately above the sea surface is
% assumed to be completely saturated and fresh (100% relative humidity)
%       1. Set the CTD pressure to zero (CTDP = 0).
%       2. Set the CTD temperature to the air temperature as measured by the thermistor on the sbe83 (CTDT = O2T)
%       3. Set the CTD practical salinity to zero (CTDPSAL = 0);
%
% OUTPUT: 
% O2mLL: Oxygen concentration in mL/L
% O2uM: Oxygen concentration in uM, micromoles/L
% O2umolkg: Oxygen concentration in micromol/kg
%
% REFERENCES:
% Bittig et al. (2018). SCOR WG 142: Quality Control Procedures for Oxygen
% and Other Biogeochemical Sensors on Floats and Gliders. https://doi.org/10.13155/45915
%
% Sea-Bird Scientific (2017). SBE 63 Dissolved Oxygen Sensor User’s Manual. https://www.seabird.com
%
% Thierry Virginie, Bittig Henry, Gilbert Denis, Kobayashi Taiyo, Kanako Sato,
% Schmid Claudia (2018). Processing Argo oxygen data at the DAC level. https://doi.org/10.13155/39795
%
% Thierry Virginie, Bittig Henry, The Argo-Bgc Team (2021). Argo quality 
% control manual for dissolved oxygen concentration. https://doi.org/10.13155/46542 
%
% KiM MARTiNi 05.2021
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.

% If eflag is not defined, use the Argo DAC calculation
if nargin < 7
    eflag = 'argo';
end
% If salinity is not defined, use constant reference salinity of zero
if nargin < 6
    CTDPSAL = 0;
end
% If watertemperature is not defined, set CTD temperature to DO temperature
if nargin < 5
    CTDT = O2T; 
end
% If pressure is not defined, use constant reference pressure of zero
if nargin < 4
    CTDP = 0; 
end

% _______\\
% CONVERT TEMPERATURE 
O2TK = TC_to_TK( O2T ); % Optode temperature in Kelvin
O2Ts = TC_to_Ts( O2T ); % Scaled optode temperature
CTDTK = TC_to_TK( CTDT ); % CTD/water temperature in Kelvin
CTDTs = TC_to_Ts( CTDT ); % Scaled CTD/water temperature

% ______\\
% PRESSURE CORRECTION
% make a pressure vector where negative pressures are set to 0  
PP = (CTDP>0).*CTDP;
% use clamped pressure vector to calculate pcorr in both cases
switch lower(eflag)
    case 'sbs'
        E = cal.E; % Used in Sea-Bird Calibration and Software
        % pressure correction coefficient
        % use Optode temperature 
        Pcorr =  exp( E.*PP./O2TK ); 
    case 'argo'
        E = 0.009; % Reassesed value in Processing ARGO O2 V2.2
        % pressure adjustment of phase
        Pcoef1 = 0.115;
        O2Ph = O2Ph + (Pcoef1.*PP./1000); 
        % pressure correction coefficient from Bittig et al., (2015) when
        % phase delay has been corrected with Pcoef1
        % BGC-Argo Coolbook says use CTD temperature
        Pcoef2 = 0.00022;
        Pcoef3 = 0.0419;
        Pcorr = 1 + (Pcoef2*CTDT + Pcoef3) .* PP/1000;
end

% ______\\
% SALINITY CORRECTION
switch lower(eflag)
    case 'sbs'
        % Follow SBE 63 Manual to match calibration
        % Use SBE 63 temperature
        Scorr = SCorrExponential( O2T, CTDPSAL, 0 );
    case 'argo'
        % Follow BGC-Argo Oxygen quality control manual
        % Thierry Virginie, Bittig Henry, The Argo-Bgc Team (2016). 
        % Argo quality control manual for dissolved oxygen concentration. http://doi.org/10.13155/46542     
        Sref = 0; % Reference salinity set to 0 when calculating from the phase delay
        % Use CTD Temperature
        Scorr = SCorrExponential( CTDT, CTDPSAL, Sref );
        % Account for the change in water vapor pressure with S 
        Spreset = 0; % from manual 
        % Calculate A, the adjustment that the total pressure (Atm + pH2O) 
        % is not 1 atm (1013.2 mbar) as pH2O changes with salinity
        A = (1013.25 - VaporPressureH2O( CTDT, Spreset ) )./(1013.25 - VaporPressureH2O( CTDT, CTDPSAL ) );
        % apply to the correction
        Scorr = A.*Scorr; 
end

% ________\\
% CONVERT THE PHASE TO VOLTS
O2V = O2Ph ./ 39.457071; % DAC and SBE 63 manual use 39.457071

% ______\\
% CALIBRATION COEFFICIENTs
A = cal.A0 + cal.A1.*O2T + cal.A2.*O2V.*O2V; %  use optode temp in C
B = cal.B0 + cal.B1.*O2V;

% ______\\
% MODIFIED STERN-VOLMER CONSTANT EQUATION (Demas et al. 1999)
Ksv = cal.C0 + cal.C1*O2T + cal.C2.*O2T.*O2T; 

% _______\\
% CALCULATE OXYGEN CONCENTRATION IN [mL/L] WITH PRESSURE AND SALINITY
% CORRECTION
O2mLL = ( (A./B) - 1 )./Ksv.*Pcorr.*Scorr; 

% _______\\
% CONVERT TO MOLAR DISSOLVED OXYGEN micromoles/L [uM]
% define the moles per liter conversion
switch lower(eflag)
    case 'sbs'
        O2conv = 44.6600;      
    case 'argo'
        O2conv = 44.6596;
end
% multiply by the moles per liter converion
O2uM = O2mLL.*O2conv; % uM or micromoles/L

% ______\\
% CONVERT TO O2umolkg
% calculate the potential density
sgth = sw_pden( CTDPSAL, CTDT, CTDP, 0 ); % set reference pressure to zero
O2umolkg = O2uM./sgth;

end % sbs83oxygenconc



% _______\\
% Local Functions for repeated calculations
% _______//

% Convert temperature in Celsius to Scaled Temperature
function Ts = TC_to_Ts(TC)
    Ts = log( ( 298.15-TC )./(273.15+TC) );
end

% function for the exponential term in the salinity correction
function SCorrExp = SCorrExponential( T, PSAL, Sref )
% T is temperature in Celsius ITS-90
% PSAL is practical salinity in PSU
% salinity correction coefficients (Benson and Krause, 1984)
solB0 = -6.24523e-3;
solB1 = -7.37614e-3;
solB2 = -1.03410e-2;
solB3 = -8.17083e-3;
solC0 = -4.88682e-7;

% Convert temperature in Celsius to a scaled temperature
Ts = TC_to_Ts(T);

% Compute the exponential 
SCorrExp = exp( ( PSAL-Sref ).*( solB0 + solB1.*Ts + solB2.*Ts.*Ts + solB3.*Ts.*Ts.*Ts) + solC0.*(PSAL.*PSAL - Sref.*Sref) );
end

