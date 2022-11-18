function [vars, hexstr] = NavisPayload2Hex(payload)

% function [hexstr] = NavisPayload2Hex(payload)
%
% DESCRIPTION:
% For a Navis payload, find the variable names and the data convention
% to parse the continous profiling hexadecimal string. 
%
% INPUT:
%   payload =   {'sbe41cp', 'sbe63', 'FlBbCd'}
%
% OUTPUT: 
%   vars    =   {'p'    's'    't'    'Nsamples'    'O2phase'    'O2TempVolts'
%               'Nsamples'    'Fl' 'Bb'    'Cd'    'Nsamples'}
%
%   hexstr  =   '%04x%04x%04x%02x%06x%06x%02x%06x%06x%06x%02x'
%
% KiM MARTiNi 11.2016
% Sea-Bird Scientific 
% kmartini@seabird.com

% Make dummy matrices to fill 
vars = {}; 
hexstr = []; 

% find all the variables associated with the sensors
for pp = 1:length( payload )
    vars = [vars, NavisSensor2vars(payload{pp})]; 
end

% now convert to the approporate hexadecimal format
for vv = 1:length( vars )
    hexstr = [hexstr, Navisvar2hexfmt(vars{vv})];
end



















