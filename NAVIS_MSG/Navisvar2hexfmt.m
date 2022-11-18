function [hexfmt] = Navisvar2hexfmt(varin)

% function [hexfmt] = Navisvar2hexfmt(varin)
%
% DESCRIPTION:
% Find the hexadecimal format for known variables output by sensor pyaload
% on the Sea-Bird NAVIS floats.
%
% INPUT:
%   varin    =   variable name
%
% OUTPUT: 
%   hexfmt    =  variable hexadecimal format
%
%
% KiM MARTiNi 11.2016
% Sea-Bird Scientific 
% kmartini@seabird.com


switch varin
    % general
    case 'Nsamples'
        hexfmt = '%02x';
    %SBE 41cp
    case 'p'
        hexfmt = '%04x';
    case 't'
        hexfmt = '%04x';
    case 's'
        hexfmt = '%04x';
    case 'psal'
        hexfmt = '%04x';
    case 'NsamplesCTD'
        hexfmt = '%02x';
    % SBE 63 
    case 'O2ph'
        hexfmt = '%06x'; 
    case 'O2tV'
        hexfmt = '%06x';
    case 'NsamplesO2'
        hexfmt = '%02x';
    % MCOMS/ECO
    case 'Fl'
        hexfmt = '%06x';
    case 'Bb'
        hexfmt = '%06x';
    case 'Cdm'
        hexfmt = '%06x';
    case 'Ntu'
        hexfmt = '%06x';
    case 'Bb'
        hexfmt = '%06x';
    case 'Bb1'
        hexfmt = '%06x';
    case 'Bb2'
        hexfmt = '%06x';
    case 'Bb3'
        hexfmt = '%06x';
    case 'NsamplesMCOMS'
        hexfmt = '%02x';
    case 'NsamplesECO'
        hexfmt = '%02x';
    % pH
    case 'phV'
        hexfmt = '%06x';
    case 'phT'
        hexfmt = '%04x';
    case 'NsamplespH'
        hexfmt = '%02x';
    % pH4
    case 'phVrs'
        hexfmt = '%06x';
    case 'phVk'
        hexfmt = '%04x';
    case 'phIb'
        hexfmt = '%04x';
    case 'phIk'
        hexfmt = '%04x';
    case 'NsamplespH4'
        hexfmt = '%02x';
    %CRV
    case 'Ccounts'
        hexfmt = '%04x';
    case 'Cbeam'
        hexfmt = '%06x';
    case 'CRV'
        hexfmt = '%06x';
    case 'BeamC'
        hexfmt = '%06x';
    case 'NsamplesCRV'
        hexfmt = '%02x';
    % tilt
    case 'tilt'
        hexfmt = '%02x';
    case 'azimuth'
        hexfmt = '%02x';
    case 'tiltsd'
        hexfmt = '%02x';
    case 'Nsamplestilt'
        hexfmt = '%02x';
    % OCR
    case 'ch1'
        hexfmt = '%06x';
    case 'ch2'
        hexfmt = '%06x';
    case 'ch3'
        hexfmt = '%06x';
    case 'ch4'
        hexfmt = '%06x';
    case 'NsamplesOCR'
        hexfmt = '%02x';
    % OCRI
    case 'Ich1'
        hexfmt = '%06x';
    case 'Ich2'
        hexfmt = '%06x';
    case 'Ich3'
        hexfmt = '%06x';
    case 'Ich4'
        hexfmt = '%06x';
    case 'NsamplesOCRI'
        hexfmt = '%02x';
    % OCRR
    case 'Rch1'
        hexfmt = '%06x';
    case 'Rch2'
        hexfmt = '%06x';
    case 'Rch3'
        hexfmt = '%06x';
    case 'Rch4'
        hexfmt = '%06x'; 
    case 'NsamplesOCRR'
        hexfmt = '%02x';
    % PAR
    case 'par1'
        hexfmt = '%06x';
    case 'par2'
        hexfmt = '%02x';
    case 'par3'
        hexfmt = '%02x';
    case 'parV'
        hexfmt = '%06x';
    case 'NsamplesPAR'
        hexfmt = '%02x';
    % SNARF
    case 'snarf1'
        hexfmt = '%02x';
    case 'snarf2'
        hexfmt = '%02x';
    
end