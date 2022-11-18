function [sbeo2] = sbe43oxygen( t, s, p, oxV, interval, cal, varargin )
 
% function [sbeo2] = sbe43oxygen(t, s, p, oxV, interval, cal, .... )
%
% DESCRIPTION:
% Calculate oxygen concentration [ml/L] from Sea-Bird 43 Oxygen Sensor.
%
% Equations can be found in Sea-Bird Application Note 64
% https://seabird.hachuat.com/asset-get.download.jsa?id=53975654616
%
% INPUT:
%   t            =   ITS-90 temperature [degreeC]
%   s           = practical salinity [ ]
%   p           = pressure [dbar]
%   oxV         = oxygen sensor voltage [V]
%   cal             = calibration structure loaded with sbsReadCal.m                 
%                      e.g.  cal = 
%                                 INSTRUMENT_TYPE: 'SBE43'
%                                        SERIALNO: '0464'
%                                        OCALDATE: '21-Feb-18'
%                                             SOC: 0.4971
%                                         VOFFSET: -0.4902
%                                               A: -0.0036
%                                               B: 1.4145e-04
%                                               C: -1.9312e-06
%                                               E: 0.0360
%                                           Tau20: 1.3000
%
% OPTIONAL INPUTS:
% 
% OUTPUT: 
%   o2           =   Oxygen concentration [ml/l]
%
%
% KiM MARTiNi 07.2018
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.

% calculate time from the interval
% (assume constant sampling interval)
timeS = cumsum( ones( size( p ) ).*interval); 

% define the defaults and the default settings
defaultnames = {'taucorrection', 'taucorrectionwin',...
    'hysteresiscorrection', 'H'}; 
defaultvalues = {'off', 2,...
    'off', [-0.033, 5000, 1450]}; 

% apply the additional arguments if they have been included in the function
% line
if ~isempty( varargin )
    for vv = 1:length( varargin )
        if nansum( strcmp( varargin{vv}, defaultnames ) )>=1
            dum = varargin{vv+1}; 
            eval( [varargin{vv}, '= dum ;'])
        end %if 
    end % vv
end %if 

% assign values to defaults if they don't exist
for dd = 1:length( defaultnames )
    if ~exist( defaultnames{dd}, 'var')
        dum = defaultvalues{dd}; 
        eval( [defaultnames{dd}, '= dum ;']); 
    end %if
end %dd

% oxygen calibration coefficients
SOC = cal.SOC;
VOFFSET = cal.VOFFSET;
Tau20 = cal.Tau20;
A = cal.A;
B = cal.B;
C = cal.C;
E = cal.E;

% calculate the oxygen solubility
% oxsol = sbeO2sol( s, t );
[oxsol, ~] = sbsoxygensol( t, s, 'sbs' );

% calculate the temperature dependence term
tcorr = 1.0 + A.*t + B.*t.*t + C.*t.*t.*t;

% calculate the efolding pressure correction term
% convert temeprature to kelvin
K = t+273.15;
pcorr = exp( E.*p./K );

% calculate the tau correction
switch taucorrection
    case 'on'
        % calculate dV/dt
        dVdt = diff( oxV )./diff( timeS );
        dVdt(end+1) = dVdt(end); % make the same length
        dt = nanmean( diff( timeS )); 
        dVdt = boxcarsmooth( dVdt, floor( taucorrectionwin./dt )); 
        % calculate tau
        D1 = 1.92634e-004;
        D2 = -4.64803e-002;
        tau = Tau20.*exp( D1.*p + D2.*(t-20));
        % calculate the tau correction
        taucorr = tau.*dVdt;
    otherwise
        taucorr = 0;
end %switch

%  apply hysteresis correction 
switch hysteresiscorrection
    case 'on'
        % calculate the coefficient D
        D = 1 + H(1).*( exp(p./H(2)) - 1 ); 
        % calculate coefficient C
        C = exp( -1.*diff( timeS )./H(3) ); C = [C(1);C];  
        % add the offset to find ox new
        oxoff = oxV+VOFFSET;
        oxnew = oxoff; 
        % now cycle thought oxnew
        for ii = 2:length( oxnew )
            oxnew(ii) = ( oxoff(ii) - oxoff(ii-1).*C(ii) + oxnew(ii-1).*C(ii).*D(ii) )./D(ii);
        end %ii
        oxV = oxnew - VOFFSET; 
end %switch


% calculate oxygen concentration with all corrections
sbeo2 = SOC.*(oxV + VOFFSET + taucorr).*tcorr.*pcorr.*oxsol;

