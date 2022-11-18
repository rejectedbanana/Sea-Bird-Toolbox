function [pH2O] = VaporPressureH2O( T, PSAL )
 
% function [pH2O] = VaporPressureH2O( T, PSAL )
%
% DESCRIPTION:
%  Calculate the Saturated Vapor Pressure of Water in mbar after Weiss and
%  Price (1980)
%
% INPUT:
%   T            =   temperature in Celsius ITS-90
%   PSAL         =   practical salinity in PSU
%
% OUTPUT: 
%   pH2O         =   saturation water vapor pressure
%
% REFERENCES:
%
% Weiss, R. F., and B. A. Price. "Nitrous oxide solubility in water and 
% seawater." Marine chemistry 8, no. 4 (1980): 347-359.
%
% KiM MARTiNi 05.2021
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.

% Coefficients from BGC-Argo Oxygen quality control manual
D0 = 24.4543;
D1 = -67.4509;
D2 = -4.8489;
D3 = -5.44e-4;

% Convert the Temperature into Kelvin
TK = TC_to_TK(T);

% calculate the vapor pressure in mbar
pH2O = 1013.25.*exp( D0 + D1*(100./TK) + D2.*log(TK./100) + D3.*PSAL );

end % VaporPressureH2O