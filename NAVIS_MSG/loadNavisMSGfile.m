function [header, park, discrete, profile, footer] = loadNavisMSGfile( target_file, payload )

% function [header, park, discrete, profile, footer] = loadNavisMSGfile( target_file, payload )
%
% DESCRIPTION:
% Import all data from a single .msg file transmitted by a Sea-Bird NAVIS 
% floats into Matlab. Mostly able to handle incomplete .msg files and data
% streams, but the exception will always arise.
%
% INPUT:
%   target_file     =   NAVIS .msg file to be loaded into Matlab such as 
%                        target_file = 'C:\NAVIS\data\0322\0322.001.msg';
%   payload         =   cell containing list of sensors in the scientific
%                       payload on the NAVIS Float.
%                       e.g. for a BGCi float
%                         payload = {'sbe41cp', 'sbe63', 'mcoms'};
%                    For a list of possible sensors in the command line
%                    type:
%                    "help NavisSensor2vars"
%
% 
%
% OUTPUT: 
%   header          =   mission configuration from config.m
%   park            =   park data
%   discrete        =   discrete profiling data
%   profile         =   continous profiling data
%   footer          =   engineering data
%
% KiM MARTiNi 06.2017
% Sea-Bird Scientific
% kmartini@seabird.com
%
% DISCLAIMER: Software is provided as is.
 
% _______\\
% PRESET FLAGS
%%%%%%%%%%%%%%
% set all flags to zero until each part is flagged and exists
continousprofile = 0; 
footerind = 1; 

% ________\\
% OPEN THE FILE
%%%%%%%%%%%%%%%
fid = fopen( target_file ); 
fline = fgetl(fid);

% ________\\
% PARSE THE FIRST LINE TO GET THE FLOAT ID AND FIRMWARE REVISION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get the float id
[s1, s2] = regexp( fline, '(?<=Npf\().*(?=\))');
header.Npf = fline( s1:s2 ); 
% get the Firmware Revision
[s1, s2 ] = regexp( fline, '(?<=FwRev ).*(?=:)');
header.FwRev = fline( s1:s2 );
% move to next line
fline = fgetl(fid);
% define the platform type
header.platform_type = 'NAVIS_A'; 


% ________\\
% PARSE THE HEADER DATA WHICH IS THE OUTPUT FROM CONFIG.C IN FIRMWARE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while regexp( fline(1), '\$') ==1 && length( fline )>1
    % find the parentheses
    p1 = regexp( fline, '('); p2 = regexp( fline, ')');
    s1 = regexp( fline, '['); s2 = regexp( fline, ']');
    % get the variable name
    h_var = strtrim(fline(2:p1-1));
    % data inside the parentheses
    h_data = fline(p1+1:p2-1);
    % units inside the square bracket
    h_units = fline(s1+1:s2-1);
    % add to header, using correct format
    [header.(h_var), status] = str2num(h_data);
    if status == 0
        header.(h_var) = h_data;
    end
    % add units to the header
    units.(h_var) = h_units;
    fline = fgetl(fid);
end
header.units = units; 
clear units
% grab the next line
fline = fgetl(fid); 


% ________\\
% GRAB THE PARKED DATA
%%%%%%%%%%%%%%%%%%%%%%
% if it's a header with variables, pull the variable
if regexp( fline, '\$ Profile') 
    % do nothing if no park data
    vars = {'time', 'p', 't', 's'};
elseif regexp( fline(1), '\$')
    % pull the next data for the observations
    parkvarline = strsplit(fline);
    vars = parkvarline(2:end);
    % grab the next line
    fline = fgetl(fid);
elseif regexp(fline, 'Date')
    % pull the variable names from the data
    vars = strsplit(fline); 
    vars = vars{3:end};
    % grab the next line
    fline = fgetl(fid); 
else
    vars = {'time', 'p', 't', 's'};
end
% make sure salinity is psal
cind = strmatch('s', vars); 
vars{cind} = 'psal'; 
% add the variables to the parked structure
park.vars = vars; 
% parse the parked data for vanilla floats (only CTD)
pctr = 1;
while regexp( fline, 'ParkPts', 'once')  
   parkline = strsplit( fline ); 
   % pull the time
   park.time(pctr) = datenum( strcat(parkline{2:5}), 'mmmddyyyyHH:MM:SS' );
   % vanilla float variables
   park.p(pctr) = str2num(parkline{8});
   park.t(pctr) = str2num(parkline{9});
   park.psal(pctr) = str2num(parkline{10});
   % advance forward
   fline = fgetl(fid); 
   pctr = pctr+1; 
