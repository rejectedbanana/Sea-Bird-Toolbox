function [a] = findextension( targetdir, ext )

% function [a] = findextension( targetdir, ext )
%
%  Find the all the files with extension 'ext' in  directory specified by
%  'targetdir'.  For example ext = '.txt' or '.ASC'.  The search is not case
%  sensitive.
%
% KIM 08.12

% READ THE DIRECTORY CONTENTS
a=dir(targetdir);
% find the number of files in that folder
numfiles=length(a);
% FIND THE  FILES WITH EXTENSION 
ascindex = [];
for i=1:numfiles
    find_ext = strfind(lower(a(i).name), lower(ext)); 
    if ~isempty(find_ext) && find_ext(end)==length(a(i).name)-length(ext)+1
        ascindex = [ascindex; i]; 
    end
end
% IGNORE ALL FILES WITHOUT EXTENSION
a = a(ascindex); 
