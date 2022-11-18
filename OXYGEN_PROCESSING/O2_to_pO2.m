function [pO2, O2solmLL] = O2_to_pO2( O2mLL, CTDP, CTDT, CTDPSAL, Patm )
 
% function [pO2, O2solmLL] = O2_to_pO2( O2mLL, CTDP, CTDT, CTDPSAL, Patm)
%
% DESCRIPTION:
% [text here]
%
%
% INPUT:
%   O2mLL           =   variable description
%   CTDP            =   Seawater Pressure [dbar] 
%   CTDT            =   Seawater Temperature [degrees C, ITS-90] 
%   CTDPSAL         =   Seawater Practical Salinity [PSU] 
%       CTD data can be interpolated from an external CTD
%   Patm            =   Atmospheric Air pressure [mbar]
%
% OUTPUT: 
%   pO2            =   Partial of dissolved oxygen in saltwater [mbar]
%   O2solmLL       =   Oxygen solubility in seawater [mL/L]
% 
% REFERENCES:
%
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

% IF THE ATMOSPHERIC PRESSURE IS NOT DEFINED, 
% SET IT TO NOMINAL ATMOSPHERIC PRESSURE
if nargin< 5
    Patm = 1013.25;
end

% calculate the oxygen solubility in saltwater using Benson and Krause
% refit of Garcia and Gordon (1992) in mLL
[O2solmLL, ~] = sbsoxygensol( CTDT, CTDPSAL );

% CALCULATE THE SATURATION VAPOR PRESSURE OF WATER
Spreset = 0; 
[pH2O] = VaporPressureH2O( CTDT, Spreset );

% CALCULATE THE ATMOSPHERIC EQUILIBRIUM PARTIAL PRESSURE OF OXYGEN
xO2 = 0.20946;
pO2Air = xO2.*(Patm - pH2O);

% CALCULATE THE PRESSURE CORRECTION
P = CTDP; P(P<0)=0; % set negative or in air pressures to zero
% convert temperature to Kelvin
TK = TC_to_TK( CTDT ); 
% pressure correction calculation
Vm = 0.317; 
R = 8.314; 
pcorr = exp( Vm.*P./R./ TK );

% FINALLY CALCULATE pO2 in mbar
pO2 = O2mLL./O2solmLL.*pO2Air.*pcorr;

end % O2_to_pO2_in_SW