end
% parse the park data for a float with additional sensors 
pctr = 1; 
while ischar( fline ) && isempty( regexp(fline, '<EOT>', 'once')) && length( fline ) > 7 && ~isempty(regexp(fline(1:7), 'ParkObs')) 
   parkline = strsplit( fline ); 
   % pull the time
   park.time(pctr) = datenum( strcat(parkline{2:5}), 'mmmddyyyyHH:MM:SS' );
   % pull the variables
   for vv = 2:length( parkline )-4 
       park.(vars{vv})(pctr) = str2num(parkline{vv+4});
   end
   % advance forward 
   fline = fgetl(fid); 
   pctr = pctr+1; 
end

if ischar( fline ) && isempty( regexp(fline, '<EOT>', 'once')) && ~isempty( regexp( fline, '\$'))
    % get the termination line that follows the last park data
    stringin = strsplit( fline );
    % parse the termination date
    profendline = fline;
    c1 = regexp( profendline, ':');
    profenddatestr = profendline(c1(1)+1:end);
    park.terminated = strtrim(profenddatestr);
    park.terminated_datenum = datenum( profenddatestr, 'dddd mmm dd HH:MM:SS yyyy');
    fline = fgetl(fid);
    % assign the profile info
    header.Profile =  stringin{3};
    park.Profile = stringin{3};
    
    % ________\\
    % GRAB THE DISCRETE DATA
    %%%%%%%%%%%%%%%%%%%%%%%%
    % find the number of discrete samples
    stringin = strsplit( fline );
    discrete.samples = str2num( stringin{end} );
    fline = fgetl( fid );
    
    % get the discrete data variables
    stringin = strsplit( fline );
    discrete.vars = stringin(2:end);
    % make sure salinity is psal
    cind = strmatch('s', discrete.vars); 
    discrete.vars{cind} = 'psal';
    % move onto the next line
    fline = fgetl( fid );
