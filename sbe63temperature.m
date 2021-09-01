function [o2temp] = sbe63temperature( o2tempvolts, cal )
 
% function [o2temp] = sbe63temperature( o2tempvolts, cal )
%
% DESCRIPTION:
% Calculate thermistor temperature [degreeC] from Sea-Bird 63 Oxygen Sensor.
% Equations can be found in Appendix 1 of the SBE 63 manual
% https://www.seabird.com/oxygen-sensors/sbe-63-optical-dissolved-oxygen-sensor/family-downloads?productCategoryId=54627869933
%
% INPUT:
%   o2thermistorvolts    =   Oxygen raw, SBE 63 thermistor voltage [V]
%   cal    =   Calibration coefficients structure from SBE calibration sheet
%       e.g.    cal.TA0 = TA0; 
%               cal.TA1 = TA1; 
%               cal.TA2 = TA2; 
%               cal.TA3 = TA3; 
%
% OUTPUT: 
%   o2temp    =   Oxygen Temperature, SBE 63 [ITS-90, deg C]
%
%
% KiM MARTiNi 01.2018
% Sea-Bird Scientific 
% kmartini@seabird.com

V = o2tempvolts; 

% convert volts to a logarithmic scale
L = log( 100000.*V./ (3.3-V) );

% calculate the coefficients
ta = cal.TA0 + cal.TA1.*L + cal.TA2.*L.*L + cal.TA3.*L.*L.*L;

% calculate temperature
o2temp = (1./ta) - 273.15;