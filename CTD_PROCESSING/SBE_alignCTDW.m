function [Sa] = SBE_alignCTDW( S, advance, interval )
 
% function [Sa] = SBE_alignCTDW( S, advance, interval )
%
% DESCRIPTION:
% Recreates the AlignCTDW.exe program in Sea-Bird Data Processing Software
% for aligning data. The code advances the input data vector in time by 
% the advance value using linear interpolation.
%
% INPUT:
% S = data to be aligned, must be a vector
% advance = advance value [s]
%           See instrument manuals for suggested advance times
% interval = sampling interval [s]
%            e.g.   SBE 911plus (24 Hz): interval = 1./24; 
%                   SBE 25plus (16 Hz): interval = 1./16; 
%                   SBE 19plus V2 (4 Hz): interval = 1/4; 
%                   SBE 49 Fast Cat (16 Hz): interval = 1/16; 
%                   SBE GPCTD (1 Hz): interval = 1; 
%
% OUTPUT: 
% Sa = advanced data vector
%
% COMMENT: Linear interpolation is used to advance the data rather than
% other interpolation techniques because no matter what, you really don't
% know what's going on between samples. KISS.
% 
% KiM MARTiNi 09.2017
% Sea-Bird Scientific 
% kmartini@seabird.com

if advance == 0
    Sa = S;
else
    % get the size of the vector
    [ d1, ~ ] = size( S );
    
    % make a time vector in seconds based upon the sampling interval
    time = cumsum( ones( d1, 1 ).*interval );
    
    % Align the data with linear interpolation
    Sa = interp1( time - advance, S, time );
end