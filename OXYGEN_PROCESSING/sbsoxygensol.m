function [O2solmLL, O2soluM] = sbsoxygensol( CTDT, CTDPSAL, eflag )
 
% function [O2solmLL, O2soluM] = sbsoxygensol( CTDT, CTDPSAL, eflag)
%
% DESCRIPTION:
% O2sol(T,S) = oxygen saturation value in seawater 
%            = volume of oxygen gas absorbed from humidity-saturated air 
%              in seawater with practical salinity S and temperature T at
%              a total pressure of one atmosphere (atmospheric+pH2O)
%              per unit volume of the liquid (ml/l).
%
% Uses Benson and Krause refit of Garcia and Gordon (1992)
%
% Described in Sea-Bird Application Note 64, Appendix Z
% https://www.seabird.com/asset-get.download-en.jsa?id=54627861706
%
% And Processing Argo OXYGEN data at the DAC Level, Page 10
% https://archimer.ifremer.fr/doc/00287/39795/59750.pdf
%
% INPUT:
%   CTDPSAL            =   practical salinity [PSU]
%   CTDT            =   ITS-90 temperature [degreeC]
%   eflag: Used to define the processing algorith
%       e.g.    eflag = 'sbs' uses Sea-Bird Algorithm. Use to compare
%                       calibraton data.
%               eflag = 'argo' uses algorithm used by the BGC-Argo DAC
%
% OUTPUT: 
%  O2solmLL            =   oxygen saturation value [ml/l]
%  O2soluM            =   oxygen saturation value [uM]=[micromoles/L]=[umoles/L]
%
% REFERENCE:
% Garcia and Gordon (1992) "Oxygen solubility in seawater: Better fitting
% equations", Limnology & Oceanography, vol 37(6), p1307-1312.
%
% KiM MARTiNi 07.2018
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% Edited 05.2021 to calculate solubility in uM and use the different
% moles/liter conversion
%
% DISCLAIMER: Software is provided as is.

% If eflag is not defined, use the Argo DAC calculation
if nargin < 3
    eflag = 'argo';
end

% convert temperature to Kelvin
TK = TC_to_TK( CTDT ); 

% convert TC to scaled temperature
Ts = log( (298.15-CTDT)./(TK) );

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
scorr = CTDPSAL.*( B0 + B1.*Ts + B2.*Ts2 + B3.*Ts3) + C0.*CTDPSAL.*CTDPSAL;
% calculate the temperature dependence
tcorr = A0 + A1.*Ts + A2.*Ts2 + A3.*Ts3 + A4.*Ts4 + A5.*Ts5;

% COMPUTE OXYGEN SOLUBILITY [mL/L]
O2solmLL = exp( scorr + tcorr ); % [mL/L]

% CONVERT TO MOLAR DISSOLVED OXYGEN [uM]=[micromoles/L]=[umoles/L]
% define the moles per liter conversion
switch lower(eflag)
    case 'sbs'
        O2conv = 44.6600; % value used in Sea-Bird Software
    case 'argo'
        O2conv = 44.6596; % value used in ARGO Dac
end
% multiply by the moles per liter converion
O2soluM = O2solmLL.*O2conv; % uM or micromoles/L or umol/L

end

