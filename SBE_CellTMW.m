function [CC] = SBE_CellTMW( C, T, P, alpha, tauCTM, interval)
 
% function [CC] = SBE_CellTMW( C, T, P, alpha, tauCTM, interval)
%
% DESCRIPTION:
% Recreates the CellTMW.exe program in Sea-Bird Data Processing Software
% for applying the cell thermal mass correction for Sea-Bird CTDs. The code
% applies the recursive filter detailed in Lueck 1990 where conductivity
% is corrected.
%
% INPUT:
% C = conductivity vector [S/m]
%           If Conductivity units are not S/m the correction will
%           not work properly. Convert to S/m before inputing conductivity
%           via the following formulas
%                   C [mS/cm] / 10.0 = C [S/m]
%                   C [uS/cm] / 10000.0 = C [S/m] 
% T = temperature vector [degrees C]
% P = pressure vector [dbar]
% alpha = Thermal anomaly amplitude [s]
% tauCTM = 1/beta = Thermal anomaly response time [s]
% interval = sampling interval [s]
%            e.g.   SBE 911plus (24 Hz): interval = 1./24; 
%                   SBE 25plus (16 Hz): interval = 1./16; 
%                   SBE 19plus V2 (4 Hz): interval = 1/4; 
%                   SBE 49 Fast Cat (16 Hz): interval = 1/16; 
%                   SBE GPCTD (1 Hz): interval = 1; 
%
% OUTPUT: 
% CC = conductivity vector corrected for cell thermal mass [S/m]
%
% TYPICAL CORRECTIONS BY INSTRUMENT:
%
% SBE 9plus with TC duct and 3000 rpm pump 
% alpha = 0.03; tauCTM = 7.0
%
% SBE 19plus or 19plus V2 with TC duct and 2000 rpm pump
% alpha = 0.04; tauCTM = 8.0
%
% SBE 19 (not plus) with TC duct and 2000 rpm pump
% alpha = 0.04; tauCTM = 8.0
%
% SBE 19 (not plus) with no pump, moving at 1 m/sec
% alpha = 0.042; tauCTM = 10.0
%
% SBE 25 or 25plus with TC duct and 2000 rpm pump
% alpha = 0.04; tauCTM = 8.0
%
% SBE 49 with TC duct and 3000 rpm pump
% alpha = 0.04; tauCTM = 7.0
%
% COMMENT: 
%
% KiM MARTiNi 11.2017
% Sea-Bird Scientific 
% kmartini@seabird.com

if alpha == 0 || tauCTM == 0
    CC = C; 
else
    % define the inputs
    ds = interval;
    TT = T;
    CC = C;
    PP = P;
    
    % calculate the size of the pressure vector
    % [ d1, d2 ] = size( PP );
    % initialize ctm
    ctm = TT*0;
    % find the good data
    ig = find(~isnan(T+C+P));
    
    if length(ig)>5
        if abs(alpha)>1e-10 || abs(tauCTM)>1e-7
            
            % Sea-Bird Data Processing ctm algorithm
            % define beta
            beta = 1./tauCTM;
            
            % define and b coefficients
            a = 2.*alpha./(ds*beta+2);
            b = 1-(2.*a./alpha);
            
            % Sea-Bird approximation of gradient of conductivity with temperature
            dCdT = 0.1.*(1+0.006.*(TT-20));
            
            % calculate dT
            dT = TT;
            dT(2:end) = diff( TT );
            dT(1) = dT(2);
            
            % compute corrections
            for cc = 2:length( CC )
                ctm(cc) = -1.0.*b.*ctm(cc-1) + a.*dCdT(cc).*dT(cc);
            end
        end
        % add the correction
        CC = CC+ctm;
    end
end
