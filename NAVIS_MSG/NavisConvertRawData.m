function [datout] = NavisConvertRawData(varin, datin)

% function  [datout] = NavisConvertRawData(varin, datin)
%
% DESCRIPTION:
% After converting Navis float hexadecimal data strings to decimal format,
% convert to real units.
%
% INPUT:
%   varin    =   variable name
%   datin    =   decimal data
%
% OUTPUT: 
%   datout   =   data output in real units such as pressure, temperature or
%                oxygen volts.
%
%
% KiM MARTiNi 11.2016
% Sea-Bird Scientific 
% kmartini@seabird.com

switch varin
    % general
    case 'Nsamples'
        datout = datin;
        %SBE 41cp
    case 'p' %pressure
        for dd = 1:length(datin) % one scan at a time to get conversion right
            datout(dd,1) = hextop(datin(dd));
        end
    case 't' %temperature
        for dd = 1:length(datin) % one scan at a time to get conversion right
            datout(dd,1) = hextot(datin(dd));
        end
    case 's' %salinity
        for dd = 1:length(datin) % one scan at a time to get conversion right
            datout(dd,1) = hextos(datin(dd));
        end
    case 'psal' %salinity
        for dd = 1:length(datin) % one scan at a time to get conversion right
            datout(dd,1) = hextos(datin(dd));
        end
        % SBE 63
    case 'O2ph' % oxygen phase
        datout = (datin./100000.0)-10.0;
    case 'O2tV' % oxygen temperature
        datout = (datin./1000000.0)-1.0;
    % MCOMS/ECO
    case 'Fl' % fluorometer
        datout = datin-500;
    case 'Bb' % backscatter
        datout = datin-500;
    case 'Cdm' % CDOM
        datout = datin-500;
    case 'Ntu'
        datout = datin-500;
    case 'Bb' % backscatter
        datout = datin-500;
    case 'Bb2' % backscatter 2
        datout = datin-500;
    % pH
    case 'phV'
        datout = datin./1000000.0 - 2.5; 
    case 'phT'
        for dd = 1:length(datin) % one scan at a time to get conversion right
            datout(dd,1) = hextot(datin(dd));
        end
    % pH4
    case 'phVrs'
        datout = datin./1000000.0 - 2.5; 
    case 'phVk'
        for dd = 1:length(datin) % one scan at a time to get conversion right
            datout(dd,1) = hextot(datin(dd));
        end    
    %CRV
    case 'Ccounts'
        datout = datin-200;
    case 'Cbeam'
        datout = datin./1000.0-10;
    % tilt
    case 'tilt'
        datout = datin./10;
    case 'azimuth'
        datout = datin*1.4; 
    case 'tiltsd'
        datout = datin./100;
    % OCR (double check this, I have *1500 in another script)
    case 'ch1'
        datout = datin*1024 + 2013265920;
    case 'ch2'
        datout = datin*1024 + 2013265920;
    case 'ch3'
        datout = datin*1024 + 2013265920;
    case 'ch4'
        datout = datin*1024 + 2013265920;
    % PAR
    case 'par1'
        datout = datin; 
    case 'par2'
        datout = datin; 
    case 'par3'
        datout = datin; 
    case 'parV'
        datout = datin; 
    otherwise 
        datout = datin; 
    
end