function [TK] = TC_to_TK( TC )
 
% function [TK] = TC_to_TK( TC )
%
% DESCRIPTION:
% Convert temperature from Celsius to Kelvin
%
% INPUT:
%   TC            =   temperature in degrees Celsius
%
% OUTPUT: 
%   TK            =   temperature in degrees Kelvin
%
%
% KiM MARTiNi 06.2021
% Sea-Bird Scientific 
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.

TK = TC+273.15;