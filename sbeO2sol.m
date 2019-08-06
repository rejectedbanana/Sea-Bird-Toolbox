function [oxsol] = sbeO2sol( s, t )
 
% function [oxsol] = sbeO2sol( s, t )
%
% DESCRIPTION:
% Oxsol(T,S) = oxygen saturation value = volume of oxygen gas at 
% standard temperature and pressure conditions (STP) absorbed from 
% humidity-saturated air at a total pressure of one atmosphere, per unit
% volume of the liquid at the temperature of measurement (ml/l).
%
% Described in Sea-Bird Application Note 64, Appendix Z
% https://www.seabird.com/asset-get.download-en.jsa?id=54627861706
%
% INPUT:
%   s            =   practical salinity [ ]
%   t            =   ITS-90 temperature [degreeC]
%
% OUTPUT: 
%  oxsol            =   oxygen saturation value [ml/l]
%
% REFERENCE:
% Garcia and Gordon (1992) "Oxygen solubility in seawater: Better fitting
% equations", Limnology & Oceanography, vol 37(6), p1307-1312.
%
% KiM MARTiNi 07.2018
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.

% convert t to scaled temperature
Ts = log( (298.15-t)./(273.15+t) );

% define the solubility terms
% temperature constants
A0 =  2.00907;
A1 =  3.22014;
A2 =  4.0501;
A3 =  4.94457;
A4 = -0.256847;
A5 =  3.88767;
% salinity constants
B0 = -0.00624523;
B1 = -0.00737614;
B2 = -0.010341;
B3 = -0.00817083;
C0 = -0.000000488682;

% multiply out Ts
Ts2 = Ts.*Ts; 
Ts3 = Ts.*Ts.*Ts; 
Ts4 = Ts.*Ts.*Ts.*Ts; 
Ts5 = Ts.*Ts.*Ts.*Ts.*Ts; 

% calculate the salinity dependence
scorr = s.*( B0 + B1.*Ts + B2.*Ts2 + B3.*Ts3) + C0.*s.*s;
% calculate the temperature dependence
tcorr = A0 + A1.*Ts + A2.*Ts2 + A3.*Ts3 + A4.*Ts4 + A5.*Ts5;
% calculate oxygen solubility
oxsol = exp( scorr + tcorr );