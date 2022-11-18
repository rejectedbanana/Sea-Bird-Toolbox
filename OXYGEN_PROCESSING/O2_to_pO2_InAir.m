function [pO2] = O2_to_pO2_InAir( O2mLL, AIRT, Patm, RH )
 
% function [pO2] = O2_to_pO2( O2mLL, AIRT, Patm, RH )
%
% DESCRIPTION:
% Calculate pO2 as measured by oxygen sensors when in air. The assumption
% is that water vapor in air is fresh (practical salinity = 0) and there is
% no hydrostatic pressure. 
%
% For gain calculations, must use true atmosperhic air pressure and
% relative humidity from external observations/models (NCEP, ECMWF)
%
%
% INPUT:
%   O2mLL           =   variable description
%   AirT            =   Air Temperature use value from O2 sensor [degrees C, ITS-90]
%       CTD data can be interpolated from an external CTD
%   Patm            =   Atmospheric Air pressure [mbar] default is 1013.25 mbar
%   RH            =   Relative humidity [%] default is 100%
%  
%
% OUTPUT: 
%   pO2            =   Partial of dissolved oxygen in saltwater [mbar]
% 
% REFERENCES:
%
% Bittig et al. (2018). SCOR WG 142: Quality Control Procedures for Oxygen
% and Other Biogeochemical Sensors on Floats and Gliders. https://doi.org/10.13155/45915
%
% Bushinsky, Seth M., Steven R. Emerson, Stephen C. Riser, and Dana D. Swift. 
% "Accurate oxygen measurements on modified A rgo floats using in situ air
% calibrations." Limnology and Oceanography: Methods 14, no. 8 (2016): 491-505.
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

% IF THE ATMOSPHERIC PRESSURE IS NOT DEFINED, 
% SET IT TO NOMINAL ATMOSPHERIC PRESSURE
if nargin< 3
    Patm = 1013.25;
end

% IF THE RELATIVE HUMIDITY IS NOT DEFINED, SET IT TO 100%
if nargin <4
    RH = 100; 
end

% In air the salinity is zero for the oxygen solubility and saturation
% vapor pressure calculation
AIRPSAL = 0;

% calculate the oxygen solubility using Benson and Krause
% refit of Garcia and Gordon (1992) for seawater in mLL
% assume water in air is fresh.
[O2solmLL, ~] = sbsoxygensol( AIRT, AIRPSAL );

% CALCULATE THE SATURATION VAPOR PRESSURE OF WATER
% [pH2O] = VaporPressureH2O( AIRT, AIRPSAL );
[pH2O] = VaporPressureH2O_InAir( AIRT );

% scale the oxygen solubility by the ambient air pressure for the surface
% application (Bittig et al. 2018, equation 3 ) i.e. scaled for changes in
% atmospheric air pressure
O2solmLL = O2solmLL.*(Patm - pH2O)./(1013.25-pH2O);

% CALCULATE THE ATMOSPHERIC EQUILIBRIUM PARTIAL PRESSURE OF OXYGEN
% USING RELATIVE HUMIDTY (Bushinsky et al. 2016, equation 1 )
xO2 = 0.20946;
pO2Air = xO2.*(Patm - (pH2O.*RH./100));

% **No hydrostatic water pressure correction in air **

% FINALLY CALCULATE pO2
pO2 = O2mLL./O2solmLL.*pO2Air;

end % O2_to_pO2_in_SW
