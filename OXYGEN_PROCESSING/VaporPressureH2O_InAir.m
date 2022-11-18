function [pH2O] = VaporPressureH2O_InAir( AirT, method )
 
% function [pH2O] = VaporPressureH2O_InAir( AirT, method )
%
% DESCRIPTION:
% Calculate the Saturated Vapor Pressure of Water in mbar from 
%
% INPUT:
%   AirT            =   Air temperature at 100% relative humidity [degrees Celsius]
%
% OUTPUT: 
%   pH2O            =  Vapor pressure of water in air [mbar]
%
%
% KiM MARTiNi 06.2021
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.

% set the default method for calculating the water vapor pressure
if nargin < 2
    method = 'Tetens'; 
end

% TEMPERATURE DEFINITIONS
% Air tempeature in Celsius
TC = AirT; 
% Convert the air temperature to Kelvin
TK = TC_to_TK(TC); 

switch lower( method )
    case 'tetens'
        % Tetens Equation (also used in Meterology )
        % https://en.wikipedia.org/wiki/Tetens_equation
        pH2O = 0.61078.*exp( 17.27.*TC./(TC+237.3)); % kPa
        pH2O = pH2O.*10; % Convert kPa to mbar
    
    case 'aanderaa'
        % Equation 9 in Johnson et al. 2015 JTECH paper taken from Aanderaa
        % manual, page 53
        % https://www.aanderaa.com/media/pdfs/oxygen-optode-4330-4835-and-4831.pdf
        pH2O = exp( 52.57-(6690.90./TK)-4.681.*log( TK )); % mbar

    case 'magnus'
        % Magnus Equation (used in Meterology)
        % https://en.wikipedia.org/wiki/Clausius%E2%80%93Clapeyron_relation#August-Roche-Magnus_approximation
        pH2O = 0.61094.*exp( 17.625.*TC./(TC+243.04)); % kPa
        pH2O = pH2O.*10; % Convert kPa to mbar

    case 'buck'
        % Buck Equation
        % https://en.wikipedia.org/wiki/Arden_Buck_equation
        pH2O = 0.61121.*exp( (18.678-(TC./234.5)).*(TC./(257.14+TC)));
        pH2O = pH2O.*10; % Convert kPa to mbar
        
    case 'august'
        % August Equation
        % https://en.wikipedia.org/wiki/Vapour_pressure_of_water#Approximation_formulas
        pH2O  = exp( 20.386-5132./TK); % mmHg
        pH2O = pH2O.*1.33322; % Convert mmHg to mbar
        
    case 'antoine'
        % Antoine Equation (1-100C)
        % https://en.wikipedia.org/wiki/Antoine_equation
        pH2O = 10.^(8.07131-(1730.63)./(233.426+TC)); % mmHg
        pH2O  = pH2O.*1.33322; % Convert mmHg to mbar
        
    case 'gill'
        % Gill/AOMIP in air
        % https://www2.whoi.edu/site/aomip/data/atmospheric-forcing-data/humidity/
        pH2O = 10.^((0.7859+0.03477.*TC)./(1.0+0.00412.*TC)+2); % Pa
        pH2O = pH2O./100; % Pa to hPa
        
    case 'wagnerandp'
        % Wagner and Pruss [2002]
        a1 = -7.85951783;
        a2 = 1.84408259;
        a3 = -11.7866497;
        a4 = 22.6807411;
        a5 = -15.968719;
        a6 = 1.80122502;
        Tc = 647.096; %K
        Pc = 22.064; % MPa
        temp_mod = 1-TK./Tc;
        wagner = a1*temp_mod +a2*temp_mod.^1.5+a3*temp_mod.^3+a4*temp_mod.^3.5+a5*temp_mod.^4+a6*temp_mod.^7.5;
        pH2O = Pc.*exp( wagner.*Tc./TK ); 
        pH2O = pH2O*10000; %mPa to mbar
end % switch


end %function

