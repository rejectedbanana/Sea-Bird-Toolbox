function [cal] = readSBScal( target_file )

% function [cal] = readSBScal( target_file )
%
% DESCRIPTION:
% Open and import a Sea-Bird Scientific .cal file into a structure.
%
% INPUT:
%   target_file =   variable description
%
% OUTPUT: 
%   cal         =   structure that contains all the calibration
%                   coefficients in the .cal file. 
%
%               SAMPLE CAL STRUCTURE:
%                 cal = 
%                     SERIALNO: 7615
%                     TCALDATE: '10-Nov-15'
%                          TA0: 1.3884e-05
%                          TA1: 2.8502e-04
%                          TA2: -3.3102e-06
%                          TA3: 1.7427e-07
%                     CCALDATE: '10-Nov-15'
%                           CG: -0.9878
%                           CH: 0.1500
%                           CI: -4.0295e-04
%                           CJ: 5.2407e-05
%                        CTCOR: 3.2500e-06
%                        CPCOR: -9.5700e-08
%                        WBOTC: -1.6196e-07
%                     PCALDATE: '12-Nov-15'
%                          PA0: -0.2411
%                          PA1: 0.1411
%                          PA2: 1.1570e-08
%                        PTCA0: -124.6589
%                        PTCA1: -0.5908
%                        PTCA2: 0.0225
%                        PTCB0: 102.6644
%                        PTCB1: -0.0050
%                        PTCB2: 0
%                        PTHA0: -99.0208
%                        PTHA1: 0.0406
%                        PTHA2: 1.2650e-06
%
%
% KiM MARTiNi 05.2017
% Sea-Bird Scientific 

% open the file
fid = fopen(target_file);

% go through until the end
while ~feof( fid )
    
    % grab the line
    fline = fgetl( fid );
    
    % determine if the line starts with set
    setind = regexp( fline(1:3), 'Set', 'once');
    
    % check if it's the calibration date or the cal value
    if ~isempty( regexp( fline, 'CALDATE', 'once') ) ||...
           ~isempty( regexp( fline, 'SERIALNO', 'once') )...
            || ~isempty(regexp( fline, 'INSTRUMENT_TYPE', 'once'))
        itype = strsplit( fline, '=');
        eval( ['cal.', itype{1}, '=''', itype{2}, ''';']);
    elseif ~isempty( setind )
        % numerical coefficient
        eval( ['cal.', fline(4:end), ';' ])
    else
        eval( ['cal.',fline, ';'] )
    end

end

% close the file
fclose( fid );
