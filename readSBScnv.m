function [s] = readSBScnv( target_file )

% function [s] = readSBScnv( target_file )
%
% DESCRIPTION:
% Read metadata and data from a Sea-Bird Scientific .cnv file. 
%
% INPUT:
%   target_file    =   path to .cnv file to be read into matlab. Currently
%                      the only output data field that crashes this script
%                      is modulo error. 
%
% OUTPUT: 
%   s    =   structure with all columns of data in the .cnv file and
%            metadata found in the header
%
%
% KiM MARTiNi 07.2017
% Sea-Bird Scientific 
% kmartini@seabird.com

% prestart some counters
blankcounter = 0; 
 
% open the file
fid = fopen( target_file );
% start reading the header lines
tline = fgetl(fid);
nheader = 1;

% add the filename
s.source = target_file;

while ~strncmp(tline, '*END*', 5)
    
    % divide header up into sections
    % Header infomration from the raw input data file
    if strncmp( tline, '* ', 2)
        % find the equal sign to split the data 
        equalind = regexp( tline, '=', 'once' );
        % if equal sign
        if ~isempty(equalind) 
            % split the line at the equal sign
            headernameinds = regexp( tline(1:equalind), '[\w]'); 
            headername = tline( headernameinds);
            % assign the information to a variable
            s.instrumentheaders.(headername) = strtrim(tline( equalind+1:end ) );
        % no equal sign    
        else 
            % find the data file name
            if ~isempty( regexp( tline, 'Data File', 'once') )
                s.DataFileType = tline(3:end-1);
            % find the software
            elseif ~isempty( regexp( tline, 'Seasave', 'once') )
                s.SeasaveVersion = tline(3:end); 
            end     
        end
        
    % Header information defined and input by the user  
    elseif strncmp( tline, '**', 2 )
        % split at the colon if it exists
        if ~isempty( regexp(tline, ':', 'once'))
            splitstr = regexp( tline, ':', 'split'); 
            % find the header name
            headername = regexp( splitstr{1}, '(?<=** )\w*', 'match');
        else
            splitstr = regexp( tline, '\S', 'split');
            % define a header name
            headername = {['blank', num2str(blankcounter)]};
            blankcounter = blankcounter+1; 
        end
        % assign the variable out
        s.userheaders.(headername{1}) = strtrim( strcat(splitstr{2:end}) );
        
    % Header information describing the converted data file (begins with #)
    elseif strncmp( tline, '# ', 2 )
        % split the line
%         sline = strsplit( tline );
        sline = regexp( tline, '\s*','split');

        % parse the name line
        if ~isempty( regexp( tline, '# name', 'once'))
            % pull the varaible number
            ind =  str2double( regexp( tline, '(?<= name )\d*', 'match'))+1; 
            % pull the variable name 
            varstr = regexp( tline, '\S*(?=:)', 'match'); 
            s.vars{ind} = varstr{1}; 
            % grab the units and the long name
            unitstr = regexp( tline, '(?<=\[)(.*)(?=\])', 'match'); 
            if ~isempty( unitstr )
                s.units{ind} = unitstr{1};
                longstr = regexp( tline, '(?<=: ).*(?= \[)', 'match');
            else
                s.units{ind}=' ';
                longstr = regexp( tline, '(?<=: ).*', 'match');
            end
            % grab the long name
            s.longname{ind} = longstr{1};
            
        % parse the span line    
        elseif ~isempty( regexp( tline, '# span', 'once'))
            ind = str2num(sline{3})+1;
            s.span{ind} = [str2num( sline{5}), str2num(sline{6})]; 
            
        % parse everything other # line
        elseif isempty( regexp( tline, '<', 'once') ) 
            % split the string at the equal sign
            splitstr = regexp( tline, ' =', 'split');
            varstr = regexp( splitstr{1}, '(?<=# )\w*', 'match');
            if length( splitstr ) > 1
                s.softwareheaders.(varstr{1}) = strtrim( strcat(splitstr{2:end}));
            else
                s.softwareheaders.(varstr{1}) = ' ';
            end
            
        end % if #
        
    end % if *, ** or #
   
    % now get a new line
    tline = fgetl(fid);
    % advance the number of header lines
    nheader = nheader+1;
end

% % add an empty field if no user headers
% if ~isfield( s, 'userheaders')
%     s.userheaders = [];
% end

% reorder the fields
fieldorder = {'source', 'DataFileType', 'SeasaveVersion',...
    'instrumentheaders', 'userheaders', 'softwareheaders',...
    'vars', 'longname', 'units', 'span'};

for ff = 1:length( fieldorder )
    if ~isfield( s, fieldorder{ff} )
        s.(fieldorder{ff}) = [];
    end
end
% % find the current field names
% fnames = fieldnames(s); 
% % make sure the list contains what is already in there
% for ff = 1:length( fnames )
%     fieldmatch(ff) = strmatch( fnames{ff}, fieldorder, 'exact');
% end
% % order the fields
% s = orderfields(s, fieldorder(fieldmatch));
s = orderfields( s, fieldorder ); 


% make a script to normalize the variable names to matlab readable
% conventions
s.mvars = {};
for vv = 1:length( s.vars )
    [s.mvars{vv}, s.mvars_format{vv}] = interpretSBSvariable(s.vars{vv});
end

% find if there are any unknowns
% using the format construct the field identifiers
% sb_fields = strjoin( s.kvars_format, ' ' );
% following code pilfered from strjoin.m Created by Dahua Lin, on Oct 9, 2008
ss = cell( 1, 2.*vv-1 );
ss(1:2:end) = s.mvars_format; 
[ss{2:2:end}] = deal( ' '); 
sb_fields = [ss{:}];

%  now pull the rest of the data
datin = textscan( fid, sb_fields );

% and add to the matrix
for vv = 1:length( s.vars)
    s.(s.mvars{vv}) = datin{vv};
end
    
% CLOSE THE FILE!
fclose( fid );
