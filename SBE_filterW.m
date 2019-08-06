function [Sf] = SBE_filterW( S, time_constant, interval)

% [Sf] = SBE_filterW( S, time_constant, interval)
%
% DESCRIPTION:
% Recreates the anti-aliasing low-pass (single-pole) filter used in
% FilterW.exe which is part of the Sea-Bird Data Processing software. 
% The filter is run forward and backward so a phase-shift is not
% introduced into the data. 
%
% FILTER CHARACTERISTICS
% analog transfer function H(s) = 1./(1+(S/So))
% digital transform function H(z) = A(z^-1+1)./(1+Bz^-1)
%
% INPUTS:
% S = data to be filtered, best if a vector
% time =  constant that sets the filter cutoff [s]
% interval = sampling interval [s]
%
% OUTPUTS:
% Sf = filtered vector
%
% KiM MARTiNi 09.2016
% Sea-Bird Scientific 
% kmartini@seabird.com

if time_constant == 0
    Sf = S;
else   
    % define the SBE variables
    Gamma = time_constant;
    So = 1/Gamma;
    T = interval; % sample interval [s]
    
    % calculate the filter coefficients
    A = 1./(1+2./T./So); % numerator
    B = A.*(1-2./T./So); % denominator
    
    % now convert to matlab filter conventions
    b = [1, 1]*A;
    a = [1, B];
    
    % filter the data
    Sf = filtfilt( b, a, S);
end


% % if you want, uncomment the following code to filter the data 
% % using the algorithm in the Sea_Bird Data Processing Software manual
% % make an empty vector
% Sff = S.*nan;
% % fill in the first value
% Sff(1) = S(1);
% % run the filter forwards
% for ss = 2:length(Sf)
%     Sff(ss) = A.*(S(ss)+S(ss-1)) - B.*Sff(ss-1);
% end
% % run the filter backwards
% Sfb = Sff;
% for ss = length( Sfb )-1:-1:1
%     Sfb(ss) = A.*(Sff(ss) + Sff(ss+1)) - B.*Sfb(ss+1);
% end
% Sff = Sfb;