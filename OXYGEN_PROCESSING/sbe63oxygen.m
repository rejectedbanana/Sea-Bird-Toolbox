function [o2] = sbe63oxygen(o2phase, o2temp, cal, s, p)

% function [o2] = sbe63oxygen(o2phase, o2temp, cal, s, p)
%
% DESCRIPTION:
% Calculate oxygen concentration [ml/L] from Sea-Bird 63 Oxygen Sensor.
% Equations can be found in Appendix 1 of the SBE 63 manual
% https://www.seabird.com/oxygen-sensors/sbe-63-optical-dissolved-oxygen-sensor/family-downloads?productCategoryId=54627869933
%
% INPUTS: 
% ---------
% o2phase: raw phase delay outbput from SBE 63
% o2temp: temperature from SBE 63 thermistor in degrees C
% cal: Calibration coefficients structure from SBE calibration sheet
%       e.g.    cal.A0 = A0; 
%               cal.A1 = A1; 
%               cal.A2 = A2; 
%               cal.B0 = B0; 
%               cal.B1 = B1; 
%               cal.C0 = C0; 
%               cal.C1 = C1; 
%               cal.C2 = C2; 
%               cal.E = E; 
% s: salinity from integrated CTD (SeaCAT, MircoCAT, WQM or ARGO CTD)
% p: pressure from integrated CTD (SeaCAT, MircoCAT, WQM or ARGO CTD)
%
% OUTPUTS:
% ---------
% o2: Oxygen concentration in ml/L
%
% KIM 01.2017
% Sea-Bird Scientific, Bellevue WA

% If pressure is not defined, use constant reference pressure of zero
if nargin <5
    p = 0; 
end
% If salinity is not defined, use constant reference salinity of zero
if nargin < 4
    s = 0;
end

% convert the raw measured phase delay to volts
o2volts = o2phase./39.457071; 

% Stern-Volmer constant equation (Demas et al. 1999)
Ksv = cal.C0 + cal.C1*o2temp + cal.C2.*o2temp.*o2temp; 

% SALINITY CORRECTION FUNCTION
% convert temperature 
Ts = log( (298.15 - o2temp)./(273.15+o2temp)); 
% salinity correction coefficients (Benson and Krause, 1984)
solB0 = -6.24523e-3; 
solB1 = -7.37614e-3; 
solB2 = -1.03410e-2; 
solB3 = -8.17083e-3; 
solC0 = -4.88682e-7;
% Salinity Correction equation 
Scorr = exp( s.* ( solB0 + solB1.*Ts + solB2.*Ts.*Ts + solB3.*Ts.*Ts.*Ts )+ solC0.*s.*s);

% PRESSURE CORRECTION FUNCTION 
% convert temperature to Kelvin
Tk = o2temp+273.15; 
% pressure correction coefficient
E = cal.E;
% pressure correction equation
Pcorr = exp( E.*p./Tk ); 

% correction coeffients
a = cal.A0 + cal.A1.*o2temp + cal.A2.*o2volts.*o2volts;
b = cal.B0 + cal.B1.*o2volts;

% Calculate O2 from modified Stern-Vollmer equation
o2 = ( (a./b) - 1 )./Ksv.*Scorr.*Pcorr;


