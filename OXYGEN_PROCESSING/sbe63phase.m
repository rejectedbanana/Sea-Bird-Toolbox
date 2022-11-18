function [o2phase] = sbe63phase( o2, o2temp, cal, s, p )
 
% function [o2phase] = sbe63phase( o2, o2temp, cal, s, p )
%
% DESCRIPTION:
% Backout phase delay as measured by the Sea-Bird 63 Oxygen Sensor from 
% oxygen concentration [ml/L].
% Equations can be found in Appendix 1 of the SBE 63 manual
% https://www.seabird.com/oxygen-sensors/sbe-63-optical-dissolved-oxygen-sensor/family-downloads?productCategoryId=54627869933
%
%
% INPUT:
% o2: oxygen concentration in ml/l
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
% OUTPUT: 
% o2phase: raw phase delay outbput from SBE 63
%
%
% KiM MARTiNi 08.2018
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.

% make the matrix to fill
o2phase = o2.*nan; 

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

% reorganize the Stern-Vollmer equation
SV = (o2.*Ksv./Scorr./Pcorr)+1;

% now use the root solver on each data point
for tt = 1:numel(o2)
    
    % define the polynomial
    pol(1) = cal.A2;
    pol(2) = -1.*cal.B1.*SV(tt);
    pol(3) = cal.A0+cal.A1.*o2temp(tt) - cal.B0.*SV(tt);
    
    
    % use the root finder to get o2volts
    o2volts = roots( pol );
    
    % convert to phase
    o2phase(tt) = o2volts(2).*39.457071;
end %tt