else
    stringin = strsplit( target_file, '\'); 
    % assign the profile info
    header.Profile =  stringin{end}(1:end-4);
    park.Profile = stringin{end}(1:end-4);
end

% if discrete data exists, grab the data
if exist('discrete', 'var')
    
    % make the discrete structure to populate
    for vv = 1:length(discrete.vars);
        discrete.(discrete.vars{vv}) = [];
        discrete.park.(discrete.vars{vv}) = [];
    end  
    
    % reorder the fields
    discrete = orderfields( discrete, ['samples', 'vars', discrete.vars, 'park']);
    
    % now go through the discrete data
    for dd = 1:discrete.samples
        % get out of the loop if the end of transmission 
        if  ~isstr( fline )|| ~isempty( regexp(fline, '<EOT>', 'once'))
            break
        else
            stringin = strsplit( fline );
            % mark if the first sample is a park sample
            if regexp( stringin{end}, 'Sample)')
                discrete.ParkSample = dd;
            end
            
            % find the number of variables in the line (takes out truncated
            % lines)
            nvars = min( [length(stringin), length( discrete.vars )]);
            % cycle through the variables
            for vv = 1:nvars
                discrete.(discrete.vars{vv}) = [discrete.(discrete.vars{vv}); str2num(stringin{vv})];
            end %vv
            % grab the next line
            fline = fgetl(fid );
        end
    end
else
    discrete = [];
end


% _______\\
% WORK TO THE END OF THE FILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while ~feof( fid )
    
    % _______\\
    % ADVANCE TO THE NEXT SECTION
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while ischar( fline )...
            && isempty( regexp(fline, '#', 'once')) ... % continuous profiling or gps
            && isempty( regexp(fline, 'NpfFwRev', 'once'))... % start of footer
            && isempty( regexp(fline, '=', 'once'))...
            && isempty( regexp(fline, '<EOT>', 'once'))
        fline = fgetl(fid);
    end
    
    % ______\\
    % GRAB THE CONTINUOUS PROFILING DATA
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % check whether the continuous profile was started or not
    if ischar( fline ) && ~isempty( regexp( fline, 'Sbe41cpSerNo', 'once')) % continous profile started        
        % grab the start of the profile and the serial number
        stringin = fline;
        s1 = regexp( stringin, 'S');
        % find the start time
        profile.start = strtrim( stringin(2:s1-1) );
        if ~isempty( profile.start)
        profile.start_datenum = datenum( profile.start, 'mmm dd yyyy HH:MM:SS');
        else
            profile.start_datenum = []; 
        end
        stringin = strsplit( stringin );
        for ss = 6:8
            infoin = stringin{ss};
            s1 = regexp( infoin, '['); s2 = regexp( infoin, ']');
            profile.(infoin(1:s1-1)) = str2num( infoin(s1+1:s2-1));
        end %ss
        % advance to the next line
        fline = fgetl( fid );
        % advance through the lines before the hex data
        while ischar( fline ) && (~isempty(regexp( fline, 'ser', 'once')) || isempty(fline) ) 
            if regexp( fline, 'ser') % if there is a serial # string, just pull it into the structure
                profile.serialstr = fline;
                % parse the serial string
                % find the names
                serialnames = regexp( fline, '\w*:\>', 'match') ;
                % find the values
                serialvalues = regexp( fline, '\w*:\>', 'split');
                % take out the first value
                serialvalues = serialvalues(2:end);
                % cycle through the serial numbers
                for ss = 1:length( serialvalues )
                    serial = regexp( serialvalues{ss}, ',', 'split'); 
                    if length( serial ) > 1
                        profile.serialname{ss} = serial{1}(~isspace(serial{1}));
                        profile.serialnumber{ss} = strtrim(serial{2}); 
                        profile.serialvalue{ss} = []; 
                    elseif length( serial ) == 1
                        profile.serialname{ss} = serialnames{ss}(1:end-1);
                        profile.serialnumber{ss} = [];
                        profile.serialvalue{ss} = strtrim(serial{1});
                    else
                        profile.serialname{ss} = serial{1}(~isspace(serial{1}));
                        profile.serialnumber{ss} = [];
                        profile.serialvalue{ss} = [];
                    end
                end %ss
                
                fline = fgetl( fid );
            elseif isempty(fline) % skip empty lines
                fline = fgetl( fid );
            end
        end
        
        % figure out the hex string
        for pp = 1:length( payload )
            [p_vars{pp}, hexstr{pp}] = NavisPayload2Hex(payload{pp});
            % figure out the line length
            hexlength(pp) = sum( str2double(regexp( hexstr{pp}, '[0-9]', 'match')));
        end
        
        % figure out which p_var has the longest length
        maxvars = find( hexlength == nanmax( hexlength ) ); 
        % preallocate the array
        for vv = 1:length( p_vars{maxvars} )
            hex.(p_vars{maxvars}{vv}) = nan( profile.NBin, 1 );
        end
        
        % start the counter
        ctr = 1;
        while ischar( fline ) ...
            && (  ~feof(fid) || isempty(regexp(fline,'<EOT>','once')) ) ...
            && isempty( regexp( fline, '#', 'once'))...
            && (ctr <= profile.NBin) ...
            && isempty( regexp( fline, 'Resm', 'once'))...
            && isempty( regexp( fline, '=', 'once'))
            % figure out what kind of hex string it is
            if ~isempty( regexp( fline, '[', 'once')) 
                % find the number of bins in the repeat line
                s1 = regexp( fline, '[');
                s2 = regexp( fline, ']');
                bins = str2num( fline( s1+1:s2-1 ) );
                % now crop to just the data string
                fline  = fline( 1:s1-1 );
            elseif length( fline ) < nanmin( hexlength )
                % don't advance the counter if the line is truncated
                bins = 0; 
            else
                % default bin of length 1
                bins = 1;
            end
            
            % make sure the string length matches the known hex string length 
            % find the matching  hex indice
            hexind = find( length( fline ) == hexlength, 1);
            if ~isempty( hexind )
                % parse the string
                hexline = sscanf( fline, hexstr{hexind} );
                % cycle through the bins
                for bb = 1:bins
                    % only fill in data if CTD is not all zeros
                    if isempty(regexp(fline(1:14), '00000000000000', 'once'))
                        for vv = 1:length(p_vars{hexind})
                            hex.(p_vars{hexind}{vv})(ctr) = hexline(vv);
                        end
                        % advance the counter
                        ctr = ctr+1;
                    end
                end
            end
            % get the next line
            fline = fgetl(fid);
            
            % make sure the next line contains characters, otherwise break
            % out of loop
            if ~ischar( fline )
                break
            end
            
            % make sure 
        end
        
        % define the redline value for each variable nan those out
        for pp = 1:length( payload )
            hexcts = regexp( hexstr{pp}, 'x', 'split'); 
            for vv = 1:length( p_vars{pp} )
                hexct = str2num( hexcts{vv}(2:end) );
                % create the redline hex string
                redline = repmat( 'F', [1, hexct]); 
                % convert to a decimal number
                redline = hex2dec( redline );
                % now find the redline values and replace them with nans
                hex.(p_vars{pp}{vv})(hex.(p_vars{pp}{vv}) == redline) = nan; 
            end %vv
        end %pp
       
        % ________\\
        % CONVERT HEX DATA TO REAL DATA
        for vv = 1:length( p_vars{maxvars} )
            profile.(p_vars{maxvars}{vv}) = NavisConvertRawData(p_vars{maxvars}{vv}, hex.(p_vars{maxvars}{vv}));
            % and truncate the data
            profile.(p_vars{maxvars}{vv}) = profile.(p_vars{maxvars}{vv})(1:ctr-1);
        end
        
        
    % ________\\
    % GRAB THE GPS DATA
    %%%%%%%%%%%%%%%%%%%
    % check whether it is a GPS line
    elseif ischar( fline ) && ~isempty( regexp(fline, '# GPS fix obtained', 'once')) % GPS fix obtained
            % # GPS fix obtained in 68 seconds.
            % #          lon      lat mm/dd/yyyy hhmmss nsat
            % Fix:   90.9000 -64.4983 12/19/2016 194710   10
            % output the status
            profile.gps_status = fline;
            % skip the header line
            fline = fgetl( fid );
            fline = fgetl( fid );
            if ischar( fline )
                % split the string
                fixstr = strsplit(fline);
                try
                    profile.gps_datenum = datenum( [fixstr{4}, ' ',fixstr{5}], 'mm/dd/yyyy HHMMSS');
                    profile.n_gps_sat = str2num(fixstr{end});
                    profile.lon = str2num(fixstr{2});
                    profile.lat = str2num(fixstr{3});
                catch
                    profile.gps_datenum = nan;
                    profile.n_gps_sat = nan;
                    profile.lon = nan;
                    profile.lat = nan;
                end
            else
                profile.gps_datenum = nan;
                profile.n_gps_sat = nan;
                profile.lon = nan;
                profile.lat = nan;
            end
                
            % grab the next line
            fline = fgetl( fid );
            
            
    % ________\\
    % GRAB OUTPUT IF NO GPS FIX
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % check whether the float has gone to ice evasion mode
    elseif ischar( fline ) && ( ~isempty( regexp(fline, '# Ice evasion', 'once')) || ~isempty( regexp(fline, 'surface ice', 'once')) || ~isempty( regexp(fline, 'GPS fix failed', 'once')))
            % # Ice evasion initiated at P=19.0dbars.
            % Fix: GPS fix not available due to surface ice.
            
            % # Leads or break-up of surface ice detected.
            % Fix: GPS fix not available due to surface ice.
            
            % # Attempt to get GPS fix failed after 301s.
                        
            % output the status
            profile.gps_status = fline;
            % fill with nans
            profile.gps_datenum = nan;
            profile.n_gps_sat = nan;
            profile.lon = nan;
            profile.lat = nan;
            % grab the next line
            fline = fgetl( fid );
        
        
    % ________\\
    % PARSE THE DATA IN THE FOOTER
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif ischar( fline ) && ~isempty( regexp( fline, 'NpfFwRev', 'once'))
        while isempty( regexp( fline, '<EOT>', 'once') ) && ~feof(fid) && ~isempty( fline ) && ~isempty( regexp(fline, '=', 'once'))
                % split the string
                footerstr = strsplit( fline, '=');
                % find the alphanumeric characters in the label
                labelstr = footerstr{1};
                an_ind = isstrprop( labelstr, 'alphanum');
                footer(footerind).(labelstr(an_ind)) = footerstr{2};
                % grab the next line
                fline = fgetl( fid );
        end
        % advance the footer indice since one has already been parsed
        footerind = footerind+1;
        % grab the next line
        fline = fgetl( fid );
    
    % ________\\
    % SKIP ANY OTHER LINES
    %%%%%%%%%%%%%%%%%%%%%%   
    else 
        % grab the next line
        fline = fgetl( fid );
        
    end % if continuous profile, GPS or footer
    
end % while ~feof(fid)

% ________\\
% CLOSE THE FILE
%%%%%%%%%%%%%%%%
fclose(fid);


% ________\\
% FILL IN THE BLANK STRUCTURES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~exist('footer', 'var')
    footer = [];
end

if ~exist('profile', 'var')
    profile = [];
end
