function [vars] = NavisSensor2vars(sensor)

% function [vars] = NavisSensor2vars(sensor)
%
% DESCRIPTION:
% List of the data variables that are output by sensors on Navis floats.
%
% INPUT:
%   sensor  =   text string of sensor name 
%                   'sbe41cp'
%
% OUTPUT: 
%   vars    = cell with list of variables
%              {'p', 't', 's', 'Nsamples'}
%
% LIST OF POSSIBLE INPUT SENSORS:
%       'sbe41cp'
%       'sbe63'
%       'sbe63flip'
%       'FlBbCd'
%       'FlNtuBB2'
%       'FlBBBB2'
%       'BB1BB2BB3'
%       'mcoms'
%       'pH'
%       'CRover'
%       'CRV'
%       'tiltAzi'
%       'tilt2'
%       'tilt'
%       'OCR'
%       'PAR1'
%       'PARV'
%       'OCRR'
%       'OCRI'
%
% KiM MARTiNi 11.2016
% Sea-Bird Scientific 
% kmartini@seabird.com
        
switch sensor
    case 'sbe41cp'
        vars = {'p', 't', 'psal', 'NsamplesCTD'};
    case 'sbe63'
        vars = {'O2ph', 'O2tV', 'NsamplesO2'};
    case 'sbe63flip'
        vars = {'O2tV', 'O2ph', 'NsamplesO2'};
    case 'FlBbCd'
        vars = {'Fl', 'Bb', 'Cdm', 'NsamplesECO'};
    case 'FlNtuBb2'
        vars = {'Fl', 'Ntu', 'Bb2', 'NsamplesECO'};
    case 'FlBbBb2'
        vars = {'Fl', 'Bb', 'Bb2', 'NsamplesECO'};
    case 'Bb1Bb2Bb3'
        vars = {'Bb1', 'Bb2', 'Bb3'};
    case 'mcoms'
        vars = {'Fl', 'Bb', 'Cdm', 'NsamplesMCOMS'};
    case 'pH'
        vars = {'phV', 'phT', 'NsamplespH'};
    case 'pH4'
        % vars = {'phVrs', 'phVk', 'phIb','phIk', 'NsamplespH4'};
        vars = {'phVrs', 'NsamplespH'};
    case 'pHflip'
        vars = {'phT', 'phV', 'NsamplespH'};
    case 'CRover'
        vars = {'Ccounts', 'Cbeam', 'NsamplesCRV'};
    case 'CRV'
        vars = {'Cbeam', 'NsamplesCRV'};
    case 'CRV2'
        vars = {'CRV', 'BeamC', 'NsamplesCRV'};
    case 'tiltAzi'
        vars = {'tilt', 'azimuth'};
    case 'tiltsd'
        vars = {'tilt', 'tiltsd'};
    case 'tilt'
        vars = {'tilt'};
    case 'OCR'
        vars = {'ch1', 'ch2', 'ch3','ch4', 'NsamplesOCR'};
    case 'PAR1'
        vars = {'par1', 'par2', 'par3', 'NsamplesPAR'};
    case 'PARV'
        vars = {'parV', 'NsamplesPAR'};
    case 'OCRR' 
        vars = {'Rch1', 'Rch2', 'Rch3','Rch4', 'NsamplesOCRR'};
    case 'OCRI'
        vars = {'Ich1', 'Ich2', 'Ich3','Ich4', 'NsamplesOCRI'};
    case 'snarf'
        vars = {'snarf1', 'snarf2'};
        
end