function [o2tempvolts] = sbe63tempvolts( o2temp, cal )
 
% function [o2tempvolts] = sbe63tempvolts( o2temp, cal )
%
% DESCRIPTION:
% Backout the voltage output from thermistor temperature [degreeC] 
% on a Sea-Bird 63 Oxygen Sensor.
% Equations can be found in Appendix 1 of the SBE 63 manual
% https://www.seabird.com/oxygen-sensors/sbe-63-optical-dissolved-oxygen-sensor/family-downloads?productCategoryId=54627869933
%
% INPUT:
%   o2temp    =   Oxygen Temperature, SBE 63 [ITS-90, deg C]
%   cal    =   Calibration coefficients structure from SBE calibration sheet
%       e.g.    cal.TA0 = TA0; 
%               cal.TA1 = TA1; 
%               cal.TA2 = TA2; 
%               cal.TA3 = TA3; 
%
% OUTPUT: 
%   o2thermistorvolts    =   Oxygen raw, SBE 63 thermistor voltage [V]
%
%
% KiM MARTiNi 08.2018
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.

% make the matrix to fill
o2tempvolts = o2temp.*nan; 

% calculate ta
ta = 1./(o2temp+273.15);

% cycle through all the data for the root finder
for tt = 1:numel( o2temp )
    % define the ploynomial
    pol(1) = cal.TA3;
    pol(2) = cal.TA2;
    pol(3) = cal.TA1;
    pol(4) = cal.TA0-ta(tt);
    % use the root finder to get L
    L = roots( pol );
    % convert L to a voltage
    V = 3.3.*exp( L )./(100000+exp( L ));
    % add back in
    o2tempvolts(tt) = V(end);
end